import SwiftUI
import Charts

struct StatsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var data: DataStoreStruct
    @State var timescale: TimeScaleEnum = TimeScaleEnum.month
    
    var body: some View {
        NavigationView {
        VStack {
            Picker("", selection: $timescale) {
                Text("1mo").tag(TimeScaleEnum.month)
                Text("3mo").tag(TimeScaleEnum.threeMonths)
                Text("6mo").tag(TimeScaleEnum.sixMonths)
                Text("1yr").tag(TimeScaleEnum.year)
            }.pickerStyle(SegmentedPickerStyle())
        ScrollView(.vertical) {
            VStack{
                GroupBox(label: Label("Average mood", systemImage: "brain.head.profile")) {
                    Divider()
//                    let averageMoodSnap = averageMoodSnap(timescale: timescale, data: data)
//                    if (averageMoodSnap != nil) {
//                        MoodLevelsView(moodSnap: averageMoodSnap!, data: data)
//                    } else {
//                        VStack(alignment: .center) {
//                        Text("Insufficient data")
//                        }
//                    }
                    AverageMoodView(timescale: timescale, data: data)
                }
                
                GroupBox(label: Label("Mood history", systemImage: "chart.bar.xaxis")) {
                    Divider()
                    MoodHistoryBarView(timescale: timescale, data: data)
                }
                
                GroupBox(label: Label("Moving average", systemImage: "chart.line.uptrend.xyaxis")) {
                    Divider()
                    SlidingAverageView(timescale: timescale, data: data)
                }
                
                GroupBox(label: Label("Volatility", systemImage: "waveform.path.ecg")) {
                    Divider()
                    SlidingVolatilityView(timescale: timescale, data: data)
                }
                
                GroupBox(label: Label("Influences", systemImage: "eye.circle")) {
                    Divider()
                    InfluencesView(data: data)
                }
                
                GroupBox(label: Label("Butterfly average", systemImage: "waveform.path.ecg.rectangle")) {
                    Divider()
                    ButterflyAverageView(timescale: timescale, data: data)
                }
            }
        }
        }.navigationBarTitle(Text("Statistics"))
        }
    }
}
