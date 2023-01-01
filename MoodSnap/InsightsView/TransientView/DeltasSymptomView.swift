import SwiftUI

/**
 View for displaying an occurences summary.
 */
struct DeltasSymptomView: View {
    @Binding var selectedActivity: Int
    @Binding var selectedSocial: Int
    @Binding var selectedSymptom: Int
    @Binding var selectedEvent: Int
    @Binding var selectedHashtag: Int
    @Binding var selectionType: InfluenceTypeEnum
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {
        let butterfly = transientByType(
            type: selectionType,
            activity: selectedActivity,
            social: selectedSocial,
            symptom: selectedSymptom,
            event: selectedEvent,
            hashtag: selectedHashtag,
            processedData: data.processedData)
        
        if butterfly.deltas != nil {
            Group {
                Divider()
                Label("symptoms", systemImage: "heart.text.square")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text(" ")
                            .font(.caption)
                        ForEach(0 ..< butterfly.deltas!.beforeSymptoms.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeSymptoms[i],
                                                       after: butterfly.deltas!.afterSymptoms[i])
                            if display && data.settings.symptomVisibility[i] {
                                Text(.init(symptomList[i])).font(.caption) + Text("  ").font(.caption)
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\u{2190} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.beforeSymptoms.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeSymptoms[i],
                                                       after: butterfly.deltas!.afterSymptoms[i])
                            if display && data.settings.symptomVisibility[i] {
                                Text(formatCountString(value: butterfly.deltas!.beforeSymptoms[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    VStack(alignment: .trailing) {
                        Text("\u{2192} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.afterSymptoms.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeSymptoms[i],
                                                       after: butterfly.deltas!.afterSymptoms[i])
                            if display && data.settings.symptomVisibility[i] {
                                Text(formatCountString(value: butterfly.deltas!.afterSymptoms[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    VStack(alignment: .trailing) {
                        Text("\u{0394} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.deltaSymptoms.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeSymptoms[i],
                                                       after: butterfly.deltas!.afterSymptoms[i])
                            if display && data.settings.symptomVisibility[i] {
                                Text(formatCountString(value: butterfly.deltas!.deltaSymptoms[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                }
            }
        }
    }
}


