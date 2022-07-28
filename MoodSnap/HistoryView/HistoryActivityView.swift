import SwiftUI

/**
 View showing activity history.
 */
struct HistoryActivityView: View {
    let moodSnap: MoodSnapStruct
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)

        LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].historyGridSpacing) {
            ForEach(0 ..< activityList.count, id: \.self) { i in
                if moodSnap.activities[i] && data.settings.activityVisibility[i] {
                    Text(.init(activityList[i]))
                        .font(.caption)
                        .foregroundColor(themes[data.settings.theme].buttonColor)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}
