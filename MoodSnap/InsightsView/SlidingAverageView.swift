import SwiftUI
import Charts

/**
 View showing sliding average over given `timescale`.
 */
struct SlidingAverageView: View {
    var timescale: Int
    var data: DataStoreStruct
    
    var body: some View {
//        let entriesE = makeLineData(y: data.processedData.averageE, timescale: timescale)
//        let entriesD = makeLineData(y: data.processedData.averageD, timescale: timescale)
//        let entriesA = makeLineData(y: data.processedData.averageA, timescale: timescale)
//        let entriesI = makeLineData(y: data.processedData.averageI, timescale: timescale)
        
        let entriesE2 = makeLineData2(y: data.processedData.averageE, timescale: timescale)
        let entriesD2 = makeLineData2(y: data.processedData.averageD, timescale: timescale)
        let entriesA2 = makeLineData2(y: data.processedData.averageA, timescale: timescale)
        let entriesI2 = makeLineData2(y: data.processedData.averageI, timescale: timescale)
        
       // let entries = [entriesE, entriesD, entriesA, entriesI]
        let color = moodUIColors(settings: data.settings)
        
        if (data.moodSnaps.count == 0) {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            LineChart2(data: [entriesE2, entriesD2, entriesA2, entriesI2], color: [Color(color[0]), Color(color[1]), Color(color[2]), Color(color[3])], horizontalGridLines: 3, verticalGridLines: 0, blackAndWhite: false)
                .frame(height: 170)
//            MultipleLineChart(entries: entries, color: color)
//                .frame(height: 170)
        }
    }
}
