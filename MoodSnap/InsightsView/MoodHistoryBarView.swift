import Charts
import SwiftUI

/**
 View for displaying mood history over given `timescale`.
 */
struct MoodHistoryBarView: View {
    var timescale: Int
    var data: DataStoreStruct

    var body: some View {
//        let entriesE = makeBarData(y: data.processedData.levelE, timescale: timescale)
//        let entriesD = makeBarData(y: data.processedData.levelD, timescale: timescale)
//        let entriesA = makeBarData(y: data.processedData.levelA, timescale: timescale)
//        let entriesI = makeBarData(y: data.processedData.levelI, timescale: timescale)

        let entriesE2 = makeBarData2(y: data.processedData.levelE, timescale: timescale)
        let entriesD2 = makeBarData2(y: data.processedData.levelD, timescale: timescale)
        let entriesA2 = makeBarData2(y: data.processedData.levelA, timescale: timescale)
        let entriesI2 = makeBarData2(y: data.processedData.levelI, timescale: timescale)

       // let entries = [entriesE, entriesD, entriesA, entriesI]
        let color = moodUIColors(settings: data.settings)

        if data.moodSnaps.count == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            VStack {
                Group {
                VerticalBarChart2(values: entriesE2, color: Color(color[0]), horizontalGridLines: 3, settings: data.settings)
                    .frame(height: 60)
//                VerticalBarChart(entries: entries[0], color: color[0], settings: data.settings)
//                    .frame(height: 65)
                Text("elevation")
                    .font(.caption)
                    .foregroundColor(Color(color[0]))
                  //  .padding([.top, .bottom], -15)
                }
                
                Group {
                VerticalBarChart2(values: entriesD2, color: Color(color[1]), horizontalGridLines: 3, settings: data.settings)
                    .frame(height: 60)
                   // .padding(.top, -10)
//                VerticalBarChart(entries: entries[1], color: color[1], settings: data.settings)
//                    .frame(height: 65)
//                    .padding(.top, -10)
                Text("depression")
                    .font(.caption)
                    .foregroundColor(Color(color[1]))
                  //  .padding([.top, .bottom], -15)
                }
                
                Group {
                VerticalBarChart2(values: entriesA2, color: Color(color[2]), horizontalGridLines: 3, settings: data.settings)
                    .frame(height: 60)
                  //  .padding(.top, -10)
//                VerticalBarChart(entries: entries[2], color: color[2], settings: data.settings)
//                    .frame(height: 65)
//                    .padding(.top, -10)
                Text("anxiety")
                    .font(.caption)
                    .foregroundColor(Color(color[2]))
                   // .padding([.top, .bottom], -15)
                }
                
                Group {
                    VerticalBarChart2(values: entriesI2, color: Color(color[3]), horizontalGridLines: 3, settings: data.settings)
                        .frame(height: 60)
                   //     .padding(.top, -10)
//                VerticalBarChart(entries: entries[3], color: color[3], settings: data.settings)
//                    .frame(height: 65)
//                    .padding(.top, -10)
                Text("irritability")
                    .font(.caption)
                    .foregroundColor(Color(color[3]))
                  //  .padding(.top, -15)
                }
            }
        }
    }
}
