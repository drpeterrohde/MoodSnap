import SwiftUI
import Charts

struct PDFMoodHistoryBarView: View {
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool
    
    var body: some View {
        let entriesE = makeBarData(y: data.processedData.levelE, timescale: timescale)
        let entriesD = makeBarData(y: data.processedData.levelD, timescale: timescale)
        let entriesA = makeBarData(y: data.processedData.levelA, timescale: timescale)
        let entriesI = makeBarData(y: data.processedData.levelI, timescale: timescale)
        
        let entries = [entriesE, entriesD, entriesA, entriesI]
        let color = moodUIColors(settings: data.settings)
        
        if (data.moodSnaps.count == 0) {
            Text("Insufficient data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            if !blackAndWhite {
            VStack {
                VerticalBarChart(entries: entries[0], color: color[0], settings: data.settings)
                    .frame(height: 65)
                Text("Elevation")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChart(entries: entries[1], color: color[1], settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                Text("Depression")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChart(entries: entries[2], color: color[2], settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                Text("Anxiety")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChart(entries: entries[3], color: color[3], settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                Text("Irritability")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding(.top, -15)
            }
            } else {
                VerticalBarChart(entries: entries[0], color: UIColor.black, settings: data.settings)
                    .frame(height: 65)
                Text("Elevation")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChart(entries: entries[1], color: UIColor.black, settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                Text("Depression")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChart(entries: entries[2], color: UIColor.black, settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                Text("Anxiety")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChart(entries: entries[3], color: UIColor.black, settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                Text("Irritability")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding(.top, -15)
            }
        }
    }
}
