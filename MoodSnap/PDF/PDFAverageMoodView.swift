import SwiftUI

struct PDFAverageMoodView: View {
    var timescale: Int
    var data: DataStoreClass
    var blackAndWhite: Bool = true

    var body: some View {
        HStack {
            Group {
                VStack {
                    // if (data.moodSnaps.count == 0) {
                    // Text("Insufficient data")
                    // .font(.caption)
                    // .foregroundColor(.secondary)
                    // } else {
                    // if blackAndWhite {
                    Label("mood_levels", systemImage: "brain.head.profile")
                        .font(.caption)
                        .foregroundColor(.black)
                    // } else {
                    // Label("Mood levels", systemImage: "brain.head.profile")
                    // .font(.caption)
                    // .foregroundColor(.secondary)
                    // }

                    let averageMoodSnap = averageMoodSnap(
                        timescale: timescale,
                        data: data)

                    if averageMoodSnap != nil {
                        MoodLevelsView(moodSnap: averageMoodSnap!,
                                       blackAndWhite: blackAndWhite,
                                       dataParse: data)
                    } else {
                        VStack(alignment: .center) {
                            Text("insufficient_data")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }

            Group {
                VStack {
                    // if blackAndWhite {
                    Label("volatility", systemImage: "waveform.path.ecg")
                        .font(.caption)
                        .foregroundColor(.black)
                    // } else {
                    // Label("Volatility", systemImage: "waveform.path.ecg")
                    // .font(.caption)
                    // .foregroundColor(.secondary)

                    // }

                    let averageVolatilityMoodSnap = averageVolatilityMoodSnap(
                        timescale: timescale,
                        data: data)
                    if averageVolatilityMoodSnap != nil {
                        Divider()
                        MoodLevelsView(moodSnap: averageVolatilityMoodSnap!,
                                       blackAndWhite: blackAndWhite,
                                       dataParse: data)
                    } else {
                        VStack(alignment: .center) {
                            Text("insufficient_data")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}
