import SwiftUI

/**
 View for displaying an occurences summary.
 */
struct DeltasSocialView: View {
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
                Label("social", systemImage: "person.2")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text(" ")
                            .font(.caption)
                        ForEach(0 ..< butterfly.deltas!.beforeSocial.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeSocial[i],
                                                       after: butterfly.deltas!.afterSocial[i])
                            if display && data.settings.socialVisibility[i] {
                                Text(.init(socialList[i])).font(.caption) + Text("  ").font(.caption)
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\u{2190} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.beforeSocial.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeSocial[i],
                                                       after: butterfly.deltas!.afterSocial[i])
                            if display && data.settings.socialVisibility[i] {
                                Text(formatCountString(value: butterfly.deltas!.beforeSocial[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    VStack(alignment: .trailing) {
                        Text("\u{2192} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.afterSocial.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeSocial[i],
                                                       after: butterfly.deltas!.afterSocial[i])
                            if display && data.settings.socialVisibility[i] {
                                Text(formatCountString(value: butterfly.deltas!.afterSocial[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    VStack(alignment: .trailing) {
                        Text("\u{0394} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.deltaSocial.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeSocial[i],
                                                       after: butterfly.deltas!.afterSocial[i])
                            if display && data.settings.socialVisibility[i] {
                                Text(formatCountString(value: butterfly.deltas!.deltaSocial[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                }
            }
        }
    }
}


