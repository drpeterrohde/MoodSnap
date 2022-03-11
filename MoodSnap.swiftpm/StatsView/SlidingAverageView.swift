import SwiftUI
import Charts

struct SlidingAverageView: View {
    var timescale: TimeScaleEnum
    var data: DataStoreStruct
    
    var body: some View {
        let samples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
        
        let dataE = samples[0]
        let dataD = samples[1]
        let dataA = samples[2]
        let dataI = samples[3]
        
        let slidingAvE = slidingAverage(data: dataE, windowSize: data.settings.slidingWindowSize)
        let slidingAvD = slidingAverage(data: dataD, windowSize: data.settings.slidingWindowSize)
        let slidingAvA = slidingAverage(data: dataA, windowSize: data.settings.slidingWindowSize)
        let slidingAvI = slidingAverage(data: dataI, windowSize: data.settings.slidingWindowSize)
        
        let slidingAvEntriesE = makeLineData(y: slidingAvE)
        let slidingAvEntriesD = makeLineData(y: slidingAvD)
        let slidingAvEntriesA = makeLineData(y: slidingAvA)
        let slidingAvEntriesI = makeLineData(y: slidingAvI)
        
        let entries = [slidingAvEntriesE, slidingAvEntriesD, slidingAvEntriesA, slidingAvEntriesI]
        
        let color = moodUIColors(settings: data.settings)
        
            MultipleLineChart(entries: truncateEntriesArray(data: entries, timescale: timescale), color: color).frame(height: 170)
    }
}
