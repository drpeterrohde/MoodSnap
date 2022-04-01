import SwiftUI

/**
 View showing mood levels for `moodSnap`.
 */
struct MoodLevelsView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct
    let blackAndWhite: Bool
    
    private var fontColor: Color
    private var elevationColor: Color
    private var depressionColor: Color
    private var anxietyColor: Color
    private var irritabilityColor: Color
    private var gridColor: Color
    
    init(moodSnap: MoodSnapStruct, data: DataStoreStruct, blackAndWhite: Bool = false) {
        self.moodSnap = moodSnap
        self.data = data
        self.blackAndWhite = blackAndWhite
        
        self.fontColor = Color.secondary
        self.elevationColor = themes[data.settings.theme].elevationColor
        self.depressionColor = themes[data.settings.theme].depressionColor
        self.anxietyColor = themes[data.settings.theme].anxietyColor
        self.irritabilityColor = themes[data.settings.theme].irritabilityColor
        self.gridColor = themes[data.settings.theme].gridColor
        
        if (blackAndWhite) {
            self.fontColor = Color.black
            self.elevationColor = Color.black
            self.depressionColor = Color.black
            self.anxietyColor = Color.black
            self.irritabilityColor = Color.black
            self.gridColor = Color.gray
        }
    }
    
    var body: some View {
        GeometryReader{geometry in
            let hBarStep: CGFloat = (geometry.size.width-35)/4
            
            ZStack{
                // Grid
                Path { path in
                    let offsetX: CGFloat = 20.0
                    let offsetY: CGFloat = 8.5
                    let stepY: CGFloat = 14.7
                    
                    // Vertical gridlines
                    for i in 0...4 {
                        path.move(to: CGPoint(x: Int(offsetX+CGFloat(i)*hBarStep), y: Int(offsetY)))
                        path.addLine(to: CGPoint(x: Int(offsetX+CGFloat(i)*hBarStep), y: Int(offsetY+3*stepY)))
                    }
                    
                    // Horizontal gridlines
                    for i in 0...3 {
                        path.move(to: CGPoint(x: Int(offsetX), y: Int(offsetY+CGFloat(i)*stepY)))
                        path.addLine(to: CGPoint(x: Int(offsetX+4*hBarStep), y: Int(offsetY+CGFloat(i)*stepY)))
                    }
                    
                    path.closeSubpath()
                }.stroke(self.gridColor, lineWidth: 1)
                
                // Graph
                VStack(alignment: .leading, spacing: 0) {
                    HStack{
                        Text("E").font(Font.system(size: themes[data.settings.theme].hBarFontSize, design: .monospaced)).foregroundColor(self.fontColor)
                        RoundedRectangle(cornerRadius: themes[data.settings.theme].hBarRadius, style:.continuous).foregroundColor(self.elevationColor).frame(width: (moodSnap.elevation * hBarStep + themes[data.settings.theme].hBarHeight), height: themes[data.settings.theme].hBarHeight)
                        Spacer()
                    }
                    HStack{
                        Text("D").font(Font.system(size: themes[data.settings.theme].hBarFontSize, design: .monospaced)).foregroundColor(self.fontColor)
                        RoundedRectangle(cornerRadius: themes[data.settings.theme].hBarRadius, style: .continuous).foregroundColor(self.depressionColor).frame(width: (moodSnap.depression * hBarStep + themes[data.settings.theme].hBarHeight), height: themes[data.settings.theme].hBarHeight)
                        Spacer()
                    }
                    HStack{
                        Text("A").font(Font.system(size: themes[data.settings.theme].hBarFontSize, design: .monospaced)).foregroundColor(self.fontColor)
                        RoundedRectangle(cornerRadius: themes[data.settings.theme].hBarRadius, style: .continuous).foregroundColor(self.anxietyColor).frame(width: (moodSnap.anxiety * hBarStep + themes[data.settings.theme].hBarHeight), height: themes[data.settings.theme].hBarHeight)
                        Spacer()
                    }
                    HStack{
                        Text("I").font(Font.system(size: themes[data.settings.theme].hBarFontSize, design: .monospaced)).foregroundColor(self.fontColor)
                        RoundedRectangle(cornerRadius: themes[data.settings.theme].hBarRadius, style: .continuous).foregroundColor(self.irritabilityColor).frame(width: (moodSnap.irritability * hBarStep + themes[data.settings.theme].hBarHeight), height: themes[data.settings.theme].hBarHeight)
                    }
                }
            }
        }.frame(height: 60)
    }
}
