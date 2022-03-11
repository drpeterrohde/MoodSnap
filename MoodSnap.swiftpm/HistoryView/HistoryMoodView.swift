import SwiftUI

struct HistoryMoodView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct
    
    var body: some View {
        Divider()
        MoodLevelsView(moodSnap: moodSnap, data: data)

        Group {
            if(totalSymptoms(moodSnap: moodSnap, settings: data.settings) != 0) {
                Divider()
                Label("Symptoms", systemImage: "heart.text.square").font(.caption)
                HistorySymptomsView(moodSnap: moodSnap, data: data)
            }
        }
        
        Group {
            if(totalActivities(moodSnap: moodSnap, settings: data.settings) != 0) {
                Divider()
                Label("Activity", systemImage: "figure.walk").font(.caption)
                HistoryActivityView(moodSnap: moodSnap, data: data)
            }
        }
        
        Group {
            if(totalSocial(moodSnap: moodSnap, settings: data.settings) != 0) {
                Divider()
                Label("Social", systemImage: "person.2").font(.caption)
                HistorySocialView(moodSnap: moodSnap, data: data)
            }
        }
        
        if (!(String(moodSnap.notes).isEmpty)) {
            Group {
                Divider()
                Spacer()
                Text(String(moodSnap.notes)).font(.caption).padding(-5).frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
