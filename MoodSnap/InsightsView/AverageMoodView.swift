import SwiftUI

/**
 View showing average mood over `timescale`.
 */
struct AverageMoodView: View {
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool = false

    var body: some View {
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

            let averageMoodSnap = averageMoodSnap(
                timescale: timescale,
                data: data)

            if averageMoodSnap != nil {
                MoodLevelsView(moodSnap: averageMoodSnap!,
                               data: data,
                               blackAndWhite: blackAndWhite)
            } else {
                VStack(alignment: .center) {
                    Text("insufficient_data")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            //Divider()
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
                MoodLevelsView(moodSnap: averageVolatilityMoodSnap!,
                               data: data,
                               blackAndWhite: blackAndWhite)
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
