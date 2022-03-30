import SwiftUI

struct AverageMoodView: View {
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool = false

    var body: some View {
        if data.moodSnaps.count == 0 {
            Spacer()
            Text("Insufficient data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            if blackAndWhite {
                Label("Mood levels", systemImage: "brain.head.profile")
                    .font(.caption)
                    .foregroundColor(.black)
            } else {
                Label("Mood levels", systemImage: "brain.head.profile")
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
                    Text("Insufficient data")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Divider()
            if blackAndWhite {
                Label("Volatility", systemImage: "waveform.path.ecg")
                    .font(.caption)
                    .foregroundColor(.black)
            } else {
                Label("Volatility", systemImage: "waveform.path.ecg")
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
                    Text("Insufficient data")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
