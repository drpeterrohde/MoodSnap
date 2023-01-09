import SwiftUI

/**
 View for dislpaying hashtag influences.
 */
struct InfluencesHashtagView: View {
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {        
        if data.hashtagOccurrenceCount == 0 {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            Label("mood_levels", systemImage: "number")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            HStack{
                // Activity
                VStack(alignment: .leading) {
                    ForEach(data.processedData.hashtagButterfly, id: \.id) {butterfly in
                        if hasData(data: butterfly.influence()) {
                            Text(butterfly.activity)
                                .font(.caption)
                        }
                    }
                }
                // Occurrences
                VStack(alignment: .leading) {
                    ForEach(data.processedData.hashtagButterfly, id: \.id) {butterfly in
                        if hasData(data: butterfly.influence())  {
                            Text("(\(butterfly.occurrences))")
                                .font(.caption)
                        }
                    }
                }
                Spacer()
                // Numbers
                VStack(alignment: .trailing) {
                    ForEach(data.processedData.hashtagButterfly, id: \.id) {butterfly in
                        if hasData(data: butterfly.influence())  {
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
            }
            
            Divider()
            Label("volatility", systemImage: "waveform.path.ecg")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            
            HStack {
                // Activity
                VStack(alignment: .leading) {
                    ForEach(data.processedData.hashtagButterfly, id: \.id) {butterfly in
                        if hasData(data: butterfly.influence()) {
                            Text(butterfly.activity)
                                .font(.caption)
                        }
                    }
                }
                // Occurrences
                VStack(alignment: .leading) {
                    ForEach(data.processedData.hashtagButterfly, id: \.id) {butterfly in
                        if hasData(data: butterfly.influence()) {
                            Text("(\(butterfly.occurrences))")
                                .font(.caption)
                        }
                    }
                }
                Spacer()
                // Numbers
                VStack(alignment: .trailing) {
                    ForEach(data.processedData.hashtagButterfly, id: \.id) {butterfly in
                        if hasData(data: butterfly.influence()) {
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
}
