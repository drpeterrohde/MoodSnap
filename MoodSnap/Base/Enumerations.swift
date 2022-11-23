import SwiftUI

/**
 Enumeration for health data types.
 */
enum HealthTypeEnum: Int, Codable {
    case all = 0
    case weight = 1
    case distance = 2
    case sleep = 3
    case energy = 4
    case menstrual = 5
}

/**
 Enumeration for units of measurement (metric or imperial)
 */
enum MeasurementUnitsEnum: Int, Codable {
    case metric = 0
    case imperial = 1
}

/**
 Enumeration for different influence types.
 */
enum InfluenceTypeEnum: Int, Codable {
    case activity = 0
    case social = 1
    case symptom = 2
    case event = 3
    case hashtag = 4
}

/**
 Enumeration of different MoodSnap types.
 */
enum SnapTypeEnum: Int, Codable {
    case none = 0
    case mood = 1
    case note = 2
    case event = 3
    case media = 4
    case quote = 5
    case custom = 6
}

/**
 Enumeration of different mood types.
 */
enum MoodsEnum: Int, CaseIterable {
    case elevation = 0
    case depression = 1
    case anxiety = 2
    case irritability = 3
}

/**
 Enumeration of the different viewing timescales available to the user in the `StatsView`.
 */
enum TimeScaleEnum: Int, Codable {
    case all = 0
    case month = 30
    case threeMonths = 90
    case sixMonths = 180
    case year = 365
}

/**
 Enumerations for widget types.
 */
enum WidgetTypeEnum: Int, Codable {
    case movingAverageSmallThirty = 1
    case movingAverageMediumNinety = 2
    case movingAverageMediumAll = 3
    case moodHistoryLargeNinety = 4
    case moodHistoryLargeAll = 5
}
