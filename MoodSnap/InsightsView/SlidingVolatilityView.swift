import SwiftUI
import Charts

/**
 View for dislaying sliding volatility.
 */
struct SlidingVolatilityView: View {
    var timescale: Int
    var data: DataStoreStruct
    
    var body: some View {
//        let entriesE = makeLineData(y: data.processedData.volatilityE, timescale: timescale)
//        let entriesD = makeLineData(y: data.processedData.volatilityD, timescale: timescale)
//        let entriesA = makeLineData(y: data.processedData.volatilityA, timescale: timescale)
//        let entriesI = makeLineData(y: data.processedData.volatilityI, timescale: timescale)
        
        let entriesE2 = makeLineData2(y: data.processedData.volatilityE, timescale: timescale)
        let entriesD2 = makeLineData2(y: data.processedData.volatilityD, timescale: timescale)
        let entriesA2 = makeLineData2(y: data.processedData.volatilityA, timescale: timescale)
        let entriesI2 = makeLineData2(y: data.processedData.volatilityI, timescale: timescale)
        
       // let entries = [entriesE, entriesD, entriesA, entriesI]
        
        let color = moodUIColors(settings: data.settings)
        
        if (data.moodSnaps.count == 0) {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            LineChart2(data: [entriesE2, entriesD2, entriesA2, entriesI2], color: [Color(color[0]), Color(color[1]), Color(color[2]), Color(color[3])], max: 2, horizontalGridLines: 1, verticalGridLines: 0, blackAndWhite: false)
                .frame(height: 170)
       // MultipleLineChart(entries: entries, color: color, max: 2, guides: 2)
         //   .frame(height: 170)
        }
    }
}
