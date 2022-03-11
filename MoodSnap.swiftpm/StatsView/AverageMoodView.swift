import SwiftUI

struct AverageMoodView: View {
    var timescale: TimeScaleEnum
    var data: DataStoreStruct
    var blackAndWhite: Bool = false
    
    var body: some View {
        let averageMoodSnap = averageMoodSnap(timescale: timescale, data: data)
        if (averageMoodSnap != nil) {
            MoodLevelsView(moodSnap: averageMoodSnap!, data: data, blackAndWhite: blackAndWhite)
        } else {
            VStack(alignment: .center) {
                Text("Insufficient data")
            }
        }
    }
}
