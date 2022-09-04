import SwiftUI

/**
 View for displaying vertical bar chart.
 */
struct VerticalBarChart: View {
    var values: [CGFloat?]
    var color: Color
    var min: CGFloat
    var max: CGFloat
    var horizontalGridLines: Int = 0
    var verticalGridLines: Int = 0
    var blackAndWhite: Bool = false
    var shaded: Bool = false
    var settings: SettingsStruct

    private var fontColor: Color
    private var lineColor: Color
    private var gridColor: Color

    init(values: [CGFloat?], color: Color = .blue, min: CGFloat = 0.0, max: CGFloat = 4.0, horizontalGridLines: Int = 0, verticalGridLines: Int = 0, blackAndWhite: Bool = false, shaded: Bool = false, settings: SettingsStruct) {
        self.values = values
        self.color = color
        self.min = min
        self.max = max
        self.horizontalGridLines = horizontalGridLines
        self.verticalGridLines = verticalGridLines
        self.blackAndWhite = blackAndWhite
        self.shaded = shaded
        self.settings = settings

        fontColor = Color.secondary
        gridColor = themes[settings.theme].gridColor
        lineColor = color

        if blackAndWhite {
            fontColor = Color.gray
            lineColor = Color.black
            gridColor = Color.gray
        }
    }

    var body: some View {
        let spacing: CGFloat = chooseSpacing(values: values)

        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            ZStack {
                // Grid
                Path { path in
                    let horizontalGridStep: CGFloat = height / (CGFloat(horizontalGridLines) + 1.0)
                    let verticalGridStep: CGFloat = width / (CGFloat(verticalGridLines) + 1.0)

                    // Vertical gridlines
                    for i in 0 ... (verticalGridLines + 1) {
                        path.move(to: CGPoint(x: i * Int(verticalGridStep),
                                              y: 0))
                        path.addLine(to: CGPoint(x: i * Int(verticalGridStep),
                                                 y: Int(height)))
                    }

                    // Horizontal gridlines
                    for i in 0 ... (horizontalGridLines + 1) {
                        path.move(to: CGPoint(x: 0,
                                              y: i * Int(horizontalGridStep)))
                        path.addLine(to: CGPoint(x: Int(width),
                                                 y: i * Int(horizontalGridStep)))
                    }

                    path.closeSubpath()
                }.stroke(self.gridColor, lineWidth: 1)

                // Graph
                ForEach(0 ..< values.count, id: \.self) { i in
                    let thisData = values[i] ?? 0
                    let opacity = chooseOpacity(value: thisData, shaded: shaded, offset: themes[settings.theme].barShadeOffset, settings: settings)
                    let thisColor = self.lineColor.opacity(opacity)
                    Path { path in
                        if values[i] != nil {
                            let barWidth: CGFloat = (CGFloat(width) - spacing * (CGFloat(values.count) + 1.0)) / CGFloat(values.count)
                            var barHeight: CGFloat
                            if values[i] == 0 {
                                barHeight = (values[i]! + zeroGraphicalBarOffset - min) * CGFloat(height) / (max - min)
                            } else {
                                barHeight = (values[i]! - min) * CGFloat(height) / (max - min)
                            }
                            if values[i] == nil {
                                barHeight = 0
                            }
                            let xPos: CGFloat = spacing + CGFloat(i) * (barWidth + spacing)
                            let rect = CGRect(origin: CGPoint(x: xPos,
                                                              y: CGFloat(height)),
                                              size: CGSize(width: barWidth, height: -barHeight))
                            path.addRect(rect)
                        }
                    }.fill(thisColor)
                }
            }
        }//.frame(height: 60)
    }
}

/**
Choose bar spcaing for differen timecsales given by number of elements in `values`.
*/
func chooseSpacing(values: [CGFloat?]) -> CGFloat {
   if values.count <= TimeScaleEnum.month.rawValue {
       return 2.0
   }
   if values.count <= TimeScaleEnum.threeMonths.rawValue {
       return 1.0
   }
   if values.count <= TimeScaleEnum.sixMonths.rawValue {
       return 0.0
   }
   if values.count <= TimeScaleEnum.year.rawValue {
       return 0.0
   }
   return 0.0
}

/**
Choose the opacity of bars.
*/
func chooseOpacity(value: CGFloat, shaded: Bool, offset: CGFloat, max: CGFloat = 4, settings: SettingsStruct) -> CGFloat {
   var opacity: CGFloat = 1.0
   if shaded {
       opacity = (value + offset) / (themes[settings.theme].barShadeOffset + max)
   }
   return opacity
}
