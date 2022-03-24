import SwiftUI
import Charts

struct PDFSingleSlidingVolatilityView: View {
    var type: MoodsEnum
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool
    
    var body: some View {
        let allSamples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
        let samples = allSamples[type.rawValue]
        let slidingVol = slidingVolatility(data: samples, windowSize: data.settings.slidingWindowSize)
        let entries = makeLineData(y: slidingVol, timescale: timescale)
        
        if blackAndWhite {
            MultipleLineChart(entries: [entries], color: [UIColor.black], max: 2, guides: 2)
                .frame(height: 170)
        } else {
            let color = moodUIColors(settings: data.settings)[type.rawValue]
            MultipleLineChart(entries: [entries], color: [color], max: 2, guides: 2)
                .frame(height: 170)
        }
    }
}
