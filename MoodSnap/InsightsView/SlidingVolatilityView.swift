import SwiftUI

/**
 View for dislaying sliding volatility.
 */
struct SlidingVolatilityView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {
        let entriesE = makeLineData(y: data.processedData.volatilityE, timescale: timescale)
        let entriesD = makeLineData(y: data.processedData.volatilityD, timescale: timescale)
        let entriesA = makeLineData(y: data.processedData.volatilityA, timescale: timescale)
        let entriesI = makeLineData(y: data.processedData.volatilityI, timescale: timescale)
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
        }
    }
}
