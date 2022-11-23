import SwiftUI

/**
 Prepare haptic engine.
 */
@inline(__always) func hapticPrepare(data: DataStoreClass) {
    if hapticsEnabled {
        data.hapticGeneratorLight.prepare()
    }
}

/**
 Generate `.light` haptic feedback.
 */
@inline(__always) func hapticResponseLight(data: DataStoreClass) {
    if hapticsEnabled {
        data.hapticGeneratorLight.impactOccurred()
        data.hapticGeneratorLight.prepare()
    }
}
