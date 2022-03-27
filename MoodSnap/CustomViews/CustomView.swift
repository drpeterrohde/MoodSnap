import SwiftUI

struct HistoryCustomView: View {
    var which: Int
    var data: DataStoreStruct

    var body: some View {
        if which == 1 {
            Group {
                VStack(alignment: .center) {
                    Divider()
                    Spacer()
                        .frame(height: 10)
                    Text(String(intro_snap_title))
                        .font(.caption)
                        .fontWeight(.bold)
                    Divider()
                    Text(String(intro_snap_notes))
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    VStack(alignment: .center) {
                        Text("Controls")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: 2)
                        LazyVGrid(columns: gridItemLayout, alignment: .leading, spacing: themes[data.settings.theme].historyGridSpacing) {
                            Label("Settings", systemImage: "slider.horizontal.3")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("Insights", systemImage: "waveform.path.ecg.rectangle")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("Add event", systemImage: "star.square")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("Take MoodSnap", systemImage: "plus.circle")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("Diary entry", systemImage: "note.text.badge.plus")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("Photo diary", systemImage: "photo.on.rectangle.angled")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("Help", systemImage: "questionmark.circle")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }

        if which == 0 {
            EmptyView()
        }
    }
}

func makeIntroSnap() -> [MoodSnapStruct] {
    var mediaSnap = MoodSnapStruct()
    mediaSnap.snapType = .custom
    mediaSnap.customView = 1
    return [mediaSnap]
}
