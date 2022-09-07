import SwiftUI

/**
 Generate `.light` haptic feedback.
 */
@inline(__always) func hapticResponseLight(data: DataStoreClass) {
    data.hapticGeneratorLight.impactOccurred()
}

/**
 Generate `.success` haptic feedback.
 */
//@inline(__always) func hapticResponseSuccess(data: DataStoreClass) {
//    let generator = UINotificationFeedbackGenerator()
//    generator.notificationOccurred(.success)
//}
