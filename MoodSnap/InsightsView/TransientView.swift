import Charts
import SwiftUI

/**
 View for displaying a tranisent.
 */
struct TransientView: View {
    var butterfly: ButterflyEntryStruct
    var label: String
    var timescale: Int
    var data: DataStoreStruct

    var body: some View {
        let dataE = butterfly.elevation
        let dataD = butterfly.depression
        let dataA = butterfly.anxiety
        let dataI = butterfly.irritability

        let allData: [CGFloat?] = dataE + dataD + dataA + dataI
        let bound = getAxisBound(data: allData)

        let entriesButterflyE = makeLineData(y: dataE)
        let entriesButterflyD = makeLineData(y: dataD)
        let entriesButterflyA = makeLineData(y: dataA)
        let entriesButterflyI = makeLineData(y: dataI)
        let entries = [entriesButterflyE, entriesButterflyD, entriesButterflyA, entriesButterflyI]

        let color = moodUIColors(settings: data.settings)

        VStack {
            VStack {
                Group {
                    if entries[0].count == 0 {
                        HStack {
                            Text("(-)").font(.caption)
                            Text("-")
                                .font(.caption)
                                .foregroundColor(themes[data.settings.theme].elevationColor)
                            Text("-")
                                .font(.caption)
                                .foregroundColor(themes[data.settings.theme].depressionColor)
                            Text("-")
                                .font(.caption)
                                .foregroundColor(themes[data.settings.theme].anxietyColor)
                            Text("-")
                                .font(.caption)
                                .foregroundColor(themes[data.settings.theme].irritabilityColor)
                        }
                        MultipleLineChart(
                            entries: [[], [], [], []],
                            color: color,
                            showMidBar: true,
                            min: -1,
                            max: 1,
                            guides: 0)
                            .padding(.top, -15)
                        HStack(alignment: .center) {
                            Text("insufficient_data")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.top, -10)
                                .padding(.leading, 15)
                        }
                    } else {
                        Group {
                            if entries[0].count > 0 {
                                VStack {
                                    HStack {
                                        Text("(\(butterfly.occurrences))")
                                            .font(.caption)
                                        Text(formatMoodLevelString(value: butterfly.influence()[0]))
                                            .font(.caption)
                                            .foregroundColor(themes[data.settings.theme].elevationColor)
                                        Text(formatMoodLevelString(value: butterfly.influence()[1]))
                                            .font(.caption)
                                            .foregroundColor(themes[data.settings.theme].depressionColor)
                                        Text(formatMoodLevelString(value: butterfly.influence()[2]))
                                            .font(.caption)
                                            .foregroundColor(themes[data.settings.theme].anxietyColor)
                                        Text(formatMoodLevelString(value: butterfly.influence()[3]))
                                            .font(.caption)
                                            .foregroundColor(themes[data.settings.theme].irritabilityColor)
                                    }
                                    MultipleLineChart(entries: entries,
                                                      color: color,
                                                      showMidBar: true,
                                                      min: -bound,
                                                      max: bound,
                                                      guides: 2)
                                        .padding(.top, -15)
                                    HStack(alignment: .center) {
                                        Text(.init(label))
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .padding(.top, -10)
                                            .padding(.leading, 15)
                                    }
//                                    LineChart2(data: entriesLevels,
//                                               color: [Color(color[0]), Color(color[1]), Color(color[2]), Color(color[3])])
//                                    .frame(height: 170)
                                }
                            }
                        }
                    }
                }
            }
        }.frame(height: 225)
    }
}
