import HealthKit
import SwiftUI

/**
 The total number of recorded symptoms in a given `moodSnap`
 */
@inline(__always) func totalSymptoms(moodSnap: MoodSnapStruct, settings: SettingsStruct) -> Int {
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
@inline(__always) func totalActivities(moodSnap: MoodSnapStruct, settings: SettingsStruct) -> Int {
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
@inline(__always) func totalSocial(moodSnap: MoodSnapStruct, settings: SettingsStruct) -> Int {
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
@inline(__always) func visibleSymptomsCount(settings: SettingsStruct) -> Int {
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
@inline(__always) func visibleActivitiesCount(settings: SettingsStruct) -> Int {
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
@inline(__always) func visibleSocialCount(settings: SettingsStruct) -> Int {
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
@inline(__always) func deleteHistoryItem(moodSnaps: [MoodSnapStruct], moodSnap: MoodSnapStruct) -> [MoodSnapStruct] {
    return moodSnaps.filter { $0.id != moodSnap.id }
}

/**
 Format a count string to single decimal place accuracy.
 */
@inline(__always) func formatCountString(value: CGFloat?) -> String {
    if value != nil {
        var floatVal: CGFloat = value!

        floatVal = CGFloat(round(10 * floatVal) / 10)

        var str = ""
        if floatVal < 0 {
            str = String(format: " %.1f", floatVal)
        } else {
            str = String(format: "  %.1f", floatVal)
        }

        return str
    } else {
        return "    -"
    }
}

/**
 Format a mood level string to single decimal place accuracy.
 */
@inline(__always) func formatMoodLevelString(value: CGFloat?) -> String {
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
 Format a correlation level string to two decimal place accuracy.
 */
@inline(__always) func formatCorrelationString(value: CGFloat?) -> String {
    if value != nil {
        var floatVal: CGFloat = value!

        floatVal = CGFloat(round(100 * floatVal) / 100)

        var str = ""
        if floatVal < 0 {
            str = String(format: " %.2f", floatVal)
        } else if floatVal > 0 {
            str = String(format: " +%.2f", floatVal)
        } else {
            str = String(format: "  %.2f", abs(floatVal))
        }

        return str
    } else {
        return "     -"
    }
}

/**
 Get list of events.
 */
@inline(__always) func getEventsList(moodSnaps: [MoodSnapStruct], window: Int? = nil) -> [(String, Date)] {
    var list: [(String, Date)] = []

    var filteredMoodSnaps: [MoodSnapStruct] = []

    if window == nil {
        filteredMoodSnaps = moodSnaps
    } else {
        filteredMoodSnaps = getMoodSnapsByDateWindow(moodSnaps: moodSnaps, date: Date(), windowStart: -window!, windowEnd: 0)
    }

    for moodSnap in filteredMoodSnaps {
        if moodSnap.snapType == .event {
            list.append((moodSnap.event, moodSnap.timestamp))
        }
    }

    return list
}

/**
 Get list of menstruation dates.
 */
@inline(__always) func getMenstrualDates(healthSnaps: [HealthSnapStruct]) -> [Date] {
    var dates: [Date] = []

    for healthSnap in healthSnaps {
        if healthSnap.menstrual != nil {
            if healthSnap.menstrual != CGFloat(HKCategoryValueMenstrualFlow.none.rawValue) {
                dates.append(healthSnap.timestamp)
            }
        }
    }

    return dates
}

/**
 Does an array of `data` contain any non-nil entries?
 */
@inline(__always) func hasData(data: [CGFloat?]) -> Bool {
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
@inline(__always) func makeIntroSnap() -> [MoodSnapStruct] {
    var mediaSnap = MoodSnapStruct()
    mediaSnap.snapType = .custom
    mediaSnap.customView = 1
    return [mediaSnap]
}

/**
 How many user-created `moodSnaps` entries are there?
 */
@inline(__always) func countMoodSnaps(moodSnaps: [MoodSnapStruct], type: SnapTypeEnum = .mood) -> Int {
    var count: Int = 0

    for moodSnap in moodSnaps {
        if moodSnap.snapType == type {
            count += 1
        }
    }

    return count
}

/**
 How many user-created `healthSnaps` entries are there of a given `type`?
 */
@inline(__always) func countHealthSnaps(healthSnaps: [HealthSnapStruct], type: HealthTypeEnum) -> Int {
    var count = 0

    for healthSnap in healthSnaps {
        switch type {
        case .all:
            count += 1
        case .weight:
            if healthSnap.weight != nil {
                count += 1
            }
        case .distance:
            if healthSnap.walkingRunningDistance != nil {
                count += 1
            }
        case .sleep:
            if healthSnap.sleepHours != nil {
                count += 1
            }
        case .energy:
            if healthSnap.activeEnergy != nil {
                count += 1
            }
        case .menstrual:
            if healthSnap.menstrual != nil {
                count += 1
            }
        }
    }

    return count
}

/**
 Minimum of a set of `data` that may contain nil values.
 */
@inline(__always) func minWithNils(data: [CGFloat?]) -> CGFloat? {
    var minimum: CGFloat?

    for item in data {
        if minimum == nil {
            minimum = item
        } else {
            if item != nil {
                minimum = min(minimum!, item!)
            }
        }
    }

    return minimum
}

/**
 Maximum of a set of `data` that may contain nil values.
 */
@inline(__always) func maxWithNils(data: [CGFloat?]) -> CGFloat? {
    var maximum: CGFloat?

    for item in data {
        if maximum == nil {
            maximum = item
        } else {
            if item != nil {
                maximum = max(maximum!, item!)
            }
        }
    }

    return maximum
}

/**
 Get string for weight `value` depending on type of `units`.
 */
@inline(__always) func getWeightString(value: Double, units: MeasurementUnitsEnum) -> String {
    var str: String = ""
    
    switch units {
    case .metric:
        str = String(format: "%.1f", value) + "kg"
    case .imperial:
        str = String(format: "%.1f", 2.20462 * value) + "lb"
    }
    
    return str
}

/**
 Get string for distance `value` depending on type of `units`.
 */
@inline(__always) func getDistanceString(value: Double, units: MeasurementUnitsEnum) -> String {
    var str: String = ""
    
    switch units {
    case .metric:
        str = String(format: "%.1f", value) + "km"
    case .imperial:
        str = String(format: "%.1f", 0.621371 * value) + "mi"
    }
    
    return str
}

/**
 Get string for energy `value` depending on type of `units`.
 */
@inline(__always) func getEnergyString(value: Double, units: MeasurementUnitsEnum) -> String {
    var str: String = ""
    
    switch units {
    case .metric:
        str = String(format: "%.1f", value) + "kJ"
    case .imperial:
        str = String(format: "%.1f", 0.239006 * value) + "kcal"
    }
    
    return str
}

/**
 Get app version number.
 */
extension UIApplication {
    static var appVersion: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        return version ?? "-"
    }
}

/**
 Get the average mood from `levels` over `timescale`.
 */
func getByTimescale(levels: AverageMoodDataStruct?, timescale: Int) -> (MoodSnapStruct?, MoodSnapStruct?) {
    if levels == nil {
        return (nil, nil)
    } else {
        switch timescale {
        case TimeScaleEnum.all.rawValue:
            return (levels!.flatAll, levels!.allAll)
        case TimeScaleEnum.month.rawValue:
            return (levels!.flatMonth, levels!.allMonth)
        case TimeScaleEnum.threeMonths.rawValue:
            return (levels!.flatThreeMonths, levels!.allThreeMonths)
        case TimeScaleEnum.sixMonths.rawValue:
            return (levels!.flatSixMonths, levels!.allSixMonths)
        case TimeScaleEnum.year.rawValue:
            return (levels!.flatYear, levels!.allYear)
        default:
            return (levels!.flatAll, levels!.allAll)
        }
    }
}
