import SwiftUI

/**
 Get a `[Date]` array for all instances of a `hashtag`.
 */
@inline(__always) func getDatesForHashtag(hashtag: String, moodSnaps: ContiguousArray<MoodSnapStruct>) -> [Date] {
    var dates: [Date] = []
    for moodSnap in moodSnaps {
        if containsHashtag(string: moodSnap.notes, hashtag: hashtag) || containsHashtag(string: moodSnap.event, hashtag: hashtag) {
        //if moodSnap.notes.lowercased().contains(hashtag) || moodSnap.event.lowercased().contains(hashtag) {
            dates.append(moodSnap.timestamp)
        }
    }
    return dates
}

/**
 Get a `[Date]` array for all instances of a `type` and type `item`.
 */
@inline(__always) func getDatesForType(type: InfluenceTypeEnum, item: Int, data: DataStoreClass) -> [Date] {
    var dates: [Date] = []

    if type == .event {
        let event = getEventsList(data: data)[item]
        dates.append(event.1)
        return dates
    }

    if type == .hashtag {
        dates = getDatesForHashtag(hashtag: data.hashtagList[item], moodSnaps: data.moodSnaps)
        return dates
    }
    
    for moodSnap in data.moodSnaps {
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

/**
 Get a `[Date]` array for all instances of a `type` and type `item`.
 */
@inline(__always) func getDatesForType(type: InfluenceTypeEnum, activity: Int, social: Int, symptom: Int, event: Int, hashtag: Int, data: DataStoreClass) -> [Date] {
    var dates: [Date] = []
    var item = 0
    
    switch type {
    case .activity:
        item = activity
    case .symptom:
        item = symptom
    case .social:
        item = social
    case .event:
        item = event
    case .hashtag:
        item = hashtag
    }

    if type == .event {
        let event = getEventsList(data: data)[item]
        dates.append(event.1)
        return dates
    }

    if type == .hashtag {
        dates = getDatesForHashtag(hashtag: data.hashtagList[item], moodSnaps: data.moodSnaps)
        return dates
    }
    
    for moodSnap in data.moodSnaps {
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
