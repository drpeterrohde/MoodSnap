import SwiftUI

struct InfluencesView: View {
    var data: DataStoreStruct
    
    var body: some View {
        let entries = blankInfluencesList()
        
        Label("Mood levels", systemImage: "brain.head.profile").font(.caption)
        Spacer()
        HStack{
            // Activity
            VStack(alignment: .leading) {
                ForEach(entries) {entry in
                    Text(entry.activity).font(.subheadline)
                }
            }
            // Elevation
            VStack(alignment: .trailing) {
                ForEach(entries) {entry in
                        Text(formatMoodLevelString(activity: entry, which: .elevation))
                            .font(.subheadline)
                            .foregroundColor(themes[data.settings.theme].elevationColor)
                }
            }
            // Depression
            VStack(alignment: .trailing) {
                ForEach(entries) {entry in
                    Text(formatMoodLevelString(activity: entry, which: .depression))
                            .font(.subheadline)
                            .foregroundColor(themes[data.settings.theme].depressionColor)
                }
            }
            // Anxiety
            VStack(alignment: .trailing) {
                ForEach(entries) {entry in
                    Text(formatMoodLevelString(activity: entry, which: .anxiety))
                            .font(.subheadline)
                            .foregroundColor(themes[data.settings.theme].anxietyColor)
                }
            }
            // Irritability
            VStack(alignment: .trailing) {
                ForEach(entries) {entry in
                    Text(formatMoodLevelString(activity: entry, which: .irritability))
                            .font(.subheadline)
                            .foregroundColor(themes[data.settings.theme].irritabilityColor)
                }
            }
        }
        
        Divider()
        Label("Mood volatility", systemImage: "waveform.path.ecg").font(.caption)
        Spacer()
        
            HStack{
                // Activity
                VStack(alignment: .leading) {
                    ForEach(entries) {entry in
                        Text(entry.activity).font(.subheadline)
                    }
                }
                // Elevation
                VStack(alignment: .trailing) {
                    ForEach(entries) {entry in
                        Text(formatMoodLevelString(activity: entry, which: .elevationVolatility))
                                .font(.subheadline)
                                .foregroundColor(themes[data.settings.theme].elevationColor)
                    }
                }
                // Depression
                VStack(alignment: .trailing) {
                    ForEach(entries) {entry in
                        Text(formatMoodLevelString(activity: entry, which: .depressionVolatility))
                                .font(.subheadline)
                                .foregroundColor(themes[data.settings.theme].depressionColor)
                    }
                }
                // Anxiety
                VStack(alignment: .trailing) {
                    ForEach(entries) {entry in
                        Text(formatMoodLevelString(activity: entry, which: .anxietyVolatility))
                                .font(.subheadline)
                                .foregroundColor(themes[data.settings.theme].anxietyColor)
                    }
                }
                // Irritability
                VStack(alignment: .trailing) {
                    ForEach(entries) {entry in
                        Text(formatMoodLevelString(activity: entry, which: .irritabilityVolatility))
                                .font(.subheadline)
                                .foregroundColor(themes[data.settings.theme].irritabilityColor)
                    }
                }
        }
    }
}
