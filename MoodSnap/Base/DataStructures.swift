import SwiftUI

/**
 Data structure represnting processing status.
 */
struct ProcessingStatus {
    var data: Task<Void, Never>? = nil // All data processing processes
    var health: Task<Void, Never>? = nil // All health processing processes
    
    var history: Bool = false
    var averages: Bool = false
    var events: Bool = false
    var hashtags: Bool = false
    var activities: Bool = false
    var social: Bool = false
    var symptoms: Bool = false
    
    var weight: Bool = false
    var distance: Bool = false
    var energy: Bool = false
    var sleep: Bool = false
    var menstrual: Bool = false
}

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

    var timestamp: Date = Date()

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
    
    var deltas: OccurencesStruct? = nil
    
    var timeline: [CGFloat?]? = []
}

/**
 Data strcuture for transient occurences.
 */
struct OccurencesStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    
    var beforeSymptoms: [Double] = []
    var beforeActivities: [Double] = []
    var beforeSocial: [Double] = []
    var beforeHashtags: [Double] = []
    
    var afterSymptoms: [Double] = []
    var afterActivities: [Double] = []
    var afterSocial: [Double] = []
    var afterHashtags: [Double] = []
    
    var deltaSymptoms: [Double] = []
    var deltaActivities: [Double] = []
    var deltaSocial: [Double] = []
    var deltaHashtags: [Double] = []
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

struct CorrelationsStruct: Codable, Hashable {
    var correlationEE: CGFloat? = nil
    var correlationED: CGFloat? = nil
    var correlationEA: CGFloat? = nil
    var correlationEI: CGFloat? = nil

    var correlationDE: CGFloat? = nil
    var correlationDD: CGFloat? = nil
    var correlationDA: CGFloat? = nil
    var correlationDI: CGFloat? = nil

    var correlationAE: CGFloat? = nil
    var correlationAD: CGFloat? = nil
    var correlationAA: CGFloat? = nil
    var correlationAI: CGFloat? = nil

    var correlationIE: CGFloat? = nil
    var correlationID: CGFloat? = nil
    var correlationIA: CGFloat? = nil
    var correlationII: CGFloat? = nil
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
    
    // Weekly trend
    var elevationTrend: String? = nil
    var depressionTrend: String? = nil
    var anxietyTrend: String? = nil
    var irritabilityTrend: String? = nil

    // Average & volatility
    var averageMood: AverageMoodDataStruct? = AverageMoodDataStruct()
    var averageVolatility: AverageMoodDataStruct? = AverageMoodDataStruct()
    
    // Butterflies
    var activityButterfly: [ButterflyEntryStruct] = []
    var socialButterfly: [ButterflyEntryStruct] = []
    var symptomButterfly: [ButterflyEntryStruct] = []
    var eventButterfly: [ButterflyEntryStruct] = []
    var hashtagButterfly: [ButterflyEntryStruct] = []
}

/**
 Struct for average mood data.
 */
struct AverageMoodDataStruct: Codable, Hashable {
    var flatAll: MoodSnapStruct? = MoodSnapStruct()
    var allAll: MoodSnapStruct? = MoodSnapStruct()
    
    var flatMonth: MoodSnapStruct? = MoodSnapStruct()
    var allMonth: MoodSnapStruct? = MoodSnapStruct()
    
    var flatThreeMonths: MoodSnapStruct? = MoodSnapStruct()
    var allThreeMonths: MoodSnapStruct? = MoodSnapStruct()
    
    var flatSixMonths: MoodSnapStruct? = MoodSnapStruct()
    var allSixMonths: MoodSnapStruct? = MoodSnapStruct()
    
    var flatYear: MoodSnapStruct? = MoodSnapStruct()
    var allYear: MoodSnapStruct? = MoodSnapStruct()
}

