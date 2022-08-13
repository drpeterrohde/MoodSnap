import SwiftUI

/**
 View showing history event `moodSnap`.
 */
struct HistoryEventView: View {
    let moodSnap: MoodSnapStruct
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        Group {
            VStack(alignment: .center) {
                Divider()
                Spacer()
                    .frame(height: 10)
                Text(String(moodSnap.event))
                    .font(.caption)
                    .fontWeight(.bold)

                if !String(moodSnap.notes).isEmpty {
                    Divider()
                    Text(String(moodSnap.notes)).font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
