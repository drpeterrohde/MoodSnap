import SwiftUI

/**
 View showing walking & running distance.
 */
struct WalkingRunningDistanceView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager

    var body: some View {
        let entries = makeChartData(y: health.distanceData, timescale: timescale)

        if health.distanceSamples == 0 || health.distanceCorrelationsMood[0] == nil || health.distanceCorrelationsMood[1] == nil || health.distanceCorrelationsMood[2] == nil || health.distanceCorrelationsMood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            VerticalBarChart(values: entries,
                             color: themes[data.settings.theme].walkingRunningColor,
                             min: 0,
                             max: health.maxDistance,
                             settings: data.settings)
                .frame(height: 60)

            Spacer()
            HStack {
                Text("Average_distance")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(health.distanceAverageStr)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            HStack {
                Text("Maximum_distance")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(health.maxDistanceStr)
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
                Text("(\(health.distanceSamples))")
                    .font(.caption)
                Spacer()
                HStack {
                    Text(formatMoodLevelString(value: health.distanceCorrelationsMood[0]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: health.distanceCorrelationsMood[1]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: health.distanceCorrelationsMood[2]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: health.distanceCorrelationsMood[3]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].irritabilityColor)
                }
                .frame(width: 150)
            }
        }
    }
}
