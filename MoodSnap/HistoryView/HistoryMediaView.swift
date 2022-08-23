import SwiftUI

/**
 View showing history media `moodSnap`.
 */
struct HistoryMediaView: View {
    let moodSnap: MoodSnapStruct
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        Group {
            Divider()
            Spacer()
            if let image = UIImage.loadImageFromDiskWith(fileName: moodSnap.id.uuidString) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
