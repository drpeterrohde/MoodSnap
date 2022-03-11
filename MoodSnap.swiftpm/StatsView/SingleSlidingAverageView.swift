import SwiftUI
import Charts

struct SingleSlidingAverageView: View {
    var type: MoodsEnum
    var timescale: TimeScaleEnum
    var data: DataStoreStruct
    
    var body: some View {
        let allSamples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
        let samples = allSamples[type.rawValue]
        let slidingAv = slidingAverage(data: samples, windowSize: data.settings.slidingWindowSize)
        let entries = makeLineData(y: slidingAv)
        
        MultipleLineChart(entries: truncateEntriesArray(data: [entries], timescale: timescale), color: [UIColor.black]).frame(height: 170)
    }
}
