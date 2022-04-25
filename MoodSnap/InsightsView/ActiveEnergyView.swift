import SwiftUI

struct ActiveEnergyView: View {
    var timescale: Int
    var data: DataStoreStruct
    var health: HealthManager

    var body: some View {
        let samples: Int = countHealthSnaps(healthSnaps: health.healthSnaps, type: .energy)
        let average: CGFloat = average(healthSnaps: health.healthSnaps, type: .energy) ?? 0.0
        let averageStr: String = String(format: "%.1f", average) + "kJ"
        let energyData: [CGFloat?] = getEnergyData(data: data, health: health)
        let correlationsMood: [CGFloat?] = getCorrelation(data: data, health: health, type: .energy)
        let entries = makeChartData(y: energyData, timescale: timescale)

        if samples == 0 || correlationsMood[0] == nil || correlationsMood[1] == nil || correlationsMood[2] == nil || correlationsMood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            let maxEnergy: CGFloat = maxWithNils(data: energyData) ?? 0
            let maximumStr: String = String(format: "%.1f", maxEnergy) + "kJ"

            VerticalBarChart2(values: entries, color: themes[data.settings.theme].buttonColor, min: 0, max: maxEnergy, settings: data.settings)
                .frame(height: 60)

            Spacer()
            HStack {
                Text("Average_energy")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(averageStr)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            HStack {
                Text("Maximum_energy")
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
