import SwiftUI

struct ControlView: View {
    @Binding var data: DataStoreStruct
    @State private var showingMoodSnapSheet = false
    @State private var showingSettingsSheet = false
    @State private var showingStatsSheet = false
    @State private var showingEmergencySheet = false
    @State private var showingHelpSheet = false
    @State private var showingNoteSheet = false
    @State private var showingEventSheet = false
    @State private var showingMediaSheet = false
    @State private var showingIntroPopover = false

    init(data: Binding<DataStoreStruct>) {
        self._data = data
        self.showingMoodSnapSheet = false
        self.showingSettingsSheet = false
        self.showingStatsSheet = false
        self.showingEmergencySheet = false
        self.showingHelpSheet = false
        self.showingNoteSheet = false
        self.showingEventSheet = false
        self.showingMediaSheet = false
        self.showingIntroPopover = self.data.settings.firstUse
    }
    
    var body: some View {
        Divider()
        HStack {
            Group {
                Spacer()

                Button(action: {
                    showingSettingsSheet.toggle()
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize)
                        .foregroundColor(themes[data.settings.theme].controlColor)
                }.sheet(isPresented: $showingSettingsSheet, onDismiss: { data.save() }) {
                    SettingsView(data: $data)
                }

                Spacer()

                Button(action: {
                    showingStatsSheet.toggle()
                }) {
                    Image(systemName: "waveform.path.ecg.rectangle").resizable().scaledToFill().frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize).foregroundColor(themes[data.settings.theme].controlColor).sheet(isPresented: $showingStatsSheet) {
                        InsightsView(data: $data)
                    }
                }

                Spacer()

                Button(action: {
                    showingEventSheet.toggle()
                }) {
                    Image(systemName: "star.square").resizable().scaledToFill().frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize).foregroundColor(themes[data.settings.theme].controlColor)
                }.sheet(isPresented: $showingEventSheet) {
                    EventView(moodSnap: MoodSnapStruct(), data: $data)
                }

                Spacer()
            }

            Button(action: {
                showingMoodSnapSheet.toggle()
            }) {
                Image(systemName: "plus.circle").resizable().scaledToFill().frame(width: themes[data.settings.theme].controlBigIconSize, height: themes[data.settings.theme].controlBigIconSize).foregroundColor(themes[data.settings.theme].controlColor)
            }.sheet(isPresented: $showingMoodSnapSheet) {
                MoodSnapView(moodSnap: MoodSnapStruct(), data: $data)
            }

            Group {
                Spacer()

                Button(action: {
                    showingNoteSheet.toggle()
                }) {
                    Image(systemName: "note.text.badge.plus").resizable().scaledToFill().frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize).foregroundColor(themes[data.settings.theme].controlColor)
                }.sheet(isPresented: $showingNoteSheet) {
                    NoteView(moodSnap: MoodSnapStruct(), data: $data)
                }

                Spacer()

                Button(action: {
                    showingMediaSheet.toggle()
                }) {
                    Image(systemName: "photo.on.rectangle.angled").resizable().scaledToFill().frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize).foregroundColor(themes[data.settings.theme].controlColor)
                }.sheet(isPresented: $showingMediaSheet) {
                    MediaView(moodSnap: MoodSnapStruct(), data: $data)
                }

                Spacer()

                Button(action: {
                    showingHelpSheet.toggle()
                }) {
                    Image(systemName: "questionmark.circle").resizable().scaledToFill().frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize).foregroundColor(themes[data.settings.theme].controlColor)
                }.sheet(isPresented: $showingHelpSheet) {
                    HelpView(data: $data)
                }
                Spacer()
            }
        }.popover(isPresented: $showingIntroPopover) {
            IntroPopoverView(data: data)
                .onDisappear {
                    data.settings.firstUse = false
                    data.save()
                }
        }
    }
}
