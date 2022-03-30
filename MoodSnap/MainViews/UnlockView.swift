import LocalAuthentication
import SwiftUI

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
                        Text("Unlock")
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

    func authenticate() {
        if data.settings.useFaceID && !isUnlocked {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Unlock to acces MoodSnap."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                    if success {
                        isUnlocked = true
                    } else {
                        isUnlocked = false
                    }
                }
            } else {
                isUnlocked = true
                data.settings.useFaceID = false
                print("FaceID not available.")
            }
        }
    }
}
