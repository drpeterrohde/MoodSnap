import SwiftUI

/**
 View for displaying an occurences summary.
 */
struct DeltasActivityView: View {
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
                Label("activity", systemImage: "figure.walk")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text(" ")
                            .font(.caption)
                        ForEach(0 ..< butterfly.deltas!.beforeActivities.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeActivities[i],
                                                       after: butterfly.deltas!.afterActivities[i])
                            if display && data.settings.activityVisibility[i] {
                                Text(.init(activityList[i])).font(.caption) + Text("  ").font(.caption)
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\u{2190} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.beforeActivities.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeActivities[i],
                                                       after: butterfly.deltas!.afterActivities[i])
                            if display && data.settings.activityVisibility[i] {
                                Text(formatCountString(value: butterfly.deltas!.beforeActivities[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    VStack(alignment: .trailing) {
                        Text("\u{2192} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.afterActivities.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeActivities[i],
                                                       after: butterfly.deltas!.afterActivities[i])
                            if display && data.settings.activityVisibility[i] {
                                Text(formatCountString(value: butterfly.deltas!.afterActivities[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    VStack(alignment: .trailing) {
                        Text("\u{0394} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.deltaActivities.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeActivities[i],
                                                       after: butterfly.deltas!.afterActivities[i])
                            if display && data.settings.activityVisibility[i] {
                                Text(formatCountString(value: butterfly.deltas!.deltaActivities[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                }
            }
        }
    }
}


