import SwiftUI

/**
 Sort `moodSnaps` by their date `timestamp`.
 */
func sortByDate(moodSnaps: [MoodSnapStruct]) -> [MoodSnapStruct] {
    let newMoodSnaps = moodSnaps.sorted(by: { $0.timestamp > $1.timestamp })
    return newMoodSnaps
}
