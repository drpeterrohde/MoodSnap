import SwiftUI

/**
 View showing active energy.
 */
struct ActiveEnergyView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager

    var body: some View {
        let entries = makeChartData(y: health.energyData, timescale: timescale)

        if health.energySamples == 0 || health.energyCorrelationsMood[0] == nil || health.energyCorrelationsMood[1] == nil || health.energyCorrelationsMood[2] == nil || health.energyCorrelationsMood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            VerticalBarChart(values: entries,
                             color: themes[data.settings.theme].energyColor,
                             min: 0,
                             max: health.maxEnergy,
                             settings: data.settings)
                .frame(height: 60)

            Spacer()
            HStack {
                Text("Average_energy")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(health.energyAverageStr)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            HStack {
                Text("Maximum_energy")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(health.maxEnergyStr)
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
                Text("(\(health.energySamples))")
                    .font(.caption)
                Spacer()
                HStack {
                    Text(formatMoodLevelString(value: health.energyCorrelationsMood[0]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: health.energyCorrelationsMood[1]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: health.energyCorrelationsMood[2]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: health.energyCorrelationsMood[3]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].irritabilityColor)
                }
                .frame(width: 150)
            }
        }
    }
}
