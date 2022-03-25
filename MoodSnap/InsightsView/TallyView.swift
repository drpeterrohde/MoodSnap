import SwiftUI

struct TallyView: View {
    var timescale: Int
    var data: DataStoreStruct
    
    var body: some View {
        let windowMoodSnaps = getMoodSnapsByDateWindow(
            moodSnaps: data.moodSnaps, 
            date: Date(), 
            windowStart: -timescale, 
            windowEnd: 0)
        let (symptomOccurrences, activityOccurrences, socialOccurrences) = countAllOccurrences(moodSnaps: windowMoodSnaps)
        let hashtagList = getHashtags(data: data)
        let hashtagOccurrences = countHashtagOccurrences(hashtags: hashtagList, moodSnaps: windowMoodSnaps)
        let eventsList = getEventsList(moodSnaps: windowMoodSnaps, window: timescale)
        
        let activityTotal = activityOccurrences.reduce(0, +)
        let socialTotal = socialOccurrences.reduce(0, +)
        let symptomTotal = symptomOccurrences.reduce(0, +)
        let hashtagTotal = hashtagOccurrences.reduce(0, +)
        let eventsTotal = eventsList.count
        
        // No information
        if activityTotal == 0 && socialTotal == 0 && symptomTotal == 0 && eventsTotal == 0 && hashtagTotal == 0 {
            Divider()
            Text("Insufficient data")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        
        // Activities
        if activityTotal > 0 {
        Group {
            Divider()
        Label("Activity", systemImage: "figure.walk")
            .font(.caption)
            .foregroundColor(.secondary)
            Spacer()
        HStack {
            VStack(alignment: .leading) {
                ForEach(0 ..< activityList.count, id: \.self) {i in
                    if activityOccurrences[i] > 0 {
                    Text(activityList[i] + "  ")
                        .font(.caption)
                    }
                }
            }
            VStack(alignment: .leading) {
                ForEach(0 ..< activityList.count, id: \.self) {i in
                    if activityOccurrences[i] > 0 {
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
            Label("Social", systemImage: "person.2")
            .font(.caption)
            .foregroundColor(.secondary)
            Spacer()
        HStack {
            VStack(alignment: .leading) {
                ForEach(0 ..< socialList.count, id: \.self) {i in
                    if socialOccurrences[i] > 0 {
                    Text(socialList[i] + "  ")
                        .font(.caption)
                    }
                }
            }
            VStack(alignment: .leading) {
                ForEach(0 ..< socialList.count, id: \.self) {i in
                    if socialOccurrences[i] > 0 {
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
            Label("Symptoms", systemImage: "heart.text.square")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    ForEach(0 ..< symptomList.count, id: \.self) {i in
                        if symptomOccurrences[i] > 0 {
                            Text(symptomList[i] + "  ")
                                .font(.caption)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    ForEach(0 ..< symptomList.count, id: \.self) {i in
                        if symptomOccurrences[i] > 0 {
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
            Label("Events", systemImage: "star.fill")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    ForEach(0 ..< eventsList.count, id: \.self) {i in
                            Text(eventsList[i].0 + "  ")
                                .font(.caption)
                    }
                }
                VStack(alignment: .leading) {
                    ForEach(0 ..< eventsList.count, id: \.self) {i in
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
            Label("Hashtags", systemImage: "number")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    ForEach(0 ..< hashtagList.count, id: \.self) {i in
                        if hashtagOccurrences[i] > 0 {
                            Text(hashtagList[i] + "  ")
                                .font(.caption)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    ForEach(0 ..< hashtagList.count, id: \.self) {i in
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
