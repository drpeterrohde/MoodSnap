import Charts
import SwiftUI

struct PDFSingleMoodHistoryBarView: View {
    var type: MoodsEnum
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool

    var body: some View {
        let entriesE = makeBarData(y: data.processedData.levelE, timescale: timescale)
        let entriesD = makeBarData(y: data.processedData.levelD, timescale: timescale)
        let entriesA = makeBarData(y: data.processedData.levelA, timescale: timescale)
        let entriesI = makeBarData(y: data.processedData.levelI, timescale: timescale)

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
