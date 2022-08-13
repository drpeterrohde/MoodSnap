import SwiftUI

/**
 View showing history diary entry `moodSnap`.
 */
struct HistoryNoteView: View {
    let moodSnap: MoodSnapStruct
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        if !String(moodSnap.notes).isEmpty {
            Group {
                Divider()
                Text(String(moodSnap.notes)).font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
