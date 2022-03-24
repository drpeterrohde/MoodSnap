import SwiftUI

struct HistoryEventView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct
    
    var body: some View {
        Group {
            VStack(alignment: .center) {
                Divider()
                Spacer()
                    .frame(height: 10)
                Text(String(moodSnap.event))
                    .font(.caption)
                    .fontWeight(.bold)
                
                if (!(String(moodSnap.notes).isEmpty)) {
                    Divider()
                    Text(String(moodSnap.notes)).font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
