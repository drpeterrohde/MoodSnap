import SwiftUI

func totalSymptoms(moodSnap: MoodSnapStruct, settings: SettingsStruct) -> Int {
    var mask: [Bool] = []
    for i in 0..<symptomList.count {
        mask.append(moodSnap.symptoms[i] && settings.symptomVisibility[i])
    }
    let total = mask.filter{$0}.count
    return total
}

func totalActivities(moodSnap: MoodSnapStruct, settings: SettingsStruct) -> Int {
    var mask: [Bool] = []
    for i in 0..<activityList.count {
        mask.append(moodSnap.activities[i] && settings.activityVisibility[i])
    }
    let total = mask.filter{$0}.count
    return total
}

func totalSocial(moodSnap: MoodSnapStruct, settings: SettingsStruct) -> Int {
    var mask: [Bool] = []
    for i in 0..<socialList.count {
        mask.append(moodSnap.social[i] && settings.socialVisibility[i])
    }
    let total = mask.filter{$0}.count
    return total
}

func visibleSymptoms(settings: SettingsStruct) -> Int {
    var count: Int = 0
    for i in 0..<symptomList.count {
        if settings.symptomVisibility[i] {
            count += 1
        }
    }
    return count
}
    
func visibleActivities(settings: SettingsStruct) -> Int {
    var count: Int = 0
    for i in 0..<activityList.count {
        if settings.activityVisibility[i] {
            count += 1
        }
    }
    return count
}

func visibleSocial(settings: SettingsStruct) -> Int {
    var count: Int = 0
    for i in 0..<socialList.count {
        if settings.socialVisibility[i] {
            count += 1
        }
    }
    return count
}

func todaysDateComponents() -> DateComponents {
    return Calendar.current.dateComponents([.day, .month, .year], from: Date())
}

func getDateComponents(date: Date) -> DateComponents? {
    return Calendar.current.dateComponents([.day, .month, .year], from: date)
}

func subtractDaysFromDate(date: Date, days: Int) -> Date? {
    let dayComp = DateComponents(day: -days)
    let date = Calendar.current.date(byAdding: dayComp, to: date)
    return date
}

func duplicateMoodSnapStruct(moodSnap: MoodSnapStruct) {
    var duplicate = moodSnap
    duplicate.id = UUID()
}

func deleteHistoryItem(moodSnaps: [MoodSnapStruct], moodSnap: MoodSnapStruct) -> [MoodSnapStruct] {
    return moodSnaps.filter {$0.id != moodSnap.id}
}

func formatMoodLevelString(activity: InfluencesEntryStruct, which: LevelsEnum) -> String {
    return formatMoodLevelString(activity: activity, which: which.rawValue)
}

func formatMoodLevelString(activity: InfluencesEntryStruct, which: Int) -> String {
    var val: CGFloat?
    
    switch which {
    case LevelsEnum.elevation.rawValue:
        val = activity.elevation
    case LevelsEnum.depression.rawValue:
        val = activity.depression
    case LevelsEnum.anxiety.rawValue:
        val = activity.anxiety
    case LevelsEnum.irritability.rawValue:
        val = activity.irritability
    case LevelsEnum.elevationVolatility.rawValue:
        val = activity.elevationVolatility
    case LevelsEnum.depressionVolatility.rawValue:
        val = activity.depressionVolatility
    case LevelsEnum.anxietyVolatility.rawValue:
        val = activity.anxietyVolatility
    case LevelsEnum.irritabilityVolatility.rawValue:
        val = activity.irritabilityVolatility
    default:
        val = nil
    }
    
    if (val != nil) {
        var floatVal: CGFloat = val!
        
        floatVal = CGFloat(round(10 * floatVal) / 10)
    
        var str = ""
        if (floatVal <= 0) {
            str = String(format: " %.1f ", floatVal)
        } else {
            str = String(format: " +%.1f ", floatVal)
        }
    
        return str
    } else {
        return "-"
    }
}
