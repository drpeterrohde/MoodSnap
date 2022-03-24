import SwiftUI

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
 Enumeration of the different mood level and mood volatility types.
 */
enum LevelsEnum: Int, CaseIterable {
    case elevation = 0
    case depression = 1
    case anxiety = 2
    case irritability = 3
    case elevationVolatility = 4
    case depressionVolatility = 5
    case anxietyVolatility = 6
    case irritabilityVolatility = 7
}

/**
 Enumeration of the different viewing timescales available to the user in the `StatsView`.
 */
enum TimeScaleEnum: Int, Codable {
    case month = 30
    case threeMonths = 90
    case sixMonths = 180
    case year = 365
}
