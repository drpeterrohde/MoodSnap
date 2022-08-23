import SwiftUI

/**
 View for displaying a tranisent.
 */
struct TransientView: View {
    var butterfly: ButterflyEntryStruct
    var label: String
    var timescale: Int
    var showNumbers: Bool = true
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        let entriesButterflyE = makeLineData(y: butterfly.elevation, timescale: timescale)
        let entriesButterflyD = makeLineData(y: butterfly.depression, timescale: timescale)
        let entriesButterflyA = makeLineData(y: butterfly.anxiety, timescale: timescale)
        let entriesButterflyI = makeLineData(y: butterfly.irritability, timescale: timescale)
        let entries = [entriesButterflyE, entriesButterflyD, entriesButterflyA, entriesButterflyI]
        let color = moodUIColors(settings: data.settings)

        VStack {
            VStack {
                Group {
                    if entries[0].count == 0 {
                        if showNumbers {
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
                        }
                        Group {
                            LineChart(data: [[], [], [], []],
                                      color: [Color(color[0]), Color(color[1]), Color(color[2]), Color(color[3])],
                                      min: -4,
                                      max: 4,
                                      horizontalGridLines: 1,
                                      verticalGridLines: 1,
                                      settings: data.settings)
                                .frame(height: 170)
                            HStack(alignment: .center) {
                                Text("insufficient_data")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    } else {
                        Group {
                            VStack {
                                if showNumbers {
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
                                }
                                Group {
                                    LineChart(data: entries,
                                              color: [Color(color[0]), Color(color[1]), Color(color[2]), Color(color[3])],
                                              min: -4,
                                              max: 4,
                                              horizontalGridLines: 1,
                                              verticalGridLines: 1,
                                              settings: data.settings)
                                        .frame(height: 170)
                                    HStack(alignment: .center) {
                                        Text(.init(label))
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }.frame(height: 225)
    }
}
