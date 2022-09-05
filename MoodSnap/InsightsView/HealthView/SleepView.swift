import SwiftUI

/**
 View showing sleeping time.
 */
struct SleepView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager
    
    var body: some View {
        let entries = makeChartData(y: health.sleepData, timescale: timescale)
        
        if health.sleepSamples == 0 || health.sleepCorrelationsMood[0] == nil || health.sleepCorrelationsMood[1] == nil || health.sleepCorrelationsMood[2] == nil || health.sleepCorrelationsMood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            VerticalBarChart(values: entries,
                             color: themes[data.settings.theme].sleepColor,
                             min: 0,
                             max: health.maxSleep,
                             settings: data.settings)
            .frame(height: 60)
            Spacer()
            HStack {
                Text("Average_sleep")
                    .font(.caption)
                    .foregroundColor(.primary)
                Spacer()
                Text(health.sleepAverageStr)
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
                Text("(\(health.sleepSamples))")
                    .font(.caption)
                Spacer()
                HStack {
                    Text(formatMoodLevelString(value: health.sleepCorrelationsMood[0]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: health.sleepCorrelationsMood[1]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: health.sleepCorrelationsMood[2]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: health.sleepCorrelationsMood[3]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].irritabilityColor)
                }
                .frame(width: 150)
            }
        }
    }
}
