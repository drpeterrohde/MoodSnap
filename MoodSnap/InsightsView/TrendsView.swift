import SwiftUI

/**
 View of 7 day trend.
 */
struct TrendsView: View {
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {
        let color = moodUIColors(settings: data.settings)
        
        HStack {
            Text(data.processedData.elevationTrend ?? "-")
                .font(.subheadline.bold())
                .foregroundColor(Color(color[0]))
            Text(data.processedData.depressionTrend ?? "-")
                .font(.subheadline.bold())
                .foregroundColor(Color(color[1]))
            Text(data.processedData.anxietyTrend ?? "-")
                .font(.subheadline.bold())
                .foregroundColor(Color(color[2]))
            Text(data.processedData.irritabilityTrend ?? "-")
                .font(.subheadline.bold())
                .foregroundColor(Color(color[3]))
        }
    }
}

