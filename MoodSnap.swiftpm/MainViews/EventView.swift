import SwiftUI

struct EventView: View {
    @Environment(\.dismiss) var dismiss
    @State var moodSnap: MoodSnapStruct
    @Binding var data: DataStoreStruct
    
    var body: some View {
        GroupBox {
            HStack{
                Label(calculateDateAndTime(date: moodSnap.timestamp), systemImage: "clock").font(.caption)
                Spacer()
                Button {
                } label:{Image(systemName: "calendar.badge.clock").resizable().scaledToFill().frame(width: 15, height: 15).foregroundColor(Color.primary)}
            }
            
            VStack{
                Divider()
                Label("Event", systemImage: "star.fill").font(.caption)
                TextEditor(text: $moodSnap.event).font(.caption).frame(height: 30)
            }
            
            VStack{
                Label("Notes", systemImage: "note.text").font(.caption)
                TextEditor(text: $moodSnap.notes).font(.caption)
            }
            
            Button {
                 moodSnap.snapType = .event
                data.moodSnaps = deleteHistoryItem(moodSnaps: data.moodSnaps, moodSnap: moodSnap)
                data.moodSnaps.append(moodSnap)
                data.moodSnaps = sortByDate(moodSnaps: data.moodSnaps)
                 dismiss()
                 
            } label:{Image(systemName: "arrowtriangle.right.circle").resizable().scaledToFill().frame(width: 30, height: 30)}
        }
    }
}
