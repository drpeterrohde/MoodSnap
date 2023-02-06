import SwiftUI

/**
 View for displaying an activity tally.
 */
struct TallyView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        let windowMoodSnaps = getMoodSnapsByDateWindow(moodSnaps: data.moodSnaps, date: Date(), windowStart: -timescale, windowEnd: 0)
        let (symptomOccurrences, activityOccurrences, socialOccurrences) = countAllOccurrences(moodSnaps: windowMoodSnaps, settings: data.settings)
        let hashtagOccurrences: [Int] = countHashtagOccurrences(hashtags: data.hashtagList, moodSnaps: windowMoodSnaps)
        let eventsList = getEventsList(moodSnaps: data.moodSnaps, window: timescale)

        let activityTotal = activityOccurrences.reduce(0, +)
        let socialTotal = socialOccurrences.reduce(0, +)
        let symptomTotal = symptomOccurrences.reduce(0, +)
        let hashtagTotal = hashtagOccurrences.reduce(0, +)
        let eventsTotal = eventsList.count

        // No information
        if activityTotal == 0 && socialTotal == 0 && symptomTotal == 0 && eventsTotal == 0 && hashtagTotal == 0 {
            Divider()
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        }

        // Activities
        if activityTotal > 0 {
            Group {
                Divider()
                Label("activity", systemImage: "figure.walk")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(0 ..< activityList.count, id: \.self) { i in
                            if activityOccurrences[i] > 0 && data.settings.activityVisibility[i] {
                                Text(.init(activityList[i])).font(.caption) + Text("  ").font(.caption)
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        ForEach(0 ..< activityList.count, id: \.self) { i in
                            if activityOccurrences[i] > 0 && data.settings.activityVisibility[i] {
                                Text(String(activityOccurrences[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }

        // Social
        if socialTotal > 0 {
            Group {
                Divider()
                Label("social", systemImage: "person.2")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(0 ..< socialList.count, id: \.self) { i in
                            if socialOccurrences[i] > 0 && data.settings.socialVisibility[i] {
                                Text(.init(socialList[i])).font(.caption) + Text("  ").font(.caption)
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        ForEach(0 ..< socialList.count, id: \.self) { i in
                            if socialOccurrences[i] > 0 && data.settings.socialVisibility[i] {
                                Text(String(socialOccurrences[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }

        // Symptoms
        if symptomTotal > 0 {
            Group {
                Divider()
                Label("symptoms", systemImage: "heart.text.square")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(0 ..< symptomList.count, id: \.self) { i in
                            if symptomOccurrences[i] > 0 && data.settings.symptomVisibility[i] {
                                Text(.init(symptomList[i])).font(.caption) + Text("  ").font(.caption)
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        ForEach(0 ..< symptomList.count, id: \.self) { i in
                            if symptomOccurrences[i] > 0 && data.settings.symptomVisibility[i] {
                                Text(String(symptomOccurrences[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }

        // Events
        if eventsTotal > 0 {
            Group {
                Divider()
                Label("events", systemImage: "star.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(0 ..< eventsList.count, id: \.self) { i in
                            Text(eventsList[i].0 + "  ")
                                .font(.caption)
                        }
                    }
                    VStack(alignment: .leading) {
                        ForEach(0 ..< eventsList.count, id: \.self) { i in
                            let str = "(" + eventsList[i].1.dateString() + ")"
                            Text(str).font(.caption)
                        }
                    }
                    Spacer()
                }
            }
        }

        // Hashtags
        if hashtagTotal > 0 {
            Group {
                Divider()
                Label("hashtags", systemImage: "number")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(0 ..< data.hashtagList.count, id: \.self) { i in
                            if hashtagOccurrences[i] > 0 {
                                Text(data.hashtagList[i] + "  ")
                                    .font(.caption)
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        ForEach(0 ..< data.hashtagList.count, id: \.self) { i in
                            if hashtagOccurrences[i] > 0 {
                                Text(String(hashtagOccurrences[i]))
                                    .font(numericFont)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}
