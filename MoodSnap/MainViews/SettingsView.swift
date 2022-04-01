import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var data: DataStoreStruct
    @State var firstname: String = ""
    @State private var showingReportSheet = false
    @State private var showingImporter = false
    @State private var showingExporter = false
    @State private var showingImportAlert = false
    @State private var showingDeleteData = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Reminders")) {
                    Toggle(isOn: $data.settings.reminderOn[0], label: {
                        DatePicker("Morning", selection: $data.settings.reminderTime[0], displayedComponents: .hourAndMinute)
                    })
                        .onChange(of: data.settings.reminderOn[0]) {
                            _ in toggleReminder(which: 0, settings: data.settings)
                        }
                        .onChange(of: data.settings.reminderTime[0]) {
                            _ in updateNotifications(settings: data.settings)
                        }
                    Toggle(isOn: $data.settings.reminderOn[1], label: {
                        DatePicker("Evening", selection: $data.settings.reminderTime[1], displayedComponents: .hourAndMinute)
                    })
                        .onChange(of: data.settings.reminderOn[1]) {
                            _ in toggleReminder(which: 1, settings: data.settings)
                        }
                        .onChange(of: data.settings.reminderTime[1]) {
                            _ in updateNotifications(settings: data.settings)
                        }
                }

                Section(header: Text("Accessibility")) {
//                    Toggle(isOn: $data.settings.useFaceID, label: {
//                        Text("Use FaceID")
//                    })

                    Picker("Theme", selection: $data.settings.theme) {
                        ForEach(0 ..< themes.count, id: \.self) { i in
                            Text(themes[i].name).tag(i)
                        }
                    }

                    Stepper(value: $data.settings.numberOfGridColumns, in: 1 ... 3, label: {
                        Text("Grid columns: \(data.settings.numberOfGridColumns)")
                    })

                    Toggle(isOn: $data.settings.quoteVisibility, label: {
                        Text("Show quotes")
                    })
                }

                Section(header: Text("Media")) {
                    Toggle(isOn: $data.settings.saveMediaToCameraRoll, label: {
                        Text("Save media to camera roll")
                    })
                }

                Section(header: Text("PDF report")) {
                    TextField("Name (optional)", text: $data.settings.username)
                    Picker("Period", selection: $data.settings.reportPeriod) {
                        Text("1 month").tag(TimeScaleEnum.month.rawValue)
                        Text("3 months").tag(TimeScaleEnum.threeMonths.rawValue)
                        Text("6 months").tag(TimeScaleEnum.sixMonths.rawValue)
                        Text("1 year").tag(TimeScaleEnum.year.rawValue)
                    }
                    Toggle(isOn: $data.settings.reportBlackAndWhite, label: {
                        Text("Black & white")
                    })
                    Toggle(isOn: $data.settings.reportIncludeInterpretation, label: {
                        Text("Include guide")
                    })
                    Toggle(isOn: $data.settings.includeNotes, label: {
                        Text("Include notes")
                    })

                    Button(action: {
                        showingReportSheet.toggle()
                    }) {
                        Text("Generate PDF report")
                    }.sheet(isPresented: $showingReportSheet) {
                        ReportView(data: data, timescale: data.settings.reportPeriod, blackAndWhite: data.settings.reportBlackAndWhite)
                    }
                }

                Section(header: Text("Import/Export")) {
                    Button(action: {
                        if data.moodSnaps.count == 0 {
                            showingImporter.toggle()
                        } else {
                            showingImportAlert.toggle()
                        }
                    }) {
                        Text("Import backup file")
                    }
                    Button(action: {
                        showingExporter.toggle()
                    }) {
                        Text("Export backup file")
                    }
                }.alert(isPresented: $showingImportAlert) {
                    Alert(title: Text("Unable to import"), message: Text("You can only import a backup file into an empty MoodSnap history. You must delete exisiting data first."), dismissButton: .default(Text("OK")))
                }

                Group {
                    Section(header: Text("Symptom visibility")) {
                        ForEach(0 ..< symptomList.count, id: \.self) { i in
                            Toggle(isOn: $data.settings.symptomVisibility[i], label: {
                                Text(symptomList[i])
                            })
                        }
                    }

                    Section(header: Text("Activity visibility")) {
                        ForEach(0 ..< activityList.count, id: \.self) { i in
                            Toggle(isOn: $data.settings.activityVisibility[i], label: {
                                Text(activityList[i])
                            })
                        }
                    }

                    Section(header: Text("Social visibility")) {
                        ForEach(0 ..< socialList.count, id: \.self) { i in
                            Toggle(isOn: $data.settings.socialVisibility[i], label: {
                                Text(socialList[i])
                            })
                        }
                    }
                }

//                Section(header: Text("Health")) {
//                    Toggle(isOn: $data.settings.healthDistanceOn , label: {
//                        Text("Walking & running distance")
//                    })
//                    Toggle(isOn: $data.settings.healthSleepOn , label: {
//                                                Text("Sleep")
//                    })
//                    Toggle(isOn: $data.settings.healthEnergyOn , label: {
//                        Text("Active energy")
//                    })
//                    Toggle(isOn: $data.settings.healthWeightOn , label: {
//                        Text("Weight")
//                    })
//                    Toggle(isOn: $data.settings.healthMenstrualOn , label: {
//                        Text("Menstrual cycle")
//                    })
//                }

                Section(header: Text("About")) {
                    HStack {
                        Text("Website")
                        Spacer()
                        Text("[www.moodsnap.app](https://www.moodsnap.app)")
                    }
                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("[Peter Rohde](https://www.peterrohde.org)")
                    }
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(versionString)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("MoodSnaps taken")
                        Spacer()
                        Text("\(countMoodSnaps(moodSnaps: data.moodSnaps))")
                            .foregroundColor(.secondary)
                    }
                    if data.moodSnaps.count > 0 {
                        HStack {
                            Text("First MoodSnap")
                            Spacer()
                            Text("\(getFirstDate(moodSnaps: data.moodSnaps).dateString())")
                                .foregroundColor(.secondary)
                        }
                    }
                }

                Section(header: Text("Danger zone")) {
                    Button(action: {
                        if data.moodSnaps.count == 0 {
                            DispatchQueue.global(qos: .userInteractive).async {
                                data.moodSnaps = makeDemoData()
                                data.process()
                                data.save()
                            }
                        }
                    }) {
                        Text("Load demo data")
                    }
                    Button(action: {
                        showingDeleteData.toggle()
                    }) {
                        Text("Delete all data").foregroundColor(.red)
                    }
                }.alert(isPresented: $showingDeleteData) {
                    Alert(title: Text("Are you sure you want to delete all data?"), message: Text("There action cannot be undone."), primaryButton: .destructive(Text("Delete")) {
                        data.moodSnaps = []
                        data.process()
                        data.save()
                        dismiss()
                    }, secondaryButton: .cancel())
                }
            }.fileExporter(isPresented: $showingExporter, document: JSONFile(string: encodeJSONString(data: data)), contentType: .plainText) { result in
                switch result {
                case .success: // .success(let url):
                    break // print("Saved to \(url)")
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .fileImporter(isPresented: $showingImporter, allowedContentTypes: [.json]) { res in
                do {
                    let fileUrl = try res.get()
                    data = decodeJSONString(url: fileUrl)
                    DispatchQueue.global(qos: .userInteractive).async {
                        data.process()
                        data.save()
                    }
                } catch {
                    print("Failed to import backup file")
                    print(error.localizedDescription)
                }
                dismiss()
            }
            .navigationBarTitle(Text("Settings"))
        }
    }
}
