import SwiftUI

struct WeightView: View {
    var timescale: Int
    var data: DataStoreStruct
    var health: HealthManager

    var body: some View {
        let samples: Int = countHealthSnaps(healthSnaps: data.healthSnaps, type: .weight) // data.healthSnaps.count
        let average: CGFloat = average(healthSnaps: data.healthSnaps, type: .weight) ?? 0.0
        let averageStr: String = String(format: "%.1f", average) + "kg"
        let r2mood: [CGFloat?] = getR2(data: data, type: .weight)
        let weightData: [CGFloat?] = getWeightData(data: data, health: health)
        let entries = makeBarData(y: weightData, timescale: timescale)

        if samples == 0 || r2mood[0] == nil || r2mood[1] == nil || r2mood[2] == nil || r2mood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            let minWeight: CGFloat = minWithNils(data: weightData) ?? 0 - 1
            let maxWeight: CGFloat = maxWithNils(data: weightData) ?? 0 + 1
            VerticalBarChart(entries: entries, color: UIColor(themes[data.settings.theme].buttonColor), settings: data.settings, shaded: false, min: minWeight, max: maxWeight, labelCount: 0)
                .frame(height: 65)
            Label("mood_levels", systemImage: "brain.head.profile")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            HStack {
                Text("Average weight")
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
                // R2
                Text(.init("R2"))
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

func getWeightData(data: DataStoreStruct, health: HealthManager) -> [CGFloat?] {
    var weightData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: data.moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
        if thisHealthSnap.count > 0 {
            weightData.append(thisHealthSnap[0].weight)
        }
        date = date.addDays(days: -1)
    }

    return weightData.reversed()
}
