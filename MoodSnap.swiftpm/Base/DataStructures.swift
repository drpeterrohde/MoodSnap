import SwiftUI

struct SettingsStruct: Identifiable, Codable {
    var id: UUID = UUID()
    
    // PDF report
    var username: String = ""
    var includeNotes: Bool = true
    var includeActivities: Bool = true
    var includeEvents: Bool = true
    var reportPeriod: TimeScaleEnum = TimeScaleEnum.month
    //var reportTheme: Int = 0
    
    // Visibility
    var symptomVisibility: [Bool] = [Bool](repeating: true, count: symptomList.count)
    var activityVisibility: [Bool] = [Bool](repeating: true, count: activityList.count)
    var socialVisibility: [Bool] = [Bool](repeating: true, count: socialList.count)
    
    var reminderOn: [Bool] = [false, false]
    var reminderTime: [Date] = [
        Calendar.current.date(from: DateComponents(hour: 8, minute: 0))!,
        Calendar.current.date(from: DateComponents(hour: 20, minute: 0))!
    ]
    var healthDistanceOn: Bool = false
    var healthMenstrualOn: Bool = false
    var healthSleepOn: Bool = false
    var healthWeightOn: Bool = false
    
    var numberOfGridColumns: Int = 3
    var slidingWindowSize: Int = 14
    
    var saveMediaToCameraRoll: Bool = true
    
    var theme: Int = 0
}

struct MoodSnapStruct: Identifiable, Codable {
    var id: UUID = UUID()
    var timestamp: Date = Date()
    var snapType: SnapTypeEnum = .mood
    
    // Mood
    var elevation: CGFloat = 0
    var depression: CGFloat = 0
    var anxiety: CGFloat = 0
    var irritability: CGFloat = 0
    
    // Symptoms, activities & social
    var symptoms = [Bool](repeating: false, count: symptomList.count)
    var activities = [Bool](repeating: false, count: activityList.count)
    var social = [Bool](repeating: false, count: socialList.count)
    
    // Event
    var event: String = ""
    
    // Notes
    var notes: String = ""
}

func DummyMoodSnapStruct() -> MoodSnapStruct {
    var moodSnap = MoodSnapStruct()
    moodSnap.elevation = -1
    moodSnap.depression = -1
    moodSnap.anxiety = -1
    moodSnap.irritability = -1
    return moodSnap
}

struct HealthKitDataStruct: Identifiable, Codable {
    var id: UUID = UUID()
    
    var walkingRunningDistance: [CGFloat?] = []
    var activeEnergy: [CGFloat?] = []
    var weight: [CGFloat?] = []
    var sleepHours: [CGFloat?] = []
    var lastDate: Date = Date()
    // menstrual cycle ???
}

struct InfluencesEntryStruct: Identifiable {
    var id: UUID = UUID()
    
    var activity: String = ""
    
    var elevation: CGFloat? = nil
    var depression: CGFloat? = nil
    var anxiety: CGFloat? = nil
    var irritability: CGFloat? = nil
    
    var elevationVolatility: CGFloat? = nil
    var depressionVolatility: CGFloat? = nil
    var anxietyVolatility: CGFloat? = nil
    var irritabilityVolatility: CGFloat? = nil
}
