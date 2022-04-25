import SwiftUI

struct MenstrualView: View {
    var timescale: Int
    var data: DataStoreStruct
    var health: HealthManager

    var body: some View {
        let samples: Int = countHealthSnaps(healthSnaps: health.healthSnaps, type: .menstrual)
        let menstrualData: [CGFloat?] = getMenstrualData(data: data, health: health)
        let entries = makeChartData(y: menstrualData, timescale: timescale)

        let entriesE = makeChartData(y: data.processedData.levelE, timescale: timescale)
        let entriesD = makeChartData(y: data.processedData.levelD, timescale: timescale)
        let entriesA = makeChartData(y: data.processedData.levelA, timescale: timescale)
        let entriesI = makeChartData(y: data.processedData.levelI, timescale: timescale)
        let moodEntries = [entriesE, entriesD, entriesA, entriesI]

        let color = moodUIColors(settings: data.settings)

        if samples == 0 { // || r2mood[0] == nil || r2mood[1] == nil || r2mood[2] == nil || r2mood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            ZStack {
                VerticalBarChartOpacity2(values: entries,
                                         color: themes[data.settings.theme].buttonColor,
                                         min: 0,
                                         max: 1,
                                         shaded: true,
                                         settings: data.settings)
                    .frame(height: 60)
                BorderlessLineChart2(data: moodEntries,
                                     color: [Color(color[0]), Color(color[1]), Color(color[2]), Color(color[3])])
                    .frame(height: 60)
            }
        }
    }
}
