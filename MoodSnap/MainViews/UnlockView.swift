import LocalAuthentication
import SwiftUI

/**
 View for unlock sheet.
 */
struct UnlockView: View {
    @Binding var isUnlocked: Bool
    @Binding var data: DataStoreStruct

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
                    authenticate()
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
        }
        .onAppear {
            authenticate()
        }
    }

    /**
     FaceID authentication
     */
    func authenticate() {
        // If we're using FaceID and we're locked
        if data.settings.useFaceID && !isUnlocked {
            let context = LAContext()
            var error: NSError?

            // Is biometric authentication available?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Unlock to acces MoodSnap."

                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, _ in
                    if success {
                        // Authentication success
                        DispatchQueue.main.async {
                            isUnlocked = true
                        }
                    } else {
                        // Authentication failure
                        DispatchQueue.main.async {
                            isUnlocked = false
                        }
                    }
                }
            } else {
                // Biometrics not available
                DispatchQueue.main.async {
                    isUnlocked = true
                    data.settings.useFaceID = false
                }
            }
        }
    }
}
