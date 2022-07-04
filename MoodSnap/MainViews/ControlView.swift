import SwiftUI

/**
 View with controls.
 */
struct ControlView: View {
    @Binding var data: DataStoreStruct
    @Binding var health: HealthManager
    @State private var showingMoodSnapSheet: Bool = false
    @State private var showingSettingsSheet: Bool = false
    @State private var showingStatsSheet: Bool = false
    @State private var showingEmergencySheet: Bool = false
    @State private var showingHelpSheet: Bool = false
    @State private var showingNoteSheet: Bool = false
    @State private var showingEventSheet: Bool = false
    @State private var showingMediaSheet: Bool = false
    @State private var showingIntroPopover: Bool = false

    init(data: Binding<DataStoreStruct>, health: Binding<HealthManager>) {
        _data = data
        _health = health
        showingMoodSnapSheet = false
        showingSettingsSheet = false
        showingStatsSheet = false
        showingEmergencySheet = false
        showingHelpSheet = false
        showingNoteSheet = false
        showingEventSheet = false
        showingMediaSheet = false
        showingIntroPopover = self.data.settings.firstUse
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
                }.sheet(isPresented: $showingSettingsSheet) {
                    SettingsView(data: $data)
                }

                Spacer()

                Button(action: {
                    showingStatsSheet.toggle()
                }) {
                    Image(systemName: "waveform.path.ecg.rectangle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize)
                        .foregroundColor(themes[data.settings.theme].controlColor)
                }.sheet(isPresented: $showingStatsSheet) {
                    InsightsView(data: $data, health: $health)
                }

                Spacer()

                Button(action: {
                    showingEventSheet.toggle()
                }) {
                    Image(systemName: "star.square")
                        .resizable()
                        .scaledToFill()
                        .frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize)
                        .foregroundColor(themes[data.settings.theme].controlColor)
                }.sheet(isPresented: $showingEventSheet) {
                    EventView(moodSnap: MoodSnapStruct(), data: $data)
                }

                Spacer()
            }

            Button(action: {
                showingMoodSnapSheet.toggle()
            }) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: themes[data.settings.theme].controlBigIconSize, height: themes[data.settings.theme].controlBigIconSize)
                    .foregroundColor(themes[data.settings.theme].controlColor)
            }.sheet(isPresented: $showingMoodSnapSheet) {
                MoodSnapView(moodSnap: MoodSnapStruct(), data: $data)
            }

            Group {
                Spacer()

                Button(action: {
                    showingNoteSheet.toggle()
                }) {
                    Image(systemName: "note.text.badge.plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize)
                        .foregroundColor(themes[data.settings.theme].controlColor)
                }.sheet(isPresented: $showingNoteSheet) {
                    NoteView(moodSnap: MoodSnapStruct(), data: $data)
                }

                Spacer()

                Button(action: {
                    showingMediaSheet.toggle()
                }) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFill()
                        .frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize)
                        .foregroundColor(themes[data.settings.theme].controlColor)
                }.sheet(isPresented: $showingMediaSheet) {
                    MediaView(moodSnap: MoodSnapStruct(), data: $data)
                }

                Spacer()

                Button(action: {
                    showingHelpSheet.toggle()
                }) {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: themes[data.settings.theme].controlIconSize, height: themes[data.settings.theme].controlIconSize)
                        .foregroundColor(themes[data.settings.theme].controlColor)
                }.sheet(isPresented: $showingHelpSheet) {
                    HelpView(data: $data)
                }
                Spacer()
            }
        }.sheet(isPresented: $showingIntroPopover) {
            IntroPopoverView(data: data)
        }
    }
}
