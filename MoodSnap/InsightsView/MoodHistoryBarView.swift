import SwiftUI

/**
 View for displaying mood history over given `timescale`.
 */
struct MoodHistoryBarView: View {
    var timescale: Int
    var isExpandable: Bool = false
    @State var isExpanded: Bool = false
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {
        let entriesE = makeChartData(y: data.processedData.levelE, timescale: timescale)
        let entriesD = makeChartData(y: data.processedData.levelD, timescale: timescale)
        let entriesA = makeChartData(y: data.processedData.levelA, timescale: timescale)
        let entriesI = makeChartData(y: data.processedData.levelI, timescale: timescale)
        let color = moodUIColors(settings: data.settings)
        
        if data.moodSnaps.count == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            VStack {
                Group {
                    VerticalBarChart(values: entriesE,
                                     color: Color(color[0]),
                                     horizontalGridLines: 3,
                                     shaded: true,
                                     settings: data.settings)
                    //  .frame(height: 60)
                    Text("elevation")
                        .font(.caption)
                        .foregroundColor(Color(color[0]))
                }
                
                Group {
                    VerticalBarChart(values: entriesD,
                                     color: Color(color[1]),
                                     horizontalGridLines: 3,
                                     shaded: true,
                                     settings: data.settings)
                    //  .frame(height: 60)
                    Text("depression")
                        .font(.caption)
                        .foregroundColor(Color(color[1]))
                }
                
                Group {
                    VerticalBarChart(values: entriesA,
                                     color: Color(color[2]),
                                     horizontalGridLines: 3,
                                     shaded: true,
                                     settings: data.settings)
                    //  .frame(height: 60)
                    Text("anxiety")
                        .font(.caption)
                        .foregroundColor(Color(color[2]))
                }
                
                Group {
                    VerticalBarChart(values: entriesI,
                                     color: Color(color[3]),
                                     horizontalGridLines: 3,
                                     shaded: true,
                                     settings: data.settings)
                    // .frame(height: 60)
                    Text("irritability")
                        .font(.caption)
                        .foregroundColor(Color(color[3]))
                }
                
                if isExpandable {
                    Group {
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut) {
                                isExpanded.toggle()
                            }
                        }) {
                            if isExpanded {
                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                            } else {
                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                            }
                        }
                    }
                    if isExpanded {
                        VStack(alignment: .center) {
                            Spacer()
                            Label("Correlations", systemImage: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            MoodCorrelationsView()
                        }
                    }
                }
            }
        }
    }
}
