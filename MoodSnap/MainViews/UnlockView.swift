import SwiftUI
import LocalAuthentication

struct UnlockView: View {
    @Binding var isUnlocked: Bool
    var data: DataStoreStruct

    var body: some View {
        ZStack {
            themes[data.settings.theme].logoColor
            VStack(alignment: .center) {
                Spacer()
                Image("moodsnap_logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                Button("Unlock") {
                    authenticate()
                }
                .foregroundColor(.white)
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
                let reason = "Unlock to acces your information."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                    if success {
                        isUnlocked = true
                    } else {
                        isUnlocked = false
                    }
                }
            } else {
                print("FaceID not available.")
            }
        }
    }
}
