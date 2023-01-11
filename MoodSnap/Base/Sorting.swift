import SwiftUI

/**
 Sort `moodSnaps` by their date `timestamp`.
 */
@inline(__always) func sortByDate(moodSnaps: [MoodSnapStruct]) -> [MoodSnapStruct] {
    return moodSnaps.sorted(by: { $0.timestamp > $1.timestamp })
}

/**
 Sort `healthSnaps` by their date `timestamp`.
 */
@inline(__always) func sortByDate(healthSnaps: [HealthSnapStruct]) -> [HealthSnapStruct] {
    return healthSnaps.sorted(by: { $0.timestamp > $1.timestamp })
}
