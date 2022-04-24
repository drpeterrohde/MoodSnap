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
        let r2mood: [CGFloat?] = getCorrelation(data: data, health: health, type: .distance)
        // let r2volatility: [CGFloat?] = [0.0, 0.0, 0.0, 0.0]
        let entries = makeBarData(y: distanceData, timescale: timescale)
        let entries2 = makeBarData2(y: distanceData, timescale: timescale)
        
        if samples == 0 || r2mood[0] == nil || r2mood[1] == nil || r2mood[2] == nil || r2mood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            let maxDistance: CGFloat = maxWithNils(data: distanceData) ?? 0 // use health data ???
            let maximumStr: String = String(format: "%.1f", maxDistance) + "km"

//            VerticalBarChart(entries: entries, color: UIColor(themes[data.settings.theme].buttonColor), settings: data.settings, shaded: false, min: minDistance, max: maxDistance, labelCount: 0)
  //              .frame(height: 65)
            
            VerticalBarChart2(values: entries2, color: themes[data.settings.theme].buttonColor, min: 0, max: maxDistance, settings: data.settings)
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
                    Text(formatMoodLevelString(value: r2mood[0]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: r2mood[1]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: r2mood[2]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: r2mood[3]!))
                        .font(numericFont)
                        .foregroundColor(themes[data.settings.theme].irritabilityColor)
                }.frame(width: 150)
            }
        }
    }
}

//            Divider()
//            Label("volatility", systemImage: "waveform.path.ecg")
//                .font(.caption)
//                .foregroundColor(.secondary)
//            Spacer()
//            HStack {
//                // R2
//                Text(.init("R2"))
//                    .font(.caption)
//                // Occurrences
//                Text("(\(samples))")
//                    .font(.caption)
//                Spacer()
//                // Numbers
//                HStack {
//                    Text(formatMoodLevelString(value: r2volatility[0]))
//                        .font(numericFont)
//                        .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: r2volatility[1]))
//                        .font(numericFont)
//                        .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: r2volatility[2]))
//                        .font(numericFont)
//                        .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: r2volatility[3]))
//                        .font(numericFont)
//                        .foregroundColor(themes[data.settings.theme].irritabilityColor)
//                }.frame(width: 150)
//            }
