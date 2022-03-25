import SwiftUI

struct HistoryQuoteView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct
    
    var body: some View {
        Group {
            VStack(alignment: .center) {
                Spacer()
                Divider()
                Spacer()
                    .frame(height: 10)
                Text(.init("\"" + moodSnap.notes + "\""))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
