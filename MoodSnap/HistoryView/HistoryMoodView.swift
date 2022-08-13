import SwiftUI

/**
 View showing a history `moodSnap` entry.
 */
struct HistoryMoodView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreClass

    var body: some View {
        Divider()
        MoodLevelsView(moodSnap: moodSnap, data: data)

        Group {
            if totalSymptoms(moodSnap: moodSnap, settings: data.settings) != 0 {
                Divider()
                Label("symptoms", systemImage: "heart.text.square")
                    .font(.caption)
                    .foregroundColor(.secondary)
                HistorySymptomsView(moodSnap: moodSnap, data: data)
            }
        }

        Group {
            if totalActivities(moodSnap: moodSnap, settings: data.settings) != 0 {
                Divider()
                Label("activity", systemImage: "figure.walk")
                    .font(.caption)
                    .foregroundColor(.secondary)
                HistoryActivityView(moodSnap: moodSnap, data: data)
            }
        }

        Group {
            if totalSocial(moodSnap: moodSnap, settings: data.settings) != 0 {
                Divider()
                Label("social", systemImage: "person.2")
                    .font(.caption)
                    .foregroundColor(.secondary)
                HistorySocialView(moodSnap: moodSnap, data: data)
            }
        }

        if !String(moodSnap.notes).isEmpty {
            Group {
                Divider()
                Text(String(moodSnap.notes))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
