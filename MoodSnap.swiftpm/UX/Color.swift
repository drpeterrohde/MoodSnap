import SwiftUI

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

func moodUIColors(settings: SettingsStruct) -> [UIColor] {
    let colorE = UIColor(themes[settings.theme].elevationColor)
    let colorD = UIColor(themes[settings.theme].depressionColor)
    let colorA = UIColor(themes[settings.theme].anxietyColor)
    let colorI = UIColor(themes[settings.theme].irritabilityColor)
    
    return [colorE, colorD, colorA, colorI]
}
