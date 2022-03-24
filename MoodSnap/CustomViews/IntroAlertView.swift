import SwiftUI

struct IntroAlertView: View {
    var body: some View {
        Group {
            VStack(alignment: .center){
                Divider()
                Spacer().frame(height: 10)
                Text(String("Welcome to MoodSnap!"))
                    .font(.caption)
                    .fontWeight(.bold)
                Divider()
                Text("This is your mood diary feed. MoodSnaps, notes, photos and life events appear here. At the bottom of the screen you can open your mood _insights_ panel. It is recommended quickly reading the help page to understand the features of MoodSnap.")
                    .font(.caption)
                    .frame(height: 100)
                Divider()
                Image("control_bar_legend")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
