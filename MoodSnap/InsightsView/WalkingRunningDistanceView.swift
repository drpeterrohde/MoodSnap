import SwiftUI

struct WalkingRunningDistanceView: View {
    var timescale: Int
    var data: DataStoreStruct
    var health: HealthManager

    var body: some View {
        let samples: Int = countHealthSnaps(healthSnaps: health.healthSnaps, type: .distance)
        let average: CGFloat = average(healthSnaps: health.healthSnaps, type: .distance) ?? 0.0
        let averageStr: String = String(format: "%.1f", average) + "km"
        let distanceData: [CGFloat?] = getDistanceData(data: data, health: health)
        let correlationsMood: [CGFloat?] = getCorrelation(data: data, health: health, type: .distance)
        let entries = makeChartData(y: distanceData, timescale: timescale)

        if samples == 0 || correlationsMood[0] == nil || correlationsMood[1] == nil || correlationsMood[2] == nil || correlationsMood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            let maxDistance: CGFloat = maxWithNils(data: distanceData) ?? 0
            let maximumStr: String = String(format: "%.1f", maxDistance) + "km"

            VerticalBarChart2(values: entries, color: themes[data.settings.theme].buttonColor, min: 0, max: maxDistance, settings: data.settings)
                .frame(height: 60)

            Spacer()
            HStack {
                Text("Average_distance")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(averageStr)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            HStack {
                Text("Maximum_distance")
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
                // R2
                Text("Correlation")
                    .font(.caption)
                // Occurrences
                Text("(\(samples))")
                    .font(.caption)
                Spacer()
                // Numbers
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
