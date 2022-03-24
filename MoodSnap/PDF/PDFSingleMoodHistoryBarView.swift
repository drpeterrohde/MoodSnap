import SwiftUI
import Charts

struct PDFSingleMoodHistoryBarView: View {
    var type: MoodsEnum
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool
    
    var body: some View {
        let allSamples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
        let samples = allSamples[type.rawValue]
        let entries = makeBarData(y: samples, timescale: timescale)
        
        if blackAndWhite {
            VerticalBarChart(entries: entries,
                         color: UIColor.black,
                         settings: data.settings).frame(height: 65)
        } else {
            let color = moodUIColors(settings: data.settings)[type.rawValue]
            VerticalBarChart(entries: entries,
                             color: color,
                             settings: data.settings).frame(height: 65)
        }
    }
}
