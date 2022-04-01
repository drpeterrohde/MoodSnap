import SwiftUI

/**
 View with date picker.
 */
struct DatePickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var moodSnap: MoodSnapStruct
    var settings: SettingsStruct
        
    var body: some View {
        GroupBox(label: Label("Edit timestamp", systemImage: "clock").foregroundColor(themes[settings.theme].iconColor)) {
            Divider()
            VStack(alignment: .center) {
                Text(moodSnap.timestamp.dateTimeString()).font(.caption)
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
            } label:{Image(systemName: "arrowtriangle.right.circle")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(themes[settings.theme].buttonColor)
                    .frame(width: themes[settings.theme].controlBigIconSize, height: themes[settings.theme].controlBigIconSize)
            }
        }
    }
}
