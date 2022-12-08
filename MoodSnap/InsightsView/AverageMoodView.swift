import SwiftUI

/**
 View showing average mood over `timescale`.
 */
struct AverageMoodView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    var blackAndWhite: Bool = false

    var body: some View {
        let averageMoodSnapFlat = averageMoodSnap(
            timescale: timescale,
            data: data,
            flatten: true)
        let averageMoodSnapAll = averageMoodSnap(
            timescale: timescale,
            data: data,
            flatten: false)
        
        if data.moodSnaps.count == 0 {
            Spacer()
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            if blackAndWhite {
                Label("mood_levels", systemImage: "brain.head.profile")
                    .font(.caption)
                    .foregroundColor(.black)
            } else {
                Label("mood_levels", systemImage: "brain.head.profile")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            if averageMoodSnapFlat != nil && averageMoodSnapAll != nil {
                MoodLevelsView(moodSnapFlat: averageMoodSnapFlat!,
                               moodSnapAll: averageMoodSnapAll!,
                               theme: themes[data.settings.theme],
                               blackAndWhite: blackAndWhite,
                               double: true)
            } else {
                VStack(alignment: .center) {
                    Text("insufficient_data")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            if blackAndWhite {
                Label("volatility", systemImage: "waveform.path.ecg")
                    .font(.caption)
                    .foregroundColor(.black)
            } else {
                Label("volatility", systemImage: "waveform.path.ecg")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            let averageVolatilityMoodSnap = averageVolatilityMoodSnap(
                timescale: timescale,
                data: data)
            if averageVolatilityMoodSnap != nil {
                MoodLevelsView(moodSnapFlat: averageVolatilityMoodSnap!,
                               moodSnapAll: averageVolatilityMoodSnap!,
                               theme: themes[data.settings.theme],
                               blackAndWhite: blackAndWhite,
                               double: false)
            } else {
                VStack(alignment: .center) {
                    Spacer()
                    Text("insufficient_data")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
