import SwiftUI

/**
 Make `Color` from RGB HEX string.
 */
extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

/**
 Return the mood colors as `UIColor`.
 */
@inline(__always) func moodUIColors(settings: SettingsStruct) -> [UIColor] {
    let colorE = UIColor(themes[settings.theme].elevationColor.opacity(lineChartOpacity))
    let colorD = UIColor(themes[settings.theme].depressionColor.opacity(lineChartOpacity))
    let colorA = UIColor(themes[settings.theme].anxietyColor.opacity(lineChartOpacity))
    let colorI = UIColor(themes[settings.theme].irritabilityColor.opacity(lineChartOpacity))

    return [colorE, colorD, colorA, colorI]
}
