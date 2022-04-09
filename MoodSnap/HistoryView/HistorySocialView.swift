import SwiftUI

/**
 View showing social activity history.
 */
struct HistorySocialView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct

    var body: some View {
        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)

        LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].historyGridSpacing) {
            ForEach(0 ..< socialList.count, id: \.self) { i in
                if moodSnap.social[i] && data.settings.socialVisibility[i] {
                    Text(socialList[i])
                        .font(.caption)
                        .foregroundColor(themes[data.settings.theme].buttonColor)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}
