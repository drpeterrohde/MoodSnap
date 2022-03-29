import SwiftUI

/**
 Get a `[Date]` array for all instances of a `hashtag`.
 */
func getDatesForHashtag(hashtag: String, moodSnaps: [MoodSnapStruct]) -> [Date] {
    var dates: [Date] = []
    for moodSnap in moodSnaps {
        if moodSnap.notes.lowercased().contains(hashtag) || moodSnap.event.lowercased().contains(hashtag) {
            dates.append(moodSnap.timestamp)
        }
    }
    return dates
}

/**
 Get a `[Date]` array for all instances of a `type` and type `item`.
 */
func getDatesForType(type: InfluenceTypeEnum, item: Int, moodSnaps: [MoodSnapStruct]) -> [Date] {
    var dates: [Date] = []
    
    if type == .event {
        let event = getEventsList(moodSnaps: moodSnaps)[item]
        dates.append(event.1)
        return dates
    }
    
    for moodSnap in moodSnaps {
        switch type {
        case .activity:
            if moodSnap.activities[item] {
                dates.append(moodSnap.timestamp)
            }
        case .social:
            if moodSnap.social[item] {
                dates.append(moodSnap.timestamp)
            }
        case .symptom:
            if moodSnap.symptoms[item] {
                dates.append(moodSnap.timestamp)
            }
        default:
            break
        }
    }
    
    return dates
}
