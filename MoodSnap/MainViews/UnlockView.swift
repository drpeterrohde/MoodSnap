import LocalAuthentication
import SwiftUI

/**
 View for unlock sheet.
 */
struct UnlockView: View {
    @Binding var isUnlocked: Bool
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        ZStack {
            themes[data.settings.theme].logoColor
            VStack(alignment: .center) {
                Spacer()
                Image("moodsnap_logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                Spacer()
                Button(action: {
                    DispatchQueue.main.async {
                        authenticate()
                    }
                }) {
                    VStack {
                        Image(systemName: "faceid")
                            .resizable()
                            .scaledToFit()
                            .frame(width: faceIDWidth, height: faceIDWidth)
                            .foregroundColor(.white)
                        Text("unlock")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }

                Spacer()
            }
        }.onAppear {
            DispatchQueue.main.async {
                authenticate()
            }
        }
    }

    /**
     FaceID authentication
     */
    func authenticate() {
        if data.settings.useFaceID && !isUnlocked {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Unlock to acces MoodSnap."

                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, _ in
                    if success {
                        // Authentication success
                        isUnlocked = true
                    } else {
                        // Authentication failure
                        isUnlocked = false
                    }
                }
            } else {
                // Authentication not available
                isUnlocked = true
                data.settings.useFaceID = false
            }
        } else {
            isUnlocked = true
        }
    }
}
