//import SwiftUI
//
///**
// View of 7 day trend.
// */
//struct TrendsView: View {
//    @EnvironmentObject var data: DataStoreClass
//
//    var body: some View {
//        let elevationTrend: Image? = getTrend(averages: data.processedData.averageE)
//        let depressionTrend: Image? = getTrend(averages: data.processedData.averageD)
//        let anxietyTrend: Image? = getTrend(averages: data.processedData.averageA)
//        let irritabilityTrend: Image? = getTrend(averages: data.processedData.averageI)
//        let color = moodUIColors(settings: data.settings)
//
//        HStack {
//            if elevationTrend != nil && depressionTrend != nil && anxietyTrend != nil && irritabilityTrend != nil {
//                elevationTrend
//                    .font(.subheadline.bold())
//                    .foregroundColor(Color(color[0]))
//                depressionTrend
//                    .font(.subheadline.bold())
//                    .foregroundColor(Color(color[1]))
//                anxietyTrend
//                    .font(.subheadline.bold())
//                    .foregroundColor(Color(color[2]))
//                irritabilityTrend
//                    .font(.subheadline.bold())
//                    .foregroundColor(Color(color[3]))
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
//func getTrend(averages: [CGFloat?]) -> Image? {
//    var diff: CGFloat = 0
//    let last = averages.count - 1
//
//    if last < 7 {
//        return nil
//    }
//    
//    if averages[last] != nil && averages[last-7] != nil {
//        diff = averages[last]! - averages[last-7]!
//        if diff >= 0.1 {
//            return Image(systemName: "arrow.up")
//        }
//        if diff <= -0.1 {
//            return Image(systemName: "arrow.down")
//        }
//        return Image(systemName: "minus")
//    }
//    
//    return nil
//}
//
