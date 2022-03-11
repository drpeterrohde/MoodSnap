import SwiftUI

struct DatePickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var moodSnap: MoodSnapStruct
    var settings: SettingsStruct
        
    var body: some View {
        GroupBox(label: Label("Edit timestamp", systemImage: "clock").foregroundColor(themes[settings.theme].iconColor)) {
            Divider()
            VStack(alignment: .center) {
                Text(calculateDateAndTime(date: moodSnap.timestamp)).font(.caption)
            DatePicker(
                "",
                selection: $moodSnap.timestamp,
                displayedComponents: [.date, .hourAndMinute]
            ).datePickerStyle(GraphicalDatePickerStyle())
                Divider()
            Spacer()
            }
            
            // Save button
            Button {
//                moodSnaps = deleteHistoryItem(moodSnaps: moodSnaps, moodSnap: moodSnap)
//                moodSnaps.append(moodSnap)
//                moodSnaps = sortByDate(moodSnaps: moodSnaps)
                dismiss()
            } label:{Image(systemName: "arrowtriangle.right.circle").resizable().scaledToFill().frame(width: 30, height: 30)
            }
        }
    }
}
