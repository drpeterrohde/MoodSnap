import SwiftUI

struct HistoryNoteView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct
    
    var body: some View {
        if (!(String(moodSnap.notes).isEmpty)) {
            Group {
                Divider()
                Text(String(moodSnap.notes)).font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}