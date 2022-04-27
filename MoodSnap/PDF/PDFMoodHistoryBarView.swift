import Charts
import SwiftUI

struct PDFMoodHistoryBarView: View {
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool

    var body: some View {
        let entriesE = makeBarData(y: data.processedData.levelE, timescale: timescale)
        let entriesD = makeBarData(y: data.processedData.levelD, timescale: timescale)
        let entriesA = makeBarData(y: data.processedData.levelA, timescale: timescale)
        let entriesI = makeBarData(y: data.processedData.levelI, timescale: timescale)

        let entries = [entriesE, entriesD, entriesA, entriesI]
        let color = moodUIColors(settings: data.settings)

        if data.moodSnaps.count == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            if !blackAndWhite {
                VStack {
                    VerticalBarChartOld(entries: entries[0], color: color[0], settings: data.settings)
                        .frame(height: 65)
                    Text("elevation")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding([.top, .bottom], -15)
                    VerticalBarChartOld(entries: entries[1], color: color[1], settings: data.settings)
                        .frame(height: 65)
                        .padding(.top, -10)
                    Text("depression")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding([.top, .bottom], -15)
                    VerticalBarChartOld(entries: entries[2], color: color[2], settings: data.settings)
                        .frame(height: 65)
                        .padding(.top, -10)
                    Text("anxiety")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding([.top, .bottom], -15)
                    VerticalBarChartOld(entries: entries[3], color: color[3], settings: data.settings)
                        .frame(height: 65)
                        .padding(.top, -10)
                    Text("irritability")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding(.top, -15)
                }
            } else {
                VerticalBarChartOld(entries: entries[0], color: UIColor.black, settings: data.settings)
                    .frame(height: 65)
                Text("elevation")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChartOld(entries: entries[1], color: UIColor.black, settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                Text("depression")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChartOld(entries: entries[2], color: UIColor.black, settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                Text("anxiety")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChartOld(entries: entries[3], color: UIColor.black, settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                Text("irritability")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding(.top, -15)
            }
        }
    }
}
