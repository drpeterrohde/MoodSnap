import SwiftUI

/**
 View of 7 day trend.
 */
struct TrendsView: View {
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {
        let elevationTrend: String = getTrend(averages: data.processedData.averageE)
        let depressionTrend: String = getTrend(averages: data.processedData.averageD)
        let anxietyTrend: String = getTrend(averages: data.processedData.averageA)
        let irritabilityTrend: String = getTrend(averages: data.processedData.averageI)
        let color = moodUIColors(settings: data.settings)
        
        HStack {
            Text(elevationTrend)
                .font(.subheadline.bold())
                .foregroundColor(Color(color[0]))
            Text(depressionTrend)
                .font(.subheadline.bold())
                .foregroundColor(Color(color[1]))
            Text(anxietyTrend)
                .font(.subheadline.bold())
                .foregroundColor(Color(color[2]))
            Text(irritabilityTrend)
                .font(.subheadline.bold())
                .foregroundColor(Color(color[3]))
        }
    }
}

/**
 Get the trend for moving `averages`.
 */
func getTrend(averages: [CGFloat?]) -> String {
    let last = averages.count - 1
    
    if last < 7 {
        return "-"
    }
    
    if averages[last] != nil && averages[last-7] != nil {
        let diff = averages[last]! - averages[last-7]!
        let diffString = formatMoodLevelString(value: diff)
        return diffString
    }
    
    return "-"
}

