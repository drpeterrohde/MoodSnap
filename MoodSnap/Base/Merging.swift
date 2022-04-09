import SwiftUI

/**
 Merge array `moodSnaps` into a single `MoodSnapStruct` representing maximum values and combined `symptoms`, `activities` and `social` values (via logical AND).
 */
func mergeMoodSnaps(moodSnaps: [MoodSnapStruct]) -> MoodSnapStruct? {
    if moodSnaps.count == 0 {
        return nil
    }

    var collapsed = MoodSnapStruct()

    for moodSnap in moodSnaps {
        collapsed.timestamp = moodSnap.timestamp
        collapsed.elevation = max(collapsed.elevation,
                                  moodSnap.elevation)
        collapsed.depression = max(collapsed.depression,
                                   moodSnap.depression)
        collapsed.anxiety = max(collapsed.anxiety,
                                moodSnap.anxiety)
        collapsed.irritability = max(collapsed.irritability,
                                     moodSnap.irritability)

        for i in 0 ..< symptomList.count {
            collapsed.symptoms[i] = collapsed.symptoms[i] || moodSnap.symptoms[i]
        }

        for i in 0 ..< activityList.count {
            collapsed.activities[i] = collapsed.activities[i] || moodSnap.activities[i]
        }

        for i in 0 ..< socialList.count {
            collapsed.social[i] = collapsed.social[i] || moodSnap.social[i]
        }
    }

    return collapsed
}
