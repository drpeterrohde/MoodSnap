import SwiftUI

/**
 View showing menstrual data.
 */
struct MenstrualView: View {
    var timescale: Int
    var data: DataStoreClass
    var health: HealthManager

    var body: some View {
        let menstrualData: [CGFloat?] = getMenstrualData(data: data,
                                                         health: health)
        let entries = makeChartData(y: menstrualData,
                                    timescale: timescale)
        let dates = getMenstrualDates(healthSnaps: health.healthSnaps)
        let butterfly = averageMenstrualTransientForDates(dates: dates,
                                                          moodSnaps: data.moodSnaps,
                                                          maxWindow: menstrualTransientWindow)

        let entriesE = makeChartData(y: data.processedData.levelE, timescale: timescale)
        let entriesD = makeChartData(y: data.processedData.levelD, timescale: timescale)
        let entriesA = makeChartData(y: data.processedData.levelA, timescale: timescale)
        let entriesI = makeChartData(y: data.processedData.levelI, timescale: timescale)
        let moodEntries = [entriesE, entriesD, entriesA, entriesI]

        let color = moodUIColors(settings: data.settings)

        if dates.count == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            SuperimposedBarLineChart(barData: entries,
                                      lineData: moodEntries,
                                      barColor: themes[data.settings.theme].buttonColor,
                                      lineColor: [Color(color[0]), Color(color[1]), Color(color[2]), Color(color[3])],
                                      shaded: true,
                                      settings: data.settings)
                .frame(height: 100)
            Spacer(minLength: 20)
            TransientView(butterfly: butterfly,
                          label: "pm_14_days",
                          timescale: 2 * menstrualTransientWindow + 1,
                          showNumbers: false,
                          data: data)
        }
    }
}
