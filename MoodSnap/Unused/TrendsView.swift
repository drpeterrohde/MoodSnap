//import SwiftUI
//
///**
// View of 7 day trend.
// */
//struct TrendsView: View {
//    @EnvironmentObject var data: DataStoreClass
//
//    var body: some View {
//        let elevationTrend: (String, Image)? = getTrend(averages: data.processedData.averageE)
//        let depressionTrend: (String, Image)? = getTrend(averages: data.processedData.averageD)
//        let anxietyTrend: (String, Image)? = getTrend(averages: data.processedData.averageA)
//        let irritabilityTrend: (String, Image)? = getTrend(averages: data.processedData.averageI)
//        let color = moodUIColors(settings: data.settings)
//
//        HStack {
//            if elevationTrend != nil && depressionTrend != nil && anxietyTrend != nil && irritabilityTrend != nil {
//                VStack(alignment: .center) {
//                    elevationTrend!.1
//                        .font(.subheadline.bold())
//                        .foregroundColor(Color(color[0]))
//                    Text(elevationTrend!.0)
//                        .font(.subheadline.bold())
//                        .foregroundColor(Color(color[0]))
//                }
//                VStack(alignment: .center) {
//                    depressionTrend!.1
//                        .font(.subheadline.bold())
//                        .foregroundColor(Color(color[1]))
//                    Text(depressionTrend!.0)
//                        .font(.subheadline.bold())
//                        .foregroundColor(Color(color[1]))
//                }
//                VStack(alignment: .center) {
//                    anxietyTrend!.1
//                        .font(.subheadline.bold())
//                        .foregroundColor(Color(color[2]))
//                    Text(anxietyTrend!.0)
//                        .font(.subheadline.bold())
//                        .foregroundColor(Color(color[2]))
//                }
//                VStack(alignment: .center) {
//                    irritabilityTrend!.1
//                        .font(.subheadline.bold())
//                        .foregroundColor(Color(color[3]))
//                    Text(irritabilityTrend!.0)
//                        .font(.subheadline.bold())
//                        .foregroundColor(Color(color[3]))
//                }
//            } else {
//                EmptyView()
//            }
//        }
//    }
//}
//
///**
// Get the trend for moving `averages`.
// */
//func getTrend(averages: [CGFloat?]) -> (String, Image)? {
//    let last = averages.count - 1
//
//    if last < 7 {
//        return nil
//    }
//
//    if averages[last] != nil && averages[last-7] != nil {
//        let diff = averages[last]! - averages[last-7]!
//        let diffString = formatMoodLevelString(value: diff)
//        if diff >= 0.1 {
//            return (diffString, Image(systemName: "arrow.up"))
//        }
//        if diff <= -0.1 {
//            return (diffString, Image(systemName: "arrow.down"))
//        }
//        return (diffString, Image(systemName: "minus"))
//    }
//
//    return nil
//}
//
