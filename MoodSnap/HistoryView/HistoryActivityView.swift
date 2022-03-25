import SwiftUI

struct HistoryActivityView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct
    
    var body: some View {
        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)
        
        LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].historyGridSpacing) {
            ForEach(0..<activityList.count, id: \.self) {i in
                if (moodSnap.activities[activityListIndex[i]] && data.settings.activityVisibility[activityListIndex[i]]) {
                    Text(activityList[i])
                        .font(.caption)
                        .foregroundColor(themes[data.settings.theme].buttonColor)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}
