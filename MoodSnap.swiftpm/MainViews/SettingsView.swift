import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var data: DataStoreStruct
    @State var firstname: String = ""
    @State private var showingReportSheet = false
    @State private var showingImporter = false
    @State private var showingExporter = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Reminders")) {
                    Toggle(isOn: $data.settings.reminderOn[0], label: {
                        DatePicker("Morning", selection: $data.settings.reminderTime[0], displayedComponents: .hourAndMinute)})
                        .onChange(of: data.settings.reminderOn[0]) {
                            newValue in toggleReminder(which: 0, settings: data.settings)}
                        .onChange(of: data.settings.reminderTime[0]) {
                            newValue in updateNotifications(settings: data.settings)
                        }
                    Toggle(isOn: $data.settings.reminderOn[1], label: {
                        DatePicker("Evening", selection: $data.settings.reminderTime[1], displayedComponents: .hourAndMinute)})
                        .onChange(of: data.settings.reminderOn[1]) {
                            newValue in toggleReminder(which: 1, settings: data.settings)}
                        .onChange(of: data.settings.reminderTime[1]) {
                            newValue in updateNotifications(settings: data.settings)
                        }
                }
                
                Section(header: Text("Accessibility")) {
                    Picker("Theme", selection: $data.settings.theme) {
                        ForEach(0..<themes.count) {i in
                            Text(themes[i].name)
                        }
                    }
                    
                    Stepper(value: $data.settings.numberOfGridColumns, in: 1...3, label: {
                        Text("Grid columns: \(data.settings.numberOfGridColumns)")
                    })
                }
                
                Section(header: Text("Media")) {
                    Toggle(isOn: $data.settings.saveMediaToCameraRoll, label: {
                        Text("Save media to camera roll")
                    })
                }
                
                Section(header: Text("Symptom visibility")) {
                    ForEach(0..<symptomList.count) {i in
                        Toggle(isOn: $data.settings.symptomVisibility[i], label: {
                            Text(symptomList[i])
                        })
                    }
                }
                
                Section(header: Text("Activity visibility")) {
                    ForEach(0..<activityList.count) {i in
                        Toggle(isOn: $data.settings.activityVisibility[i], label: {
                            Text(activityList[i])
                        })
                    }
                }
                
                Section(header: Text("Social visibility")) {
                    ForEach(0..<socialList.count) {i in
                        Toggle(isOn: $data.settings.socialVisibility[i], label: {
                            Text(socialList[i])
                        })
                    }
                }
                
                Section(header: Text("HealthKit")) {
                    Toggle(isOn: $data.settings.healthDistanceOn , label: {
                        Text("Walking & running distance")
                    })
                    Toggle(isOn: $data.settings.healthSleepOn , label: {
                                                Text("Sleep")
                    })
                    Toggle(isOn: $data.settings.healthWeightOn , label: {
                        Text("Weight")
                    })
                    Toggle(isOn: $data.settings.healthMenstrualOn , label: {
                        Text("Menstrual cycle")
                    })
                }
                
                Section(header: Text("PDF report")) {
                    TextField("Name (optional)", text: $data.settings.username)
                    Picker("Period", selection: $data.settings.reportPeriod) {
                        Text("1 month").tag(TimeScaleEnum.month)
                        Text("3 months").tag(TimeScaleEnum.threeMonths)
                        Text("6 months").tag(TimeScaleEnum.sixMonths)
                        Text("1 year").tag(TimeScaleEnum.year)
                    }
                    Toggle(isOn: $data.settings.includeNotes, label: {
                        Text("Include notes")
                    })
//                    Toggle(isOn: $data.settings.includeActivities, label: {
//                        Text("Include activities")
//                    })
//                    Toggle(isOn: $data.settings.includeEvents, label: {
//                        Text("Include events")
//                    })
//                    Picker("Theme", selection: $data.settings.reportTheme) {
//                        Text("Color").tag(0)
//                        Text("Black & white").tag(1)
//                    }
                    
                    Button(action: {
                        showingReportSheet.toggle()
                    }) {
                        Text("Generate PDF report")
                    }.sheet(isPresented: $showingReportSheet) {
                        ReportView(data: data)
                    }
                }
                
                Section(header: Text("Import/Export")) {
                    Button(action: {
                        showingImporter.toggle()
                    }) {
                        Text("Import backup file")
                    }
                    Button(action: {
                        showingExporter.toggle()
                    }) {
                        Text("Export backup file")
                    }
                }
                
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
                    }
                }
            }.fileExporter(isPresented: $showingExporter, document: JSONFile(string: encodeJSONString(data: data)), contentType: .plainText) { result in
                switch result {
                case .success(let url):
                    print("Saved to \(url)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .fileImporter(isPresented: $showingImporter, allowedContentTypes: [.json]) { (res) in
                do {
                    let fileUrl = try res.get()
                    //let fileName = fileUrl.lastPathComponent
                    fileUrl.startAccessingSecurityScopedResource()
                    let rawData = try Data(contentsOf: fileUrl)
                    //let str = decodeJSONString(data: rawData)
                    //data = decodeJSONString(data: str)!
                    data = try! JSONDecoder().decode(DataStoreStruct.self, from: rawData)
                    fileUrl.stopAccessingSecurityScopedResource()
                } catch{
                    print ("Failed to import backup file")
                    print (error.localizedDescription)
                }
            }
            .navigationBarTitle(Text("Settings"))
        }
    }
}
