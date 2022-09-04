//import SwiftUI
//
///**
// View for displaying dot timeline chart.
// */
//struct DotChart: View {
//    var values: [CGFloat?]
//    var color: Color
//    var blackAndWhite: Bool = false
//    var radius: CGFloat = 5
//    var settings: SettingsStruct
//    
//    private var fontColor: Color
//    private var lineColor: Color
//    private var gridColor: Color
//    
//    init(values: [CGFloat?], color: Color = .blue, blackAndWhite: Bool = false, radius: CGFloat = 5, settings: SettingsStruct) {
//        self.values = values
//        self.color = color
//        self.blackAndWhite = blackAndWhite
//        self.radius = radius
//        self.settings = settings
//        
//        fontColor = Color.secondary
//        gridColor = themes[settings.theme].gridColor
//        lineColor = color
//        
//        if blackAndWhite {
//            fontColor = Color.gray
//            lineColor = Color.black
//            gridColor = Color.gray
//        }
//    }
//    
//    var body: some View {
//        let spacing: CGFloat = chooseSpacing(values: values)
//        
//        GeometryReader { geometry in
//            let width = geometry.size.width
//            let height = geometry.size.height
//            
//            ZStack {
//                // Grid
//                Path { path in
//                    // Horizontal gridlines
//                    path.move(to: CGPoint(x: 0, y: 0))
//                    path.addLine(to: CGPoint(x: Int(width), y: 0))
//                    path.closeSubpath()
//                }.stroke(self.gridColor, lineWidth: 1)
//                
//                // Graph
//                ForEach(0 ..< values.count, id: \.self) { i in
//                    Path { path in
//                        if values[i] != nil {
//                            let barWidth: CGFloat = (CGFloat(width) - spacing * (CGFloat(values.count) + 1.0)) / CGFloat(values.count)
//                            if values[i] != 0 {
//                                let xPos: CGFloat = spacing + CGFloat(i) * (barWidth + spacing)
//                                let rect = CGRect(origin: CGPoint(x: xPos,
//                                                                  y: barWidth/2),
//                                                  size: CGSize(width: barWidth, height: -barWidth))
//                                path.addEllipse(in: rect)
//                            }
//                        }
//                    }.fill(lineColor)
//                }
//            }
//        }.frame(height: 60)
//    }
//}
//
///**
