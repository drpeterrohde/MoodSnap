//import SwiftUI
//import Charts
//
//struct WeightView: View {
//    var data: DataStoreStruct
//    
//    var body: some View {
//        let samplesE = getWeightMoodDistribution(type: .elevation, data: data)
//        let samplesD = getWeightMoodDistribution(type: .depression, data: data)
//        let samplesA = getWeightMoodDistribution(type: .anxiety, data: data)
//        let samplesI = getWeightMoodDistribution(type: .irritability, data: data)
//        
//        let scatterE = makeLineData(x: samplesE.0, y: samplesE.1)
//        let scatterD = makeLineData(x: samplesD.0, y: samplesD.1)
//        let scatterA = makeLineData(x: samplesA.0, y: samplesA.1)
//        let scatterI = makeLineData(x: samplesI.0, y: samplesI.1)
//
//        let color = moodUIColors(settings: data.settings)
//        
//        VStack(alignment: .center) {
//            if (samplesE.0.count == 0) {
//                Text("Insufficient data")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            } else {
//                ScatterChart(entries: scatterE, color: color[0])
//                    .frame(height: 170)
//                ScatterChart(entries: scatterD, color: color[1])
//                    .frame(height: 170)
//                ScatterChart(entries: scatterA, color: color[2])
//                    .frame(height: 170)
//                ScatterChart(entries: scatterI, color: color[3])
//                    .frame(height: 170)
//                Text("Weight")
//                .font(.caption)
//                .foregroundColor(.secondary)
//                .padding([.top], -10)
//            }
//        }
//    }
//}
//
