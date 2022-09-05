import SwiftUI

/**
 View showing weight data.
 */
struct WeightView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager

    var body: some View {
        let entries = makeChartData(y: health.weightData, timescale: timescale)

        if health.weightSamples == 0 || health.weightCorrelationsMood[0] == nil || health.weightCorrelationsMood[1] == nil || health.weightCorrelationsMood[2] == nil || health.weightCorrelationsMood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            VerticalBarChart(values: entries,
                             color: themes[data.settings.theme].weightColor,
                             min: health.minWeight - 0.5,
                             max: health.maxWeight,
                             settings: data.settings)
                .frame(height: 60)

            Spacer()
            HStack {
                Text("Average_weight")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(health.weightAverageStr)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            HStack {
                Text("Minimum_weight")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(health.minimumWeightStr)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            HStack {
                Text("Maximum_weight")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(health.maximumWeightStr)
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
                Text("(\(health.weightSamples))")
                    .font(.caption)
                Spacer()
                HStack {
                    Text(formatMoodLevelString(value: health.weightCorrelationsMood[0]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: health.weightCorrelationsMood[1]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: health.weightCorrelationsMood[2]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: health.weightCorrelationsMood[3]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].irritabilityColor)
                }
                .frame(width: 150)
            }
        }
    }
}
