import SwiftUI

struct IntroPopoverView: View {
    @Environment(\.dismiss) var dismiss
    var data: DataStoreStruct
    
    var body: some View {
        ZStack {
        themes[data.settings.theme].logoColor
            VStack(alignment: .center) {
                Image("moodsnap_logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text(.init(intro_popover_title_string))
                    .font(.headline)
                    .foregroundColor(.white)
                Text(.init(intro_popover_description_string))
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
//                Image("control_bar_help_settings")
//                    .resizable()
//                    .scaledToFit()
//                    .cornerRadius(5)
//                    .padding([.leading, .trailing], 5)
                Text(.init(intro_popover_note_string))
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
        }
    }
}

