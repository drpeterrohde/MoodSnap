import SwiftUI

/**
 View for settings.
 */
struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager
    @State private var showingReportSheet = false
    @State private var showingImporter = false
    @State private var showingExporter = false
    @State private var showingImportAlert = false
    @State private var showingDeleteData = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("reminders")) {
                    Toggle(isOn: $data.settings.reminderOn[0], label: {
                        DatePicker("morning", selection: $data.settings.reminderTime[0], displayedComponents: .hourAndMinute)
                    })
                        .onChange(of: data.settings.reminderOn[0]) { _ in
                            toggleReminder(which: 0, settings: data.settings)
                        }
                        .onChange(of: data.settings.reminderTime[0]) { _ in
                            updateNotifications(settings: data.settings)
                        }
                    Toggle(isOn: $data.settings.reminderOn[1], label: {
                        DatePicker("evening", selection: $data.settings.reminderTime[1], displayedComponents: .hourAndMinute)
                    })
                        .onChange(of: data.settings.reminderOn[1]) { _ in
                            toggleReminder(which: 1, settings: data.settings)
                        }
                        .onChange(of: data.settings.reminderTime[1]) { _ in
                            updateNotifications(settings: data.settings)
                        }
                }

                Section(header: Text("accessibility")) {
                    Toggle(isOn: $data.settings.useFaceID, label: {
                        Text("use_lockscreen")
                    })

                    Picker("theme", selection: $data.settings.theme) {
                        ForEach(0 ..< themes.count, id: \.self) { i in
                            Text(.init(themes[i].name))
                                .tag(i)
                        }
                    }

                    Stepper(value: $data.settings.numberOfGridColumns, in: 1 ... 3, label: {
                        Text("grid_columns") + Text(" \(data.settings.numberOfGridColumns)")
                    })

                    if Locale.current.languageCode == "en" {
                        Toggle(isOn: $data.settings.quoteVisibility, label: {
                            Text("show_quotes")
                        })
                    }

                    Picker("measurement_units", selection: $data.settings.healthUnits) {
                        Text("metric")
                            .tag(MeasurementUnitsEnum.metric)
                        Text("imperial")
                            .tag(MeasurementUnitsEnum.imperial)
                    }
                }

                Section(header: Text("media")) {
                    Toggle(isOn: $data.settings.saveMediaToCameraRoll, label: {
                        Text("save_to_camera_roll")
                    })
                }

                Section(header: Text("PDF_report")) {
                    TextField("name_optional", text: $data.settings.username)
                    Picker("period", selection: $data.settings.reportPeriod) {
                        Text("1_month").tag(TimeScaleEnum.month.rawValue)
                        Text("3_months").tag(TimeScaleEnum.threeMonths.rawValue)
                        Text("6_months").tag(TimeScaleEnum.sixMonths.rawValue)
                        Text("1_year").tag(TimeScaleEnum.year.rawValue)
                    }
                    Toggle(isOn: $data.settings.reportBlackAndWhite, label: {
                        Text("black_and_white")
                    })
                    Toggle(isOn: $data.settings.includeNotes, label: {
                        Text("include_notes")
                    })

                    Button(action: {
                        showingReportSheet.toggle()
                    }) {
                        Text("generate_PDF_report")
                    }.sheet(isPresented: $showingReportSheet) {
                        ReportView(timescale: data.settings.reportPeriod, blackAndWhite: data.settings.reportBlackAndWhite)
                    }
                }

                Section(header: Text("import_export")) {
                    Button(action: {
                        if data.moodSnaps.count == 0 {
                            showingImporter.toggle()
                        } else {
                            showingImportAlert.toggle()
                        }
                    }) {
                        Text("import_backup_file")
                    }
                    Button(action: {
                        showingExporter.toggle()
                    }) {
                        Text("export_backup_file")
                    }
                }

                Section(header: Text("HEALTH")) {
                    Toggle(isOn: $data.settings.useHealthKit, label: {
                        Text("Use_Apple_Health")
                    })
                    Toggle(isOn: $data.settings.healthDistanceOn, label: {
                        Text("Walking_running_distance")
                    })
                        .disabled(!data.settings.useHealthKit)
                    Toggle(isOn: $data.settings.healthSleepOn, label: {
                        Text("Sleep")
                    })
                        .disabled(!data.settings.useHealthKit)
                    Toggle(isOn: $data.settings.healthEnergyOn, label: {
                        Text("Active_energy")
                    })
                        .disabled(!data.settings.useHealthKit)
                    Toggle(isOn: $data.settings.healthWeightOn, label: {
                        Text("Weight")
                    })
                        .disabled(!data.settings.useHealthKit)
                    Toggle(isOn: $data.settings.healthMenstrualOn, label: {
                        Text("Menstrual_cycle")
                    })
                        .disabled(!data.settings.useHealthKit)
                }

                Group {
                    Section(header: Text("symptom_visibility")) {
                        ForEach(0 ..< symptomList.count, id: \.self) { i in
                            Toggle(isOn: $data.settings.symptomVisibility[i], label: {
                                Text(.init(symptomList[i]))
                            })
                        }
                    }

                    Section(header: Text("activity_visibility")) {
                        ForEach(0 ..< activityList.count, id: \.self) { i in
                            Toggle(isOn: $data.settings.activityVisibility[i], label: {
                                Text(.init(activityList[i]))
                            })
                        }
                    }

                    Section(header: Text("social_visibility")) {
                        ForEach(0 ..< socialList.count, id: \.self) { i in
                            Toggle(isOn: $data.settings.socialVisibility[i], label: {
                                Text(.init(socialList[i]))
                            })
                        }
                    }
                }

                Section(header: Text("about")) {
                    HStack {
                        Text("website")
                        Spacer()
                        Text("[www.moodsnap.app](https://www.moodsnap.app)")
                    }
                    HStack {
                        Text("Twitter")
                        Spacer()
                        Text("[@moodsnapapp](https://twitter.com/moodsnapapp)")
                    }
                    HStack {
                        Text("developer")
                        Spacer()
                        Text("[Peter Rohde](https://www.peterrohde.org)")
                    }
                    HStack {
                        Text("moodsnaps_taken")
                        Spacer()
                        Text("\(data.moodSnapCount)")
                            .foregroundColor(.secondary)
                    }
                    if data.moodSnapCount > 0 {
                        HStack {
                            Text("first_moodsnap")
                            Spacer()
                            Text("\(data.firstDate)")
                                .foregroundColor(.secondary)
                        }
                    }
                    HStack {
                        Text("app_version")
                        Spacer()
                        Text(UIApplication.appVersion)
                            .foregroundColor(.secondary)
                    }
                }

                Section(header: Text("danger_zone")) {
                    Button(action: {
                        if data.moodSnaps.count == 0 {
                            DispatchQueue.main.async {
                                data.stopProcessing()
                                health.stopProcessing(data: data)
                                data.moodSnaps = makeDemoData()
                                data.startProcessing()
                                health.startProcessing(data: data)
                            }
                        } else {
                            showingImportAlert.toggle()
                        }
                    }) {
                        Text("load_demo_data")
                    }
                    Button(action: {
                        showingDeleteData.toggle()
                    }) {
                        Text("delete_all_data")
                            .foregroundColor(.red)
                    }
                }.alert(isPresented: $showingDeleteData) {
                    Alert(title: Text("sure_delete"), message: Text("cant_be_undone"), primaryButton: .destructive(Text("delete")) {
                        DispatchQueue.main.async {
                            data.stopProcessing()
                            health.stopProcessing(data: data)
                            data.moodSnaps = []
                            data.startProcessing()
                            health.startProcessing(data: data)
                        }
                        dismiss()
                    }, secondaryButton: .cancel())
                }
            }
            .fileExporter(isPresented: $showingExporter, document: JSONFile(string: encodeJSONString(moodSnaps: data.moodSnaps)), contentType: .json) { result in }
            .fileImporter(isPresented: $showingImporter, allowedContentTypes: [.json]) { res in
                do { // Attempt to import as DataStoreStruct
                    let fileUrl = try res.get()
                    let retrieved: DataStoreStruct = try decodeJSONString(url: fileUrl)

                    DispatchQueue.main.async {
                        data.stopProcessing()
                        health.stopProcessing(data: data)
                        
                        data.id = retrieved.id
                        data.version = retrieved.version
                        data.settings = retrieved.settings
                        data.uxState = retrieved.uxState
                        data.moodSnaps = retrieved.moodSnaps
                        data.healthSnaps = retrieved.healthSnaps
                        data.processedData = retrieved.processedData
                        
                        data.startProcessing()
                        health.startProcessing(data: data)
                    }
                } catch {
                    do { // Attempt to import as [MoodSnapStruct]
                        let fileUrl = try res.get()
                        let retrieved: [MoodSnapStruct] = try decodeJSONString(url: fileUrl)
                        
                        DispatchQueue.main.async {
                            data.stopProcessing()
                            health.stopProcessing(data: data)
                            data.moodSnaps = retrieved
                            data.startProcessing()
                            health.startProcessing(data: data)
                        }
                    } catch {
                    }
                }
                dismiss()
            }.alert(isPresented: $showingImportAlert) {
                Alert(title: Text("unable_to_import"), message: Text("unable_import_warning"), dismissButton: .default(Text("OK")))
            }.navigationBarTitle(Text("settings"))
        }
    }
}
