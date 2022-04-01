import SwiftUI
import Charts

/**
 View for dislaying sliding volatility.
 */
struct SlidingVolatilityView: View {
    var timescale: Int
    var data: DataStoreStruct
    
    var body: some View {
        let entriesE = makeLineData(y: data.processedData.volatilityE, timescale: timescale)
        let entriesD = makeLineData(y: data.processedData.volatilityD, timescale: timescale)
        let entriesA = makeLineData(y: data.processedData.volatilityA, timescale: timescale)
        let entriesI = makeLineData(y: data.processedData.volatilityI, timescale: timescale)
        
        let entries = [entriesE, entriesD, entriesA, entriesI]
        
        let color = moodUIColors(settings: data.settings)
        
        if (data.moodSnaps.count == 0) {
            Text("Insufficient data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
        MultipleLineChart(entries: entries, color: color, max: 2, guides: 2)
            .frame(height: 170)
        }
    }
}
