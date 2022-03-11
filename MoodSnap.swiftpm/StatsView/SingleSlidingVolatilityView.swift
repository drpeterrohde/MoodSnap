import SwiftUI
import Charts

struct SingleSlidingVolatilityView: View {
    var type: MoodsEnum
    var timescale: TimeScaleEnum
    var data: DataStoreStruct
    
    var body: some View {
        let allSamples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
        let samples = allSamples[type.rawValue]
        let slidingVol = slidingVolatility(data: samples, windowSize: data.settings.slidingWindowSize)
        let entries = makeLineData(y: slidingVol)
        
        MultipleLineChart(entries: truncateEntriesArray(data: [entries], timescale: timescale), color: [UIColor.black], max: 2, guides: 2)
            .frame(height: 170)
    }
}
