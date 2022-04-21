import SwiftUI

/**
 Does `moodSnap` satisfy the given filtering constriants?
 */
func snapFilter(moodSnap: MoodSnapStruct, filter: SnapTypeEnum, searchText: String) -> Bool {
    let filterOutcome =
        (filter == .mood && moodSnap.snapType == .mood) ||
        (filter == .event && moodSnap.snapType == .event) ||
        (filter == .note && moodSnap.snapType == .note) ||
        (filter == .media && moodSnap.snapType == .media)

    if filterOutcome { return true }

    if filter == .none {
        let eventTextOutcome = moodSnap.event.lowercased().contains(searchText.lowercased()) || (searchText == "")
        let notesTextOutcome = moodSnap.notes.lowercased().contains(searchText.lowercased()) || (searchText == "")

        if eventTextOutcome || notesTextOutcome {
            return true
        }
    }

    return false
}

/**
 Returns the earliest `Date` amongst `moodSnaps`.
 */
func getFirstDate(moodSnaps: [MoodSnapStruct]) -> Date {
    var firstDate = Date()
    for moodSnap in moodSnaps {
        if moodSnap.timestamp < firstDate {
            firstDate = moodSnap.timestamp
        }
    }
    return firstDate.startOfDay()
}

/**
 Returns the most recent `Date` amongst `moodSnaps`.
 */
func getLastDate(moodSnaps: [MoodSnapStruct]) -> Date {
    var lastDate = Date()
    for moodSnap in moodSnaps {
        if moodSnap.timestamp > lastDate {
            lastDate = moodSnap.timestamp
        }
    }
    return lastDate
}

/**
 Returns an array of elements from `moodSnaps` that coincide with the same day of `date`. The optional `flatten` parameter merges them into their single day equivalent.
 */
func getMoodSnapsByDate(moodSnaps: [MoodSnapStruct], date: Date, flatten: Bool = false) -> [MoodSnapStruct] {
    var filtered: [MoodSnapStruct] = []
    let dateComponents = date.getComponents()
    for moodSnap in moodSnaps {
        if moodSnap.timestamp.getComponents() == dateComponents {
            filtered.append(moodSnap)
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
func getHealthSnapsByDate(healthSnaps: [HealthSnapStruct], date: Date, flatten: Bool = false) -> [HealthSnapStruct] {
    var filtered: [HealthSnapStruct] = []
    let dateComponents = date.getComponents()
    for healthSnap in healthSnaps {
        if healthSnap.timestamp.getComponents() == dateComponents {
            filtered.append(healthSnap)
        }
    }
//    if flatten {
//        if filtered.count > 0 {
//            filtered = [mergeHealthSnaps(healthSnaps: filtered)!]
//        }
//    }
    return filtered
}

/**
 Returns an array of elements from `moodSnaps` that sit within a window of `windowStart` and `windowEnd` days after `date`. The optional `flatten` parameter merges them into their single day equivalents on a per-day basis.
 */
func getMoodSnapsByDateWindow(moodSnaps: [MoodSnapStruct], date: Date, windowStart: Int, windowEnd: Int, flatten: Bool = false) -> [MoodSnapStruct] {
    var filtered: [MoodSnapStruct] = []
    for time in windowStart ... windowEnd {
        let thisDate = date.addDays(days: time)
        let theseSnaps = getMoodSnapsByDate(moodSnaps: moodSnaps, date: thisDate, flatten: flatten)
        filtered.append(contentsOf: theseSnaps)
    }
    return filtered
}

/**
 Returns an array of elements from `healthSnaps` that sit within a window of `windowStart` and `windowEnd` days after `date`. The optional `flatten` parameter merges them into their single day equivalents on a per-day basis.
 */
func getHealthSnapsByDateWindow(healthSnaps: [HealthSnapStruct], date: Date, windowStart: Int, windowEnd: Int, flatten: Bool = false) -> [HealthSnapStruct] {
    var filtered: [HealthSnapStruct] = []
    for time in windowStart ... windowEnd {
        let thisDate = date.addDays(days: time)
        let theseSnaps = getHealthSnapsByDate(healthSnaps: healthSnaps, date: thisDate, flatten: flatten)
        filtered.append(contentsOf: theseSnaps)
    }
    return filtered
}
