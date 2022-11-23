import SwiftUI

/**
 View for dislpaying event influences.
 */
struct InfluencesEventsView: View {
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {
        if data.eventOccurrenceCount == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            Label("mood_levels", systemImage: "brain.head.profile")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            HStack {
                // Activity
                VStack(alignment: .leading) {
                    ForEach(data.processedData.eventButterfly, id: \.id) {butterfly in
                        //let dateString: String = " (" + butterfly.timestamp.dateString() + ")"
                        Text(butterfly.activity) //+ dateString)
                            .font(.caption)
                    }
                }
                Spacer()
                // Numbers
                VStack(alignment: .trailing) {
                    ForEach(data.processedData.eventButterfly, id: \.id) {butterfly in
                        HStack {
                            Text(formatMoodLevelString(value: butterfly.influence()[0]))
                                .font(numericFont)
                                .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: butterfly.influence()[1]))
                                .font(numericFont)
                                .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: butterfly.influence()[2]))
                                .font(numericFont)
                                .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: butterfly.influence()[3]))
                                .font(numericFont)
                                .foregroundColor(themes[data.settings.theme].irritabilityColor)
                        }.frame(width: 150)
                    }
                }
            }
            
            Divider()
            Label("volatility", systemImage: "waveform.path.ecg")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            
            HStack {
                // Activity
                VStack(alignment: .leading) {
                    ForEach(data.processedData.eventButterfly, id: \.id) {butterfly in
                        //let dateString: String = " (" + butterfly.timestamp.dateString() + ")"
                        Text(butterfly.activity) //+ dateString)
                            .font(.caption)
                    }
                }
                Spacer()
                // Numbers
                VStack(alignment: .trailing) {
                    ForEach(data.processedData.eventButterfly, id: \.id) {butterfly in
                        HStack {
                            Text(formatMoodLevelString(value: butterfly.influence()[4]))
                                .font(numericFont)
                                .foregroundColor(themes[data.settings.theme].elevationColor) + Text(formatMoodLevelString(value: butterfly.influence()[5]))
                                .font(numericFont)
                                .foregroundColor(themes[data.settings.theme].depressionColor) + Text(formatMoodLevelString(value: butterfly.influence()[6]))
                                .font(numericFont)
                                .foregroundColor(themes[data.settings.theme].anxietyColor) + Text(formatMoodLevelString(value: butterfly.influence()[7]))
                                .font(numericFont)
                                .foregroundColor(themes[data.settings.theme].irritabilityColor)
                        }.frame(width: 150)
                    }
                }
            }
        }
    }
}
