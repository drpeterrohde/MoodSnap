import SwiftUI

/**
 View showing weight data.
 */
struct WeightView: View {
    var timescale: Int
    var data: DataStoreStruct
    var health: HealthManager

    var body: some View {
        let samples: Int = countHealthSnaps(healthSnaps: health.healthSnaps, type: .weight)
        let average: CGFloat = average(healthSnaps: health.healthSnaps, type: .weight) ?? 0.0
        let averageStr: String = getWeightString(value: average, units: data.settings.healthUnits)
        let correlationsMood: [CGFloat?] = getCorrelation(data: data, health: health, type: .weight)
        let weightData: [CGFloat?] = getWeightData(data: data, health: health)
        let entries = makeChartData(y: weightData, timescale: timescale)

        if samples == 0 || correlationsMood[0] == nil || correlationsMood[1] == nil || correlationsMood[2] == nil || correlationsMood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            let minWeight: CGFloat = minWithNils(data: weightData) ?? 0
            let maxWeight: CGFloat = maxWithNils(data: weightData) ?? 0

            let minimumStr: String = getWeightString(value: minWeight, units: data.settings.healthUnits)
            let maximumStr: String = getWeightString(value: maxWeight, units: data.settings.healthUnits)

            VerticalBarChart(values: entries,
                             color: themes[data.settings.theme].buttonColor,
                             min: 0/*minWeight - 0.5*/,
                             max: maxWeight,
                             settings: data.settings)
                .frame(height: 60)

            Spacer()
            HStack {
                Text("Average_weight")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(averageStr)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            HStack {
                Text("Minimum_weight")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(minimumStr)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            HStack {
                Text("Maximum_weight")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(maximumStr)
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
