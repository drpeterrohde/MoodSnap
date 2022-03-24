import SwiftUI
import Charts

struct PDFSingleSlidingAverageView: View {
    var type: MoodsEnum
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool
    
    var body: some View {
        let allSamples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
        let samples = allSamples[type.rawValue]
        let slidingAv = slidingAverage(data: samples, windowSize: data.settings.slidingWindowSize)
        let entries = makeLineData(y: slidingAv, timescale: timescale)
        
        if blackAndWhite {
            MultipleLineChart(entries: [entries], color: [UIColor.black])
                .frame(height: 170)
        } else {
            let color = moodUIColors(settings: data.settings)[type.rawValue]
            MultipleLineChart(entries: [entries], color: [color])
                .frame(height: 170)
        }
    }
}
