import SwiftUI

struct SleepView: View {
    var timescale: Int
    var data: DataStoreStruct
    var health: HealthManager

    var body: some View {
        let samples: Int = countHealthSnaps(healthSnaps: health.healthSnaps, type: .sleep)
        let average: CGFloat = average(healthSnaps: health.healthSnaps, type: .sleep) ?? 0.0
        let averageStr: String = String(format: "%.1f", average) + "hrs"
        let correlationsMood: [CGFloat?] = getCorrelation(data: data, health: health, type: .sleep)
        let sleepData: [CGFloat?] = getSleepData(data: data, health: health)
        let entries = makeChartData(y: sleepData, timescale: timescale)

        if samples == 0 { // || r2mood[0] == nil || r2mood[1] == nil || r2mood[2] == nil || r2mood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            VerticalBarChart2(values: entries, color: themes[data.settings.theme].buttonColor, min: 0, max: 24, settings: data.settings)
                .frame(height: 60)
            Spacer()
            HStack {
                Text("Average_sleep")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(averageStr)
                    .font(.caption)
                    .foregroundColor(.primary)
            }

            Divider()
            Label("mood_levels", systemImage: "brain.head.profile")
                .font(.caption)
                .foregroundColor(.secondary)
            HStack {
                Text("Correlation")
                    .font(.caption)
                Text("(\(samples))")
                    .font(.caption)
                Spacer()
                HStack {
                    Text(formatMoodLevelString(value: correlationsMood[0]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: correlationsMood[1]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: correlationsMood[2]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: correlationsMood[3]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].irritabilityColor)
                }.frame(width: 150)
            }
        }
    }
}
