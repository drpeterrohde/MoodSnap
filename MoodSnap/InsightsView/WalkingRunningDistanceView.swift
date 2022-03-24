//import SwiftUI
//import Charts
//
//struct WalkingRunningDistanceView: View {
//    var data: DataStoreStruct
//    
//    var body: some View {
//        let samplesE = getWalkingRunningMoodDistribution(type: .elevation, data: data)
//        let samplesD = getWalkingRunningMoodDistribution(type: .depression, data: data)
//        let samplesA = getWalkingRunningMoodDistribution(type: .anxiety, data: data)
//        let samplesI = getWalkingRunningMoodDistribution(type: .irritability, data: data)
//        
//        let scatterE = makeLineData(x: samplesE.0, y: samplesE.1)
//        let scatterD = makeLineData(x: samplesD.0, y: samplesD.1)
//        let scatterA = makeLineData(x: samplesA.0, y: samplesA.1)
//        let scatterI = makeLineData(x: samplesI.0, y: samplesI.1)
//        
//        let color = moodUIColors(settings: data.settings)
//        
//        VStack(alignment: .center) {
//                if (samplesE.0.count == 0) {
//                    Text("Insufficient data")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                } else {
//        ScatterChart(entries: scatterE, color: color[0], zeroOrigin: true)
//            .frame(height: 170)
//        ScatterChart(entries: scatterD, color: color[1], zeroOrigin: true)
//            .frame(height: 170)
//        ScatterChart(entries: scatterA, color: color[2], zeroOrigin: true)
//            .frame(height: 170)
//        ScatterChart(entries: scatterI, color: color[3], zeroOrigin: true)
//            .frame(height: 170)
//            Text("Walking & running distance")
//                .font(.caption)
//                .foregroundColor(.secondary)
//                .padding([.top], -10)
//        }
//    }
//}
//    }
