import Charts
import SwiftUI

struct PDFSingleSlidingVolatilityView: View {
    var type: MoodsEnum
    var timescale: Int
    var data: DataStoreClass
    var blackAndWhite: Bool

    var body: some View {
        let entriesE = makeBarData(y: data.processedData.volatilityE, timescale: timescale)
        let entriesD = makeBarData(y: data.processedData.volatilityD, timescale: timescale)
        let entriesA = makeBarData(y: data.processedData.volatilityA, timescale: timescale)
        let entriesI = makeBarData(y: data.processedData.volatilityI, timescale: timescale)

        let entries = [entriesE, entriesD, entriesA, entriesI]

        if blackAndWhite {
            VerticalBarChartOld(entries: entries[type.rawValue],
                             color: UIColor.black,
                             settings: data.settings).frame(height: 65)
        } else {
            let color = moodUIColors(settings: data.settings)[type.rawValue]
            VerticalBarChartOld(entries: entries[type.rawValue],
                             color: color,
                             settings: data.settings).frame(height: 65)
        }
    }
}
