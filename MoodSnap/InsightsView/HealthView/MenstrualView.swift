import SwiftUI

/**
 View showing menstrual data.
 */
struct MenstrualView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager

    var body: some View {
        let entries = makeChartData(y: health.menstrualData, timescale: timescale)
        let entriesE = makeChartData(y: data.processedData.levelE, timescale: timescale)
        let entriesD = makeChartData(y: data.processedData.levelD, timescale: timescale)
        let entriesA = makeChartData(y: data.processedData.levelA, timescale: timescale)
        let entriesI = makeChartData(y: data.processedData.levelI, timescale: timescale)
        let moodEntries = [entriesE, entriesD, entriesA, entriesI]

        let color = moodUIColors(settings: data.settings)

        if health.menstrualDates.count == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            /*SuperimposedBarLineChart(barData: entries,
                                      lineData: moodEntries,
                                      barColor: themes[data.settings.theme].buttonColor,
                                      lineColor: [Color(color[0]), Color(color[1]), Color(color[2]), Color(color[3])],
                                      shaded: true,
                                      settings: data.settings)
                .frame(height: 100)*/
            VerticalBarChart(values: entries,
                             color: themes[data.settings.theme].buttonColor,
                             min: 0,
                             max: 1,
                             settings: data.settings)
                .frame(height: 60)
            //Spacer(minLength: 20)
            TransientView(butterfly: health.menstrualButterfly,
                          label: "pm_14_days",
                          timescale: 2 * menstrualTransientWindow + 1,
                          showNumbers: false)
        }
    }
}
