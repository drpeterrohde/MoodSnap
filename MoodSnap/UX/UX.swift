import Charts
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
    var logoColor: Color = Color(0x2D65AF) // Color(0x3069AC)

    // Dimensions
    var hBarHeight: CGFloat = 11
    var hBarRadius: CGFloat = 5
    var hBarFontSize: CGFloat = 12
    var controlIconSize: CGFloat = 25
    var controlBigIconSize: CGFloat = 40
    var closeButtonIconSize: CGFloat = 25

    var vBarStep: CGFloat = 10

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
    // let ibmColorBlindPaletteBlack = Color(0x000000)
    // let ibmColorBlindPaletteWhite = Color(0xFFFFFF)

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
let themes = [AquaTheme(), ColorBlindTheme(), OrangeTheme(), PrimaryTheme()]
