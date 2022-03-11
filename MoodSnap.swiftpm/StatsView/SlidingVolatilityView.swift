import SwiftUI
import Charts

struct SlidingVolatilityView: View {
    var timescale: TimeScaleEnum
    var data: DataStoreStruct
    
    var body: some View {
        let samples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
        
        let dataE = samples[0]
        let dataD = samples[1]
        let dataA = samples[2]
        let dataI = samples[3]
        
        let slidingVolE = slidingVolatility(data: dataE, windowSize: data.settings.slidingWindowSize)
        let slidingVolD = slidingVolatility(data: dataD, windowSize: data.settings.slidingWindowSize)
        let slidingVolA = slidingVolatility(data: dataA, windowSize: data.settings.slidingWindowSize)
        let slidingVolI = slidingVolatility(data: dataI, windowSize: data.settings.slidingWindowSize)
        
        let slidingVolEntriesE = makeLineData(y: slidingVolE)
        let slidingVolEntriesD = makeLineData(y: slidingVolD)
        let slidingVolEntriesA = makeLineData(y: slidingVolA)
        let slidingVolEntriesI = makeLineData(y: slidingVolI)
        
        let entries = [slidingVolEntriesE, slidingVolEntriesD, slidingVolEntriesA, slidingVolEntriesI]
        
        let color = moodUIColors(settings: data.settings)
        
        MultipleLineChart(entries: truncateEntriesArray(data: entries, timescale: timescale), color: color, max: 2, guides: 2)
            .frame(height: 170)
    }
}
