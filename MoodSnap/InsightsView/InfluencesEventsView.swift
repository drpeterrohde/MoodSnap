import SwiftUI

/**
 View for dislpaying event influences.
 */
struct InfluencesEventsView: View {
    var data: DataStoreStruct
    
    var body: some View {
        let butterflies = data.processedData.eventButterfly
        let occurrenceCount = countAllOccurrences(butterflies: butterflies)
        
        //HStack{
        if (occurrenceCount == 0) {
            Text("Insufficient data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
        Label("Mood levels", systemImage: "brain.head.profile")
                .font(.caption)
                .foregroundColor(.secondary)
        //Spacer()
        //}
        Spacer()
        HStack {
            // Activity
            VStack(alignment: .leading) {
                ForEach(butterflies, id: \.id) {butterfly in
                    let dateString: String = " (" + butterfly.timestamp.dateString() + ")"
                    Text(butterfly.activity + dateString).font(.caption)
                }
            }
            Spacer()
            // Numbers
            VStack(alignment: .trailing) {
                ForEach(butterflies, id: \.id) {butterfly in
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
        //HStack{
            Label("Volatility", systemImage: "waveform.path.ecg")
                .font(.caption)
                .foregroundColor(.secondary)
        //Spacer()
        //}
        Spacer()
        
        HStack {
            // Activity
            VStack(alignment: .leading) {
                ForEach(butterflies, id: \.id) {butterfly in
                    let dateString: String = " (" + butterfly.timestamp.dateString() + ")"
                    Text(butterfly.activity + dateString).font(.caption)
                }
            }
            Spacer()
            // Numbers
            VStack(alignment: .trailing) {
                ForEach(butterflies, id: \.id) {butterfly in
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
