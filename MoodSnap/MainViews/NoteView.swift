import SwiftUI

/**
 View for diary entry sheet.
 */
struct NoteView: View {
    @Environment(\.dismiss) var dismiss
    @State var moodSnap: MoodSnapStruct
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager
    @State private var showingDatePickerSheet = false

    var body: some View {
        GroupBox {
            HStack {
                Label(moodSnap.timestamp.dateTimeString(), systemImage: "clock").font(.caption)
                Spacer()
                Button {
                    showingDatePickerSheet.toggle()
                } label: { Image(systemName: "calendar.badge.clock").resizable().scaledToFill().frame(width: 15, height: 15).foregroundColor(Color.primary)
                }.sheet(isPresented: $showingDatePickerSheet) {
                    DatePickerView(moodSnap: $moodSnap, settings: data.settings)
                }
            }

            // Notes
            VStack {
                Divider()
                Label("notes", systemImage: "note.text").font(.caption)
                TextEditor(text: $moodSnap.notes).font(.caption)
            }

            Button {
                hapticResponseLight(data: data)
                DispatchQueue.main.async {
                    withAnimation {
                        data.stopProcessing()
                        health.stopProcessing(data: data)
                        moodSnap.snapType = .note
                        data.moodSnaps = deleteHistoryItem(moodSnaps: data.moodSnaps, moodSnap: moodSnap)
                        data.moodSnaps.append(moodSnap)
                        data.startProcessing()
                        health.startProcessing(data: data)
                    }
                }
                dismiss()
            } label: { Image(systemName: "arrowtriangle.right.circle")
                .resizable()
                .scaledToFill()
                .foregroundColor(themes[data.settings.theme].buttonColor)
                .frame(width: themes[data.settings.theme].controlBigIconSize, height: themes[data.settings.theme].controlBigIconSize)
            }
        }
    }
}
