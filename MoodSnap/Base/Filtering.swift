import SwiftUI

/**
 Does `moodSnap` satisfy the given filtering constriants?
 */
@inline(__always) func snapFilter(moodSnap: MoodSnapStruct, filter: SnapTypeEnum, searchText: String) -> Bool {
    let filterOutcome =
    (filter == .mood && moodSnap.snapType == .mood) ||
    (filter == .event && moodSnap.snapType == .event) ||
    (filter == .note && moodSnap.snapType == .note) ||
    (filter == .media && moodSnap.snapType == .media) ||
    filter == .none

    if filterOutcome {
        if searchText == "" { return true }
        
        let eventTextOutcome = moodSnap.event.lowercased().contains(searchText.lowercased())
        let notesTextOutcome = moodSnap.notes.lowercased().contains(searchText.lowercased())

        if (eventTextOutcome || notesTextOutcome) { return true }
    }

    return false
}

/**
 Returns the earliest `Date` amongst `moodSnaps`.
 */
@inline(__always) func getFirstDate(data: DataStoreClass) -> Date {
    var firstDate = Date().startOfDay()
    for moodSnap in data.moodSnaps {
        if moodSnap.timestamp < firstDate {
            if moodSnap.snapType == .mood || moodSnap.snapType == .note || moodSnap.snapType == .event || moodSnap.snapType == .media {
                firstDate = moodSnap.timestamp
            }
        }
    }
    return firstDate
}

/**
 Returns the most recent `Date` amongst `moodSnaps`.
 */
@inline(__always) func getLastDate(data: DataStoreClass) -> Date {
    var lastDate = Date().endOfDay()
    for moodSnap in data.moodSnaps {
        if moodSnap.timestamp > lastDate {
            lastDate = moodSnap.timestamp
        }
    }
    return lastDate
}

/**
 Returns an array of elements from `moodSnaps` that coincide with the same day of `date`. The optional `flatten` parameter merges them into their single day equivalent.
 */
@inline(__always) func getMoodSnapsByDate(data: DataStoreClass, date: Date, flatten: Bool = false) -> [MoodSnapStruct] {
    var filtered: [MoodSnapStruct] = []
    let dateComponents = date.getComponents()
    for moodSnap in data.moodSnaps {
        if moodSnap.timestamp.getComponents() == dateComponents {
            if moodSnap.snapType == .mood {
                filtered.append(moodSnap)
            }
        }
    }
    if flatten {
        if filtered.count > 0 {
            filtered = [mergeMoodSnaps(moodSnaps: filtered)!]
        }
    }
    return filtered
}

/**
 Returns an array of elements from `healthSnaps` that coincide with the same day of `date`. The optional `flatten` parameter merges them into their single day equivalent.
 */
@inline(__always) func getHealthSnapsByDate(data: HealthManager, date: Date, flatten: Bool = false) -> [HealthSnapStruct] {
    var filtered: [HealthSnapStruct] = []
    let dateComponents = date.getComponents()
    for healthSnap in data.healthSnaps {
        if healthSnap.timestamp.getComponents() == dateComponents {
            filtered.append(healthSnap)
        }
    }
    if flatten {
        if filtered.count > 0 {
            filtered = [mergeHealthSnaps(healthSnaps: filtered)!]
        }
    }
    return filtered
}

/**
 Returns an array of elements from `moodSnaps` that sit within a window of `windowStart` and `windowEnd` days after `date`. The optional `flatten` parameter merges them into their single day equivalents on a per-day basis.
 */
@inline(__always) func getMoodSnapsByDateWindow(data: DataStoreClass, date: Date, windowStart: Int, windowEnd: Int, flatten: Bool = false) -> [MoodSnapStruct] {
    var filtered: [MoodSnapStruct] = []
    var moodSnaps: ContiguousArray<MoodSnapStruct?> = []
    
    if flatten {
        moodSnaps = data.flattenedSequencedMoodSnaps
    } else {
        moodSnaps = data.moodSnaps
    }

    let startDate = date.addDays(days: windowStart).startOfDay()
    let endDate = date.addDays(days: windowEnd).endOfDay()

    for moodSnap in moodSnaps {
        if moodSnap != nil {
            if moodSnap!.timestamp >= startDate && moodSnap!.timestamp <= endDate {
                if moodSnap!.snapType == .mood {
                    filtered.append(moodSnap!)
                }
            }
        }
    }
    
    return filtered
}

/**
 Does `string` contain `hashtag`.
 */
@inline(__always) func containsHashtag(string: String, hashtag: String) -> Bool {
    let hashtags = getHashtags(string: string.lowercased())
    let result = hashtags.contains(hashtag)
    return result
}
