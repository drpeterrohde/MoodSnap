import SwiftUI

/**
 Return the element from `moodSnaps` with UUID `id` if it exists.
 */
func getMoodSnapByUUID(moodSnaps: [MoodSnapStruct], id: UUID) -> MoodSnapStruct? {
    if let item = moodSnaps.first(where: { $0.id == id }) {
        return item
    }
    return nil
}

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
        let notesTextOutcome = moodSnap.notes.lowercased().contains(searchText.lowercased())  || (searchText == "")
        
        if (eventTextOutcome || notesTextOutcome) {
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
    return firstDate
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
        if (moodSnap.timestamp.getComponents() == dateComponents) {
            filtered.append(moodSnap)
        }
    }
    if flatten {
        if (filtered.count > 0) {
            filtered = [mergeMoodSnaps(moodSnaps: filtered)!]
        }
    }
    return filtered
}

/**
 Returns an array of elements from `moodSnaps` that sit within a window of `windowStart` and `windowEnd` days after `date`. The optional `flatten` parameter merges them into their single day equivalents on a per-day basis.
 */
func getMoodSnapsByDateWindow(moodSnaps: [MoodSnapStruct], date: Date, windowStart: Int, windowEnd: Int, flatten: Bool = false) -> [MoodSnapStruct] {
    var filtered: [MoodSnapStruct] = []
    for time in windowStart...windowEnd { //???
        let thisDate = date.addDays(days: time)
        let theseSnaps = getMoodSnapsByDate(moodSnaps: moodSnaps, date: thisDate, flatten: flatten)
        filtered.append(contentsOf: theseSnaps)
    }
    return filtered
}

/**
 Returns array of `moodSnaps` flattened on a per-day basis.
 */
func getFlattenedMoodSnaps(moodSnaps: [MoodSnapStruct]) -> [MoodSnapStruct] {
    let flattened = getMoodSnapsByDateWindow(moodSnaps: moodSnaps, date: Date(), windowStart: -100, windowEnd: 1, flatten: true)
    // Make this more efficient ???
    //print(flattened)
    return flattened
}