import SwiftUI

/**
 Generate `.light` haptic feedback.
 */
@inline(__always) func hapticResponseLight(data: DataStoreClass) {
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
}

/**
 Generate `.success` haptic feedback.
 */
@inline(__always) func hapticResponseSuccess(data: DataStoreClass) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}
