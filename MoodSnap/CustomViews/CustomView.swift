import SwiftUI

struct HistoryCustomView: View {
    var which: Int
    var data: DataStoreStruct
    
    var body: some View {
        EmptyView()
    }
}

func makeIntroSnap() -> [MoodSnapStruct] {
    var mediaSnap = MoodSnapStruct()
    mediaSnap.snapType = .custom
    mediaSnap.customView = 1
    return [mediaSnap]
}
