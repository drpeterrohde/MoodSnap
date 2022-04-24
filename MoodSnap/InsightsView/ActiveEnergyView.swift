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

//import SwiftUI
//import Charts
//
//struct ActiveEnergyView: View {
//    var data: DataStoreStruct
//    
//    var body: some View {
//        let samplesE = getActiveEnergyDistribution(type: .elevation, data: data)
//        let samplesD = getActiveEnergyDistribution(type: .elevation, data: data)
//        let samplesA = getActiveEnergyDistribution(type: .elevation, data: data)
//        let samplesI = getActiveEnergyDistribution(type: .elevation, data: data)
//        
//        let scatterE = makeLineData(x: samplesE.0, y: samplesE.1)
//        let scatterD = makeLineData(x: samplesD.0, y: samplesD.1)
//        let scatterA = makeLineData(x: samplesA.0, y: samplesA.1)
//        let scatterI = makeLineData(x: samplesI.0, y: samplesI.1)
//        
//        let color = moodUIColors(settings: data.settings)
//        
//        VStack(alignment: .center) {
//                if (samplesE.0.count == 0) {
//                    Text("Insufficient data")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                } else {
//            ScatterChart(entries: scatterE, color: color[0], zeroOrigin: true)
//                .frame(height: 170)
//            ScatterChart(entries: scatterD, color: color[1], zeroOrigin: true)
//                .frame(height: 170)
//            ScatterChart(entries: scatterA, color: color[2], zeroOrigin: true)
//                .frame(height: 170)
//            ScatterChart(entries: scatterI, color: color[3], zeroOrigin: true)
//                .frame(height: 170)
//            Text("Active energy")
//                .font(.caption)
//                .foregroundColor(.secondary)
//                .padding([.top], -10)
//        }
//    }
//    }
//}
