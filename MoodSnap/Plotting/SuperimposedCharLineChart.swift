import HealthKit
import SwiftUI

/**
 View for displaying vertical bar chart.
 */
struct SuperimposedCharLineChart: View {
    var barData: [CGFloat?]
    var lineData: [[CGFloat?]]
    var barColor: Color
    var lineColor: [Color]
    var min: CGFloat
    var max: CGFloat
    var horizontalGridLines: Int = 0
    var verticalGridLines: Int = 0
    var blackAndWhite: Bool = false
    var shaded: Bool = false
    var settings: SettingsStruct

    private var fontColor: Color
    // private var lineColor: Color
    private var gridColor: Color

    init(barData: [CGFloat?], lineData: [[CGFloat?]], barColor: Color = .blue, lineColor: [Color], min: CGFloat = 0.0, max: CGFloat = 4.0, horizontalGridLines: Int = 0, verticalGridLines: Int = 0, blackAndWhite: Bool = false, shaded: Bool = false, settings: SettingsStruct) {
        self.barData = barData
        self.lineData = lineData
        self.barColor = barColor
        self.lineColor = lineColor
        self.min = min
        self.max = max
        self.horizontalGridLines = horizontalGridLines
        self.verticalGridLines = verticalGridLines
        self.blackAndWhite = blackAndWhite
        self.shaded = shaded
        self.settings = settings

        fontColor = Color.secondary
        gridColor = Color.gray.opacity(0.4) // clean up???

        if blackAndWhite {
            fontColor = Color.gray
            self.barColor = Color.black
            self.lineColor = [Color.black, Color.black, Color.black, Color.black]
            gridColor = Color.gray
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let spacing: CGFloat = chooseSpacing(values: barData)
            let barWidth: CGFloat = [CGFloat(width) / CGFloat(barData.count) - spacing, 1.0].max()!

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

                // Bar chart
                ForEach(0 ..< barData.count, id: \.self) { i in
                    let thisData = barData[i] ?? 0
                    let opacity = chooseMenstrualOpacity(value: thisData, shaded: true, settings: settings)
                    let thisColor = self.barColor.opacity(opacity)
                    Path { path in
                        if barData[i] != nil {
                            var barHeight: CGFloat
                            if barData[i]! == 0 {
                                barHeight = 0
                            } else {
                                barHeight = CGFloat(height)
                            }
                            let xPos: CGFloat = spacing + CGFloat(i) * (barWidth + spacing)
                            let rect = CGRect(origin: CGPoint(x: xPos,
                                                              y: CGFloat(height)),
                                              size: CGSize(width: barWidth, height: -barHeight))
                            path.addRect(rect)
                        }
                    }.fill(thisColor)
                }

                // Line chart
                ForEach(0 ..< lineData.count, id: \.self) { graph in
                    // Lines
                    Path { path in
                        let thisData = lineData[graph]
                        var first: Bool = true
                        for i in 0 ..< thisData.count {
                            let xPos: CGFloat = CGFloat(i) * (CGFloat(geometry.size.width) / CGFloat(thisData.count - 1)) - (barWidth / 2) + 2
                            var yPos: CGFloat?
                            if thisData[i] != nil {
                                yPos = CGFloat(geometry.size.height) - (thisData[i]! - min) * CGFloat(geometry.size.height) / (max - min)
                                if first {
                                    path.move(to: CGPoint(x: xPos, y: yPos!))
                                    first = false
                                } else {
                                    path.addLine(to: CGPoint(x: xPos, y: yPos!))
                                }
                            }
                        }
                    }.stroke(self.lineColor[graph].opacity(0.25), lineWidth: 2)

                    // Circles
                    let thisData = lineData[graph]
                    ForEach(0 ..< thisData.count, id: \.self) { i in
                        Path { path in
                            // for i in 0 ..< thisData.count {
                            let xPos: CGFloat = CGFloat(i) * (CGFloat(geometry.size.width) / CGFloat(thisData.count - 1)) - (barWidth / 2) + 2
                            var yPos: CGFloat?
                            if thisData[i] != nil {
                                yPos = CGFloat(geometry.size.height) - (thisData[i]! - min) * CGFloat(geometry.size.height) / (max - min)
                                path.addArc(center: CGPoint(x: xPos, y: yPos!), radius: 2, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
                            }
                        }.stroke(self.lineColor[graph].opacity(1.0), lineWidth: 2)
                    }
                }
            }
        }.frame(height: 60)
    }
}

func chooseMenstrualOpacity(value: CGFloat, shaded: Bool, settings: SettingsStruct) -> CGFloat {
    switch Int(value) {
    case HKCategoryValueMenstrualFlow.none.rawValue:
        return 0
    case HKCategoryValueMenstrualFlow.unspecified.rawValue:
        return 0
    case HKCategoryValueMenstrualFlow.light.rawValue:
        return 0.4
    case HKCategoryValueMenstrualFlow.medium.rawValue:
        return 0.65
    case HKCategoryValueMenstrualFlow.heavy.rawValue:
        return 1.0
    default:
        return 0
    }
}
