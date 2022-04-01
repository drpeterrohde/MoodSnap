import SwiftUI

/**
 View showing symptom list.
 */
struct HistorySymptomsView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct
    
    var body: some View {
        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)
        
        LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].historyGridSpacing) {
            ForEach(0..<symptomList.count, id: \.self) {i in
                if (moodSnap.symptoms[i] && data.settings.symptomVisibility[i]) {
                    Text(symptomList[i])
                        .font(.caption)
                        .foregroundColor(themes[data.settings.theme].buttonColor)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}
