import Charts
import SwiftUI

struct PDFSingleSlidingAverageView: View {
    var type: MoodsEnum
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool

    var body: some View {
        let entriesE = makeBarData(y: data.processedData.averageE, timescale: timescale)
        let entriesD = makeBarData(y: data.processedData.averageD, timescale: timescale)
        let entriesA = makeBarData(y: data.processedData.averageA, timescale: timescale)
        let entriesI = makeBarData(y: data.processedData.averageI, timescale: timescale)

        let entries = [entriesE, entriesD, entriesA, entriesI]

        if blackAndWhite {
            VerticalBarChart(entries: entries[type.rawValue],
                             color: UIColor.black,
                             settings: data.settings).frame(height: 65)
        } else {
            let color = moodUIColors(settings: data.settings)[type.rawValue]
            VerticalBarChart(entries: entries[type.rawValue],
                             color: color,
                             settings: data.settings).frame(height: 65)
        }
    }
}
