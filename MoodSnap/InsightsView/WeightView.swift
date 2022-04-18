import Charts
import SwiftUI

struct WeightView: View {
    var data: DataStoreStruct

    var body: some View {
        let samples = 1
        let r2mood = [0.0, -0.1, 0.2, -0.3]
        let r2volatility = [0.0, 0.1, -0.2, 0.3]

        if samples == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            Label("mood_levels", systemImage: "brain.head.profile")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            HStack {
                // R2
                Text(.init("R2"))
                    .font(.caption)

                // Occurrences
                Text("(\(samples))")
                    .font(.caption)
                Spacer()
                // Numbers
                HStack {
                    Text(formatMoodLevelString(value: r2mood[0]))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: r2mood[1]))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: r2mood[2]))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: r2mood[3]))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].irritabilityColor)
                }.frame(width: 150)
            }

            Divider()
            Label("volatility", systemImage: "waveform.path.ecg")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            HStack {
                // R2
                Text(.init("R2"))
                    .font(.caption)
                // Occurrences
                Text("(\(samples))")
                    .font(.caption)
                Spacer()
                // Numbers
                HStack {
                    Text(formatMoodLevelString(value: r2volatility[0]))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: r2volatility[1]))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: r2volatility[2]))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: r2volatility[3]))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].irritabilityColor)
                }.frame(width: 150)
            }
        }
    }
}
