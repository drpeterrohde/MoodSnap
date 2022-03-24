import SwiftUI

struct HistoryTipView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct
    
    var body: some View {
        Group {
            VStack(alignment: .center){
                if moodSnap.event != "" {
                Divider()
                Spacer().frame(height: 10)
                Text(String(moodSnap.event))
                    .font(.caption)
                    .fontWeight(.bold)
                }
                if moodSnap.notes != "" {
                Divider()
                Text(String(moodSnap.notes))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
