import SwiftUI

/**
 Data structure for settings.
 */
struct SettingsStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    // First use of the app
    var firstUse = true

    // PDF report
    var username: String = ""
    var includeNotes: Bool = true
    var includeActivities: Bool = true
    var includeEvents: Bool = true
    var reportPeriod: Int = TimeScaleEnum.month.rawValue
    var reportBlackAndWhite: Bool = true
    var reportIncludeInterpretation: Bool = true

    // Visibility
    var symptomVisibility: [Bool] = [Bool](repeating: true, count: symptomList.count)
    var activityVisibility: [Bool] = [Bool](repeating: true, count: activityList.count)
    var socialVisibility: [Bool] = [Bool](repeating: true, count: socialList.count)
    var quoteVisibility: Bool = true

    var reminderOn: [Bool] = [false, false]
    var reminderTime: [Date] = [
        Calendar.current.date(from: DateComponents(hour: 8, minute: 0))!,
        Calendar.current.date(from: DateComponents(hour: 20, minute: 0))!,
    ]

    var useFaceID: Bool = false

    var useHealthKit: Bool = true
    var workoutsOn: Bool = false
    var healthUnits: MeasurementUnitsEnum = .metric
    var healthDistanceOn: Bool = true
    var healthMenstrualOn: Bool = true
    var healthSleepOn: Bool = true
    var healthWeightOn: Bool = true
    var healthEnergyOn: Bool = true

    var numberOfGridColumns: Int = 3
    var slidingWindowSize: Int = 14

    var saveMediaToCameraRoll: Bool = true

    var addedSnaps: Int = 0

    var theme: Int = 0
}

/**
 Data structure for MoodSnaps.
 */
struct MoodSnapStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    var timestamp: Date = Date()
    var snapType: SnapTypeEnum = .mood

    // Mood
    var elevation: CGFloat = 0
    var depression: CGFloat = 0
    var anxiety: CGFloat = 0
    var irritability: CGFloat = 0

    // Symptoms, activities & social
    var symptoms: [Bool] = [Bool](repeating: false, count: symptomList.count)
    var activities: [Bool] = [Bool](repeating: false, count: activityList.count)
    var social: [Bool] = [Bool](repeating: false, count: socialList.count)

    // Event
    var event: String = ""

    // Notes
    var notes: String = ""

    // Custom view
    var customView: Int = 0
}

/**
 Data structure for HealthSnaps.
 */
struct HealthSnapStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    var timestamp: Date = Date()

    var walkingRunningDistance: CGFloat? = nil
    var activeEnergy: CGFloat? = nil
    var weight: CGFloat? = nil
    var sleepHours: CGFloat? = nil
    var menstrual: CGFloat? = nil
}

/**
 Data structure for transient butterfly plot.
 */
struct ButterflyEntryStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    var timestamp: Date = Date() // Only used for events

    var activity: String = ""
    var occurrences: Int = 0

    var elevation: [CGFloat?] = []
    var depression: [CGFloat?] = []
    var anxiety: [CGFloat?] = []
    var irritability: [CGFloat?] = []

    var elevationVolatility: [CGFloat?] = []
    var depressionVolatility: [CGFloat?] = []
    var anxietyVolatility: [CGFloat?] = []
    var irritabilityVolatility: [CGFloat?] = []
}

/**
 Data structure for user interface state.
 */
struct UXStateStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    var isAverageMoodExpanded: Bool = true
    var isMoodHistoryExpanded: Bool = true
    var isMovingAverageExpanded: Bool = true
    var isVolatilityExpanded: Bool = true
    var isTallyExpanded: Bool = true
    var isActivitiesExpanded: Bool = true
    var isSocialExpanded: Bool = true
    var isSymptomSummaryExpanded: Bool = true
    var isEventSummaryExpanded: Bool = true
    var isHashtagSummaryExpanded: Bool = true
    var isButterflyAverageExpanded: Bool = true
    var isWeightExpanded: Bool = true
    var isWalkingRunningDistanceExpanded: Bool = true
    var isActiveEnergyExpanded: Bool = true
    var isMenstrualExpanded: Bool = true
    var isSleepExpanded: Bool = true
}

/**
 Data structure for statistics at a point.
 */
struct StatsEntryStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    var levelE: CGFloat? = nil
    var levelD: CGFloat? = nil
    var levelA: CGFloat? = nil
    var levelI: CGFloat? = nil

    var averageE: CGFloat? = nil
    var averageD: CGFloat? = nil
    var averageA: CGFloat? = nil
    var averageI: CGFloat? = nil

    var volatilityE: CGFloat? = nil
    var volatilityD: CGFloat? = nil
    var volatilityA: CGFloat? = nil
    var volatilityI: CGFloat? = nil
}

/**
 Data structure for full history.
 */
struct HistoryStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    var levelE: [CGFloat?] = []
    var levelD: [CGFloat?] = []
    var levelA: [CGFloat?] = []
    var levelI: [CGFloat?] = []

    var averageE: [CGFloat?] = []
    var averageD: [CGFloat?] = []
    var averageA: [CGFloat?] = []
    var averageI: [CGFloat?] = []

    var volatilityE: [CGFloat?] = []
    var volatilityD: [CGFloat?] = []
    var volatilityA: [CGFloat?] = []
    var volatilityI: [CGFloat?] = []
}

/**
 Struct for processed data.
 */
struct ProcessedDataStruct: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    // Mood history
    var levelE: [CGFloat?] = []
    var levelD: [CGFloat?] = []
    var levelA: [CGFloat?] = []
    var levelI: [CGFloat?] = []

    // Sliding average history
    var averageE: [CGFloat?] = []
    var averageD: [CGFloat?] = []
    var averageA: [CGFloat?] = []
    var averageI: [CGFloat?] = []

    // Volatility history
    var volatilityE: [CGFloat?] = []
    var volatilityD: [CGFloat?] = []
    var volatilityA: [CGFloat?] = []
    var volatilityI: [CGFloat?] = []

    // Butterflies
    var activityButterfly: [ButterflyEntryStruct] = []
    var socialButterfly: [ButterflyEntryStruct] = []
    var symptomButterfly: [ButterflyEntryStruct] = []
    var eventButterfly: [ButterflyEntryStruct] = []
    var hashtagButterfly: [ButterflyEntryStruct] = []
}
