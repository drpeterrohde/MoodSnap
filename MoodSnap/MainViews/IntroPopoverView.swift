import SwiftUI

/**
 View for introduction popover sheet.
 */
struct IntroPopoverView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        ZStack {
            themes[data.settings.theme].logoColor
            VStack(alignment: .center) {
                VStack(alignment: .center) {
                    Image("moodsnap_logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("Mood diary redesigned")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                Text(.init("intro_popover_title_string"))
                    .font(.headline)
                    .foregroundColor(.white)
                Text(.init("intro_popover_description_string"))
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                Text(.init("intro_popover_note_string"))
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                Text(.init("intro_popover_disclaimer_string"))
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
        }
    }
}
