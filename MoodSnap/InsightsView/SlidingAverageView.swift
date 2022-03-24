import SwiftUI
import Charts

struct SlidingAverageView: View {
    var timescale: Int
    var data: DataStoreStruct
    
    var body: some View {
        let entriesE = makeLineData(y: data.processedData.averageE, timescale: timescale)
        let entriesD = makeLineData(y: data.processedData.averageD, timescale: timescale)
        let entriesA = makeLineData(y: data.processedData.averageA, timescale: timescale)
        let entriesI = makeLineData(y: data.processedData.averageI, timescale: timescale)
        
        let entries = [entriesE, entriesD, entriesA, entriesI]
        let color = moodUIColors(settings: data.settings)
        
        if (data.moodSnaps.count == 0) {
            Text("Insufficient data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            MultipleLineChart(entries: entries, color: color).frame(height: 170)
        }
    }
}
