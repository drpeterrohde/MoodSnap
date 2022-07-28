import SwiftUI

/**
 View for dislpaying custom history item.
 */
struct HistoryCustomView: View {
    var which: Int
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        if which == 1 {
            Group {
                VStack(alignment: .center) {
                    Group {
                        Divider()
                        Spacer()
                            .frame(height: 10)
                        Text(.init("intro_snap_title"))
                            .font(.caption)
                            .fontWeight(.bold)
                        Divider()
                        Text(.init("intro_snap_notes"))
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                        Text(.init("intro_snap_quickstart"))
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Divider()
                    VStack(alignment: .center) {
                        Text("controls")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: 2)
                        LazyVGrid(columns: gridItemLayout, alignment: .leading, spacing: themes[data.settings.theme].historyGridSpacing) {
                            Label("settings", systemImage: "slider.horizontal.3")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("insights", systemImage: "waveform.path.ecg.rectangle")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("add_event", systemImage: "star.square")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("take_moodsnap", systemImage: "plus.circle")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("diary_entry", systemImage: "note.text.badge.plus")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("photo_diary", systemImage: "photo.on.rectangle.angled")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("help", systemImage: "questionmark.circle")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                            Label("save", systemImage: "arrowtriangle.right.circle")
                                .foregroundColor(themes[data.settings.theme].iconColor)
                                .font(.subheadline)
                        }
                    }
                    Divider()
                    Text(.init("intro_snap_tip"))
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }

        if which == 0 {
            EmptyView()
        }
    }
}
