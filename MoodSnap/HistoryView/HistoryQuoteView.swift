import SwiftUI

/**
 View showing history quote `moodSnap`.
 */
struct HistoryQuoteView: View {
    let moodSnap: MoodSnapStruct
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        Group {
            VStack(alignment: .center) {
                Spacer()
                Divider()
                Spacer()
                    .frame(height: 10)
                Text(.init(moodSnap.notes))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
