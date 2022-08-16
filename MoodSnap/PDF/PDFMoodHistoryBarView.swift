import SwiftUI

struct PDFMoodHistoryBarView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    var blackAndWhite: Bool
    
    var body: some View {
        let entries = [Array(data.processedData.levelE.suffix(timescale)),
                       Array(data.processedData.levelD.suffix(timescale)),
                       Array(data.processedData.levelA.suffix(timescale)),
                       Array(data.processedData.levelI.suffix(timescale))]
        
        let color = moodUIColors(settings: data.settings)
        
        if data.moodSnaps.count == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            if !blackAndWhite {
                VStack {
                    VerticalBarChart(values: entries[0],
                                     color: Color(color[0]),
                                     min: 0,
                                     max: 4,
                                     horizontalGridLines: 0,
                                     verticalGridLines: 0,
                                     blackAndWhite: false,
                                     shaded: true,
                                     settings: data.settings)
                    .frame(height: 65)
                    Text("elevation")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding([.top, .bottom], -15)
                    VerticalBarChart(values: entries[1],
                                     color: Color(color[1]),
                                     min: 0,
                                     max: 4,
                                     horizontalGridLines: 0,
                                     verticalGridLines: 0,
                                     blackAndWhite: false,
                                     shaded: true,
                                     settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                    Text("depression")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding([.top, .bottom], -15)
                    VerticalBarChart(values: entries[2],
                                     color: Color(color[2]),
                                     min: 0,
                                     max: 4,
                                     horizontalGridLines: 0,
                                     verticalGridLines: 0,
                                     blackAndWhite: false,
                                     shaded: true,
                                     settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                    Text("anxiety")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding([.top, .bottom], -15)
                    VerticalBarChart(values: entries[3],
                                     color: Color(color[3]),
                                     min: 0,
                                     max: 4,
                                     horizontalGridLines: 0,
                                     verticalGridLines: 0,
                                     blackAndWhite: false,
                                     shaded: true,
                                     settings: data.settings)
                    .frame(height: 65)
                    .padding(.top, -10)
                    Text("irritability")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding(.top, -15)
                }
            } else {
                VerticalBarChart(values: entries[0],
                                 color: Color.black,
                                 min: 0,
                                 max: 4,
                                 horizontalGridLines: 0,
                                 verticalGridLines: 0,
                                 blackAndWhite: true,
                                 shaded: true,
                                 settings: data.settings)
                .frame(height: 65)
                Text("elevation")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChart(values: entries[1],
                                 color: Color.black,
                                 min: 0,
                                 max: 4,
                                 horizontalGridLines: 0,
                                 verticalGridLines: 0,
                                 blackAndWhite: true,
                                 shaded: true,
                                 settings: data.settings)
                .frame(height: 65)
                .padding(.top, -10)
                Text("depression")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChart(values: entries[2],
                                 color: Color.black,
                                 min: 0,
                                 max: 4,
                                 horizontalGridLines: 0,
                                 verticalGridLines: 0,
                                 blackAndWhite: true,
                                 shaded: true,
                                 settings: data.settings)
                .frame(height: 65)
                .padding(.top, -10)
                Text("anxiety")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding([.top, .bottom], -15)
                VerticalBarChart(values: entries[3],
                                 color: Color.black,
                                 min: 0,
                                 max: 4,
                                 horizontalGridLines: 0,
                                 verticalGridLines: 0,
                                 blackAndWhite: true,
                                 shaded: true,
                                 settings: data.settings)
                .frame(height: 65)
                .padding(.top, -10)
                Text("irritability")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .padding(.top, -15)
            }
        }
    }
}
