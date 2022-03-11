import SwiftUI
import Charts

struct MoodHistoryBarView: View {
    var timescale: TimeScaleEnum
    var data: DataStoreStruct
    
    var body: some View {
        let samples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
        
        let dataE = samples[0]
        let dataD = samples[1]
        let dataA = samples[2]
        let dataI = samples[3]
        
        let entriesE = makeBarData(y: dataE)
        let entriesD = makeBarData(y: dataD)
        let entriesA = makeBarData(y: dataA)
        let entriesI = makeBarData(y: dataI)
        
        let entries = [entriesE, entriesD, entriesA, entriesI]
        
        let color = moodUIColors(settings: data.settings)
        
                VerticalBarChart(entries: truncateEntries(data: entries[0], timescale: timescale), color: color[0], settings: data.settings)
                .frame(height: 65)
            Text("Elevation")
                .font(.caption)
                .foregroundColor(Color(color[0]))
                .padding([.top, .bottom], -15)
            VerticalBarChart(entries: truncateEntries(data: entries[1], timescale: timescale), color: color[1], settings: data.settings)
                .frame(height: 65)
                .padding(.top, -10)
            Text("Depression")
                .font(.caption)
                .foregroundColor(Color(color[1]))
                .padding([.top, .bottom], -15)
                VerticalBarChart(entries: truncateEntries(data: entries[2], timescale: timescale), color: color[2], settings: data.settings)
                .frame(height: 65)
                .padding(.top, -10)
            Text("Anxiety")
                .font(.caption)
                .foregroundColor(Color(color[2]))
                .padding([.top, .bottom], -15)
                VerticalBarChart(entries: truncateEntries(data: entries[3], timescale: timescale), color: color[3], settings: data.settings)
                .frame(height: 65)
                .padding(.top, -10)
            Text("Irritability")
                .font(.caption)
                .foregroundColor(Color(color[3]))
                .padding(.top, -15)
    }
}
