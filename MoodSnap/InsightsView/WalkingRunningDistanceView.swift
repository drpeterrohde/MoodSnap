// import SwiftUI
// import Charts
//
// struct WalkingRunningDistanceView: View {
//    var data: DataStoreStruct
//
//    var body: some View {
//        let samplesE = getWalkingRunningMoodDistribution(type: .elevation, data: data)
//        let samplesD = getWalkingRunningMoodDistribution(type: .depression, data: data)
//        let samplesA = getWalkingRunningMoodDistribution(type: .anxiety, data: data)
//        let samplesI = getWalkingRunningMoodDistribution(type: .irritability, data: data)
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
//        ScatterChart(entries: scatterE, color: color[0], zeroOrigin: true)
//            .frame(height: 170)
//        ScatterChart(entries: scatterD, color: color[1], zeroOrigin: true)
//            .frame(height: 170)
//        ScatterChart(entries: scatterA, color: color[2], zeroOrigin: true)
//            .frame(height: 170)
//        ScatterChart(entries: scatterI, color: color[3], zeroOrigin: true)
//            .frame(height: 170)
//            Text("Walking & running distance")
//                .font(.caption)
//                .foregroundColor(.secondary)
//                .padding([.top], -10)
//        }
//    }
// }
//    }

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
        let r2mood: [CGFloat?] = getCorrelation(data: data, health: health, type: .distance) // fix ??? to health
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
                // Occurrences
                Text("(\(samples))")
                    .font(.caption)
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
        }
    }
}

func getDistanceData(data: DataStoreStruct, health: HealthManager) -> [CGFloat?] {
    var distanceData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: data.moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
        if thisHealthSnap.count > 0 {
            distanceData.append(thisHealthSnap[0].walkingRunningDistance)
        }
        date = date.addDays(days: -1)
    }

    return distanceData.reversed()
}
