import SwiftUI

/**
 Struct defining UX theme.
 */
struct ThemeStruct: Identifiable {
    var id: UUID = UUID()
    var version: Int = 1

    // Name
    var name: String = "Primary"

    // Colors
    var elevationColor: Color = Color.green
    var depressionColor: Color = Color.red
    var anxietyColor: Color = Color.orange
    var irritabilityColor: Color = Color.yellow

    var gridColor: Color = Color.gray.opacity(0.2)
    var buttonColor: Color = Color.primary
    var iconColor: Color = Color.primary
    var controlColor: Color = Color.primary
    var emergencyColor: Color = Color.red
    var logoColor: Color = Color(0x2D65AF)
    
    var menstrualColor: Color = Color(0xF47157)
    var menstrualLabelColor: Color = Color(0x5D5BDD)
    var walkingRunningColor: Color = Color(0xFE6532)
    var energyColor: Color = Color(0xFE6532)
    var weightColor: Color = Color(0xB15FE9)
    var sleepColor: Color = Color(0x86E2E0)
    
    // Dimensions
    var hBarHeight: CGFloat = 11
    var hBarRadius: CGFloat = 5
    var hBarFontSize: CGFloat = 12
    var controlIconSize: CGFloat = 25
    var controlBigIconSize: CGFloat = 40
    var closeButtonIconSize: CGFloat = 25

    var sliderSpacing: CGFloat = -5
    var historyGridSpacing: CGFloat = 7
    var moodSnapGridSpacing: CGFloat = 0

    var barShadeOffset: CGFloat = 1.0
}

/**
 Primary theme constructor.
 */
func PrimaryTheme() -> ThemeStruct {
    return ThemeStruct()
}

/**
 Color blind theme constructor.
 */
func ColorBlindTheme() -> ThemeStruct {
    let ibmColorBlindPaletteBlue = Color(0x648FFF)
    let ibmColorBlindPalettePurple = Color(0x785EF0)
    let ibmColorBlindPalettePink = Color(0xDC267F)
    let ibmColorBlindPaletteOrange = Color(0xFE6100)
    let ibmColorBlindPaletteYellow = Color(0xFFB000)

    var theme: ThemeStruct = ThemeStruct()
    theme.name = "color_blind"
    theme.buttonColor = Color.primary
    theme.iconColor = ibmColorBlindPaletteBlue
    theme.controlColor = ibmColorBlindPaletteBlue
    theme.elevationColor = ibmColorBlindPaletteBlue
    theme.depressionColor = ibmColorBlindPalettePink
    theme.anxietyColor = ibmColorBlindPaletteOrange
    theme.irritabilityColor = ibmColorBlindPaletteYellow
    theme.emergencyColor = ibmColorBlindPalettePurple
    return theme
}

/**
 Pastel theme constructor.
 */
func PastelTheme() -> ThemeStruct {
    let pastelBlue = Color(0x55CBCD)
    let pastelRed = Color(0xFF968A)
    let pastelCyan = Color(0xA2E1DB)
    let pastelOrange = Color(0xFFC8A2)
    let pastelYellow = Color(0xFFFFB5)

    var theme: ThemeStruct = ThemeStruct()
    theme.name = "pastel"
    theme.buttonColor = pastelBlue
    theme.iconColor = pastelBlue
    theme.controlColor = pastelBlue
    theme.elevationColor = pastelCyan
    theme.depressionColor = pastelRed
    theme.anxietyColor = pastelOrange
    theme.irritabilityColor = pastelYellow
    theme.emergencyColor = pastelRed
    return theme
}

/**
 Summer theme constructor.
 */
func SummerTheme() -> ThemeStruct {
    // let summerWhite = Color(0xF0F2E7)
    let summerRed = Color(0xFF8296)
    let summerCyan = Color(0x75CDD8)
    let summerOrange = Color(0xFFCA27)
    let summerYellow = Color(0xFFEC00)

    var theme: ThemeStruct = ThemeStruct()
    theme.name = "summer"
    theme.buttonColor = summerYellow
    theme.iconColor = summerYellow
    theme.controlColor = summerYellow
    theme.elevationColor = summerCyan
    theme.depressionColor = summerRed
    theme.anxietyColor = summerOrange
    theme.irritabilityColor = summerYellow
    theme.emergencyColor = summerRed
    return theme
}

/**
 Aqua theme constructor.
 */
func AquaTheme() -> ThemeStruct {
    var theme: ThemeStruct = ThemeStruct()
    theme.name = "Aqua"
    theme.buttonColor = Color.blue
    theme.iconColor = Color.blue
    theme.controlColor = Color.blue
    return theme
}

/**
 Orange theme constructor.
 */
func OrangeTheme() -> ThemeStruct {
    var theme: ThemeStruct = ThemeStruct()
    theme.name = "Orange"
    theme.buttonColor = Color.orange
    theme.iconColor = Color.orange
    theme.controlColor = Color.orange
    return theme
}

/**
 Themes list.
 */
let themes = [AquaTheme(), ColorBlindTheme(), OrangeTheme(), PrimaryTheme(), PastelTheme(), SummerTheme()]
