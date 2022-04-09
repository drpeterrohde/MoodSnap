import SwiftUI

/**
 View showing history media `moodSnap`.
 */
struct HistoryMediaView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct

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
