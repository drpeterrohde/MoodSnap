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
            let hBarStep: CGFloat = (geometry.size.width - 35) / 4
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
                                                color: self.irritabilityColor,
                                                withDot: double)
                        }
                    }
                }
            }
        }.frame(height: 60)
    }
}

/**
 View for rounded rectangle with superimposed dot.
 */
struct RoundedRectangleDot: View {
    var widthOuter: CGFloat
    var widthInner: CGFloat
    var color: Color
    var withDot: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .frame(width: widthOuter, height: 10)
                .foregroundColor(color)
            if withDot {
                RoundedRectangle(cornerRadius: 10.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .frame(width: 10, height: 10, alignment: .topLeading)
                    .brightness(0.2)
                    .foregroundColor(color)
                    .padding(.leading, max(0, widthInner - 10))
            }
        }
    }
}
