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

        if health.menstrualDates.count == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            VerticalBarChart(values: entries,
                             color: themes[data.settings.theme].buttonColor,
                             min: 0,
                             max: 1,
                             settings: data.settings)
                .frame(height: 60)
            TransientView(butterfly: health.menstrualButterfly,
                          label: "pm_14_days",
                          timescale: 2 * menstrualTransientWindow + 1,
                          showNumbers: false)
        }
    }
}
