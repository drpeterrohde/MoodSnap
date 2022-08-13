import SwiftUI

/**
 Sort `moodSnaps` by their date `timestamp`.
 */
@inline(__always) func sortByDate(moodSnaps: [MoodSnapStruct]) -> [MoodSnapStruct] {
    let newMoodSnaps = moodSnaps.sorted(by: { $0.timestamp > $1.timestamp })
    return newMoodSnaps
}
