import SwiftUI

/**
 Get y-axis bound from maximum range of `data` snapped to multiple of 0.5.
 */
func getAxisBound(data: [CGFloat?]) -> CGFloat {
    var bound: CGFloat = 0
    for item in data {
        if item != nil {
            bound = max(bound, abs(item!))
        }
    }
    return ceil(2 * bound) / 2.0
}

/**
 The total number of recorded symptoms in a given `moodSnap`
 */
func totalSymptoms(moodSnap: MoodSnapStruct, settings: SettingsStruct) -> Int {
    var mask: [Bool] = []
    for i in 0 ..< symptomList.count {
        mask.append(moodSnap.symptoms[i] && settings.symptomVisibility[i])
    }
    let total = mask.filter { $0 }.count
    return total
}

/**
 The total number of recorded activities in a given `moodSnap`
 */
func totalActivities(moodSnap: MoodSnapStruct, settings: SettingsStruct) -> Int {
    var mask: [Bool] = []
    for i in 0 ..< activityList.count {
        mask.append(moodSnap.activities[i] && settings.activityVisibility[i])
    }
    let total = mask.filter { $0 }.count
    return total
}

/**
 The total number of recorded social activities in a given `moodSnap`
 */
func totalSocial(moodSnap: MoodSnapStruct, settings: SettingsStruct) -> Int {
    var mask: [Bool] = []
    for i in 0 ..< socialList.count {
        mask.append(moodSnap.social[i] && settings.socialVisibility[i])
    }
    let total = mask.filter { $0 }.count
    return total
}

/**
 How many visible symptoms are there?
 */
func visibleSymptomsCount(settings: SettingsStruct) -> Int {
    var count: Int = 0
    for i in 0 ..< symptomList.count {
        if settings.symptomVisibility[i] {
            count += 1
        }
    }
    return count
}

/**
 How many visible activities are there?
 */
func visibleActivitiesCount(settings: SettingsStruct) -> Int {
    var count: Int = 0
    for i in 0 ..< activityList.count {
        if settings.activityVisibility[i] {
            count += 1
        }
    }
    return count
}

/**
 How many visible social activities are there?
 */
func visibleSocialCount(settings: SettingsStruct) -> Int {
    var count: Int = 0
    for i in 0 ..< socialList.count {
        if settings.socialVisibility[i] {
            count += 1
        }
    }
    return count
}

/**
 Delete a `moodSnap` from an array of `moodSnaps`.
 */
func deleteHistoryItem(moodSnaps: [MoodSnapStruct], moodSnap: MoodSnapStruct) -> [MoodSnapStruct] {
    return moodSnaps.filter { $0.id != moodSnap.id }
}

/**
 Format a mood level string to single decimal place accuracy.
 */
func formatMoodLevelString(value: CGFloat?) -> String {
    if value != nil {
        var floatVal: CGFloat = value!

        floatVal = CGFloat(round(10 * floatVal) / 10)

        var str = ""
        if floatVal < 0 {
            str = String(format: " %.1f", floatVal)
        } else if floatVal > 0 {
            str = String(format: " +%.1f", floatVal)
        } else {
            str = String(format: "  %.1f", abs(floatVal))
        }

        return str
    } else {
        return "    -"
    }
}

/**
 Get list of events.
 */
func getEventsList(moodSnaps: [MoodSnapStruct], window: Int? = nil) -> [(String, Date)] {
    var list: [(String, Date)] = []

    var filteredMoodSnaps: [MoodSnapStruct] = []

    if window == nil {
        filteredMoodSnaps = moodSnaps
    } else {
        filteredMoodSnaps = getMoodSnapsByDateWindow(moodSnaps: moodSnaps, date: Date(), windowStart: -window!, windowEnd: 0)
    }

    for moodSnap in sortByDate(moodSnaps: filteredMoodSnaps) {
        if moodSnap.snapType == .event {
            list.append((moodSnap.event, moodSnap.timestamp))
        }
    }

    return list
}

/**
 Does an array of `data` contain any non-nil entries?
 */
func hasData(data: [CGFloat?]) -> Bool {
    for item in data {
        if item != nil {
            return true
        }
    }
    return false
}

/**
 Make introductory MoodSnap with quick start information
 */
func makeIntroSnap() -> [MoodSnapStruct] {
    var mediaSnap = MoodSnapStruct()
    mediaSnap.snapType = .custom
    mediaSnap.customView = 1
    return [mediaSnap]
}

/**
 How many user-created `moodSnaps` entries are there?
 */
func countMoodSnaps(moodSnaps: [MoodSnapStruct], type: SnapTypeEnum = .mood) -> Int {
    var count: Int = 0

    for moodSnap in moodSnaps {
        if moodSnap.snapType == type {
            count += 1
        }
    }

    return count
}
