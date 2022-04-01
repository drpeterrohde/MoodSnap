import Charts
import SwiftUI

/**
 View for displaying a tranisent.
 */
struct TransientView: View {
    var timescale: Int
    var data: DataStoreStruct
    @State private var selectedActivity: Int = 0
    @State private var selectedSocial: Int = 0
    @State private var selectedSymptom: Int = 0
    @State private var selectedEvent: Int = 0
    @State private var selectedHashtag: Int = 0
    @State private var selectionType: InfluenceTypeEnum = .activity

    var body: some View {
        let butterfly = transientByType(
            type: selectionType,
            activity: selectedActivity,
            social: selectedSocial,
            symptom: selectedSymptom,
            event: selectedEvent,
            hashtag: selectedHashtag,
            processedData: data.processedData)

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

        let entriesLevels = [entriesButterflyE, entriesButterflyD, entriesButterflyA, entriesButterflyI]

        let color = moodUIColors(settings: data.settings)

        VStack {
            Group {
                if entriesLevels[0].count == 0 {
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
                        Text("Insufficient data")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top, -10)
                            .padding(.leading, 15)
                    }
                } else {
                    Group {
                        if entriesLevels[0].count > 0 {
                            VStack {
                                HStack {
                                    Text("(\(butterfly.occurrences))").font(.caption)
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
                                MultipleLineChart(
                                    entries: entriesLevels,
                                    color: color,
                                    showMidBar: true,
                                    min: -bound,
                                    max: bound,
                                    guides: 2)
                                    .padding(.top, -15)
                                HStack(alignment: .center) {
                                    if selectionType == .event {
                                        Text("±30days")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .padding(.top, -10)
                                            .padding(.leading, 15)
                                    } else {
                                        Text("±7days")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .padding(.top, -10)
                                            .padding(.leading, 15)
                                    }
                                }
                            }.padding(.bottom, 5)
                        }
                    }
                }
                TransientReferencePickerView(
                    selectedActivity: $selectedActivity,
                    selectedSocial: $selectedSocial,
                    selectedSymptom: $selectedSymptom,
                    selectedEvent: $selectedEvent,
                    selectionType: $selectionType,
                    data: data)
            }.padding(.top, -5)
        }.frame(height: 225)
    }
}

func transientByType(type: InfluenceTypeEnum, activity: Int, social: Int, symptom: Int, event: Int, hashtag: Int, processedData: ProcessedDataStruct) -> ButterflyEntryStruct {
    switch type {
    case .activity:
        return processedData.activityButterfly[activity]
    case .social:
        return processedData.socialButterfly[social]
    case .symptom:
        return processedData.symptomButterfly[symptom]
    case .event:
        return processedData.eventButterfly[event]
    case .hashtag:
        return processedData.hashtagButterfly[hashtag]
    }
}
