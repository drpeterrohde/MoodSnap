import SwiftUI

/**
 View showing mood levels for `moodSnap`.
 */
struct MoodLevelsView: View {
    @EnvironmentObject var data: DataStoreClass
    let moodSnapFlat: MoodSnapStruct
    let moodSnapAll: MoodSnapStruct
    let theme: ThemeStruct
    let blackAndWhite: Bool
    let double: Bool

    private var fontColor: Color
    private var elevationColor: Color
    private var depressionColor: Color
    private var anxietyColor: Color
    private var irritabilityColor: Color
    private var gridColor: Color

    init(moodSnapFlat: MoodSnapStruct, moodSnapAll: MoodSnapStruct, theme: ThemeStruct, blackAndWhite: Bool = false, double: Bool = false) {
        self.moodSnapFlat = moodSnapFlat
        self.moodSnapAll = moodSnapAll
        self.theme = theme
        self.blackAndWhite = blackAndWhite
        self.double = double

        fontColor = Color.secondary
        elevationColor = theme.elevationColor
        depressionColor = theme.depressionColor
        anxietyColor = theme.anxietyColor
        irritabilityColor = theme.irritabilityColor
        gridColor = theme.gridColor

        if blackAndWhite {
            fontColor = Color.black
            elevationColor = Color.black
            depressionColor = Color.black
            anxietyColor = Color.black
            irritabilityColor = Color.black
            gridColor = Color.gray
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let hBarStep: CGFloat = max(0, (geometry.size.width - 35) / 4)
            let hBarRadius = themes[data.settings.theme].hBarRadius
            let hBarHeight = themes[data.settings.theme].hBarHeight
            let hBarFontSize = themes[data.settings.theme].hBarFontSize
            
            ZStack {
                // Grid
                Path { path in
                    let offsetX: CGFloat = 20.0
                    let offsetY: CGFloat = 8.5
                    let stepY: CGFloat = 14.7

                    // Vertical gridlines
                    for i in 0 ... 4 {
                        path.move(to: CGPoint(x: Int(offsetX + CGFloat(i) * hBarStep), y: Int(offsetY)))
                        path.addLine(to: CGPoint(x: Int(offsetX + CGFloat(i) * hBarStep), y: Int(offsetY + 3 * stepY)))
                    }

                    // Horizontal gridlines
                    for i in 0 ... 3 {
                        path.move(to: CGPoint(x: Int(offsetX), y: Int(offsetY + CGFloat(i) * stepY)))
                        path.addLine(to: CGPoint(x: Int(offsetX + 4 * hBarStep), y: Int(offsetY + CGFloat(i) * stepY)))
                    }

                    path.closeSubpath()
                }.stroke(self.gridColor, lineWidth: 1)

                // Graph
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("E").font(Font.system(size: hBarFontSize, design: .monospaced))
                            .foregroundColor(self.fontColor)
                        ZStack(alignment: .topLeading) {
                                RoundedRectangleDot(widthOuter: moodSnapFlat.elevation * hBarStep + hBarHeight,
                                                    widthInner: moodSnapAll.elevation * hBarStep + hBarHeight,
                                                    radius: hBarRadius,
                                                    height: hBarHeight,
                                                    color: self.elevationColor,
                                                    withDot: double)
                        }
                        Spacer()
                    }
                    HStack {
                        Text("D").font(Font.system(size: hBarFontSize, design: .monospaced))
                            .foregroundColor(self.fontColor)
                        ZStack(alignment: .topLeading) {
                            RoundedRectangleDot(widthOuter: moodSnapFlat.depression * hBarStep + hBarHeight,
                                                widthInner: moodSnapAll.depression * hBarStep + hBarHeight,
                                                radius: hBarRadius,
                                                height: hBarHeight,
                                                color: self.depressionColor,
                                                withDot: double)
                        }
                        Spacer()
                    }
                    HStack {
                        Text("A").font(Font.system(size: hBarFontSize, design: .monospaced))
                            .foregroundColor(self.fontColor)
                        ZStack(alignment: .topLeading) {
                            RoundedRectangleDot(widthOuter: moodSnapFlat.anxiety * hBarStep + hBarHeight,
                                                widthInner: moodSnapAll.anxiety * hBarStep + hBarHeight,
                                                radius: hBarRadius,
                                                height: hBarHeight,
                                                color: self.anxietyColor,
                                                withDot: double)
                        }
                        Spacer()
                    }
                    HStack {
                        Text("I").font(Font.system(size: hBarFontSize, design: .monospaced))
                            .foregroundColor(self.fontColor)
                        ZStack(alignment: .topLeading) {
                            RoundedRectangleDot(widthOuter: moodSnapFlat.irritability * hBarStep + hBarHeight,
                                                widthInner: moodSnapAll.irritability * hBarStep + hBarHeight,
                                                radius: hBarRadius,
                                                height: hBarHeight,
                                                color: self.irritabilityColor,
                                                withDot: double)
                        }
                    }
                }
            }
        }.frame(height: 60)
    }
}
