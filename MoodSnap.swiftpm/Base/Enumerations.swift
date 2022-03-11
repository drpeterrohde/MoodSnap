import SwiftUI

enum SnapTypeEnum: Encodable, Decodable {
    case none
    case mood
    case note
    case event
    case media
}

enum MoodsEnum: Int, CaseIterable {
    case elevation = 0
    case depression = 1
    case anxiety = 2
    case irritability = 3
}

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

enum TimeScaleEnum: Int, Encodable, Decodable {
    case month = 30
    case threeMonths = 90
    case sixMonths = 180
    case year = 365
}
