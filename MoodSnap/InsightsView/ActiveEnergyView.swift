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
        let r2mood: [CGFloat?] = getCorrelation(data: data, health: health, type: .energy)
        // let r2volatility: [CGFloat?] = [0.0, 0.0, 0.0, 0.0]
        let entries = makeBarData(y: energyData, timescale: timescale)
        let entries2 = makeBarData2(y: energyData, timescale: timescale)
        
        if samples == 0 || r2mood[0] == nil || r2mood[1] == nil || r2mood[2] == nil || r2mood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            let maxEnergy: CGFloat = maxWithNils(data: energyData) ?? 0 // use health data ???
            let maximumStr: String = String(format: "%.1f", maxEnergy) + "kJ"

//            VerticalBarChart(entries: entries, color: UIColor(themes[data.settings.theme].buttonColor), settings: data.settings, shaded: false, min: minDistance, max: maxDistance, labelCount: 0)
  //              .frame(height: 65)
            
            VerticalBarChart2(values: entries2, color: themes[data.settings.theme].buttonColor, min: 0, max: maxEnergy, settings: data.settings)
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
