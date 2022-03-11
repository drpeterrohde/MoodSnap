import SwiftUI

struct HistoryNoteView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct
    
    var body: some View {
        if (!(String(moodSnap.notes).isEmpty)) {
            Group {
                Divider()
                Spacer()
                Text(String(moodSnap.notes)).font(.caption).padding(-5).frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
