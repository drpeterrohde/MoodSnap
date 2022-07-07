import SwiftUI
import Charts

/**
 View for dislaying sliding volatility.
 */
struct SlidingVolatilityView: View {
    var timescale: Int
    var data: DataStoreClass
    
    var body: some View {
        let entriesE = makeLineData2(y: data.processedData.volatilityE, timescale: timescale)
        let entriesD = makeLineData2(y: data.processedData.volatilityD, timescale: timescale)
        let entriesA = makeLineData2(y: data.processedData.volatilityA, timescale: timescale)
        let entriesI = makeLineData2(y: data.processedData.volatilityI, timescale: timescale)
        let entries = [entriesE, entriesD, entriesA, entriesI]
        
        let color = moodUIColors(settings: data.settings)
        
        if (data.moodSnaps.count == 0) {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            LineChart(data: entries,
                       color: [Color(color[0]), Color(color[1]), Color(color[2]), Color(color[3])],
                       max: 2,
                       horizontalGridLines: 1,
                       verticalGridLines: 0,
                       blackAndWhite: false,
                       settings: data.settings)
                .frame(height: 170)
        }
    }
}
