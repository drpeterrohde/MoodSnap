import SwiftUI
import Charts

struct SingleMoodHistoryBarView: View {
    var type: MoodsEnum
    var timescale: TimeScaleEnum
    var data: DataStoreStruct
    
    var body: some View {
        let allSamples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
        let samples = allSamples[type.rawValue]
        let entries = makeBarData(y: samples)
        
        VerticalBarChart(entries: truncateEntries(data: entries, timescale: timescale),
                         color: UIColor.black,
                         settings: data.settings).frame(height: 65)
    }
}
