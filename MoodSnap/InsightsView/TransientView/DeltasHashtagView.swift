import SwiftUI

/**
 View for displaying an occurences summary.
 */
struct DeltasHashtagView: View {
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
        let hashtagOccurrences: [Int] = countHashtagOccurrences(hashtags: data.hashtagList, moodSnaps: data.moodSnaps)
        
        if butterfly.deltas != nil {
            Group {
                Divider()
                Label("hashtags", systemImage: "number")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text(" ")
                            .font(.caption)
                        ForEach(0 ..< butterfly.deltas!.beforeHashtags.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeHashtags[i],
                                                       after: butterfly.deltas!.afterHashtags[i])
                            if display && hashtagOccurrences[i] > 0 {
                                Text(.init(data.hashtagList[i])).font(.caption) + Text("  ").font(.caption)
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\u{2190} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.beforeHashtags.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeHashtags[i],
                                                       after: butterfly.deltas!.afterHashtags[i])
                            if display && hashtagOccurrences[i] > 0 {
                                Text(formatCountString(value: butterfly.deltas!.beforeHashtags[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    VStack(alignment: .trailing) {
                        Text("\u{2192} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.afterHashtags.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeHashtags[i],
                                                       after: butterfly.deltas!.afterHashtags[i])
                            if display && hashtagOccurrences[i] > 0  {
                                Text(formatCountString(value: butterfly.deltas!.afterHashtags[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    VStack(alignment: .trailing) {
                        Text("\u{0394} ")
                            .font(numericFont)
                            .foregroundColor(.secondary)
                        ForEach(0 ..< butterfly.deltas!.deltaHashtags.count, id: \.self) { i in
                            let display = displayDelta(before: butterfly.deltas!.beforeHashtags[i],
                                                       after: butterfly.deltas!.afterHashtags[i])
                            if display && hashtagOccurrences[i] > 0  {
                                Text(formatCountString(value: butterfly.deltas!.deltaHashtags[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                }
            }
        }
    }
}


