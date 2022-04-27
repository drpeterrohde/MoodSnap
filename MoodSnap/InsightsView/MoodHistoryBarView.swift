import Charts
import SwiftUI

/**
 View for displaying mood history over given `timescale`.
 */
struct MoodHistoryBarView: View {
    var timescale: Int
    var data: DataStoreStruct

    var body: some View {
        let entriesE = makeChartData(y: data.processedData.levelE, timescale: timescale)
        let entriesD = makeChartData(y: data.processedData.levelD, timescale: timescale)
        let entriesA = makeChartData(y: data.processedData.levelA, timescale: timescale)
        let entriesI = makeChartData(y: data.processedData.levelI, timescale: timescale)

        let color = moodUIColors(settings: data.settings)

        if data.moodSnaps.count == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            VStack {
                Group {
                    VerticalBarChart(values: entriesE, color: Color(color[0]), horizontalGridLines: 3, shaded: true, settings: data.settings)
                        .frame(height: 60)
                    Text("elevation")
                        .font(.caption)
                        .foregroundColor(Color(color[0]))
                }

                Group {
                    VerticalBarChart(values: entriesD, color: Color(color[1]), horizontalGridLines: 3, shaded: true, settings: data.settings)
                        .frame(height: 60)
                    Text("depression")
                        .font(.caption)
                        .foregroundColor(Color(color[1]))
                }

                Group {
                    VerticalBarChart(values: entriesA, color: Color(color[2]), horizontalGridLines: 3, shaded: true, settings: data.settings)
                        .frame(height: 60)
                    Text("anxiety")
                        .font(.caption)
                        .foregroundColor(Color(color[2]))
                }

                Group {
                    VerticalBarChart(values: entriesI, color: Color(color[3]), horizontalGridLines: 3, shaded: true, settings: data.settings)
                        .frame(height: 60)
                    Text("irritability")
                        .font(.caption)
                        .foregroundColor(Color(color[3]))
                }
            }
        }
    }
}
