import SwiftUI

/**
 Merge array `moodSnaps` into a single `MoodSnapStruct` representing maximum values and combined `symptoms`, `activities` and `social` values (via logical AND).
 */
@inline(__always) func mergeMoodSnaps(moodSnaps: [MoodSnapStruct]) -> MoodSnapStruct? {
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

/**
 Merge array `healthSnaps` into a single `HealthSnapStruct` representing maximum values and combined `symptoms`, `activities` and `social` values (via logical AND).
 */
@inline(__always) func mergeHealthSnaps(healthSnaps: [HealthSnapStruct]) -> HealthSnapStruct? {
    if healthSnaps.count == 0 {
        return nil
    }

    var collapsed = HealthSnapStruct()

    for healthSnap in healthSnaps {
        collapsed.timestamp = healthSnap.timestamp
        
        if collapsed.walkingRunningDistance == nil {
            collapsed.walkingRunningDistance = healthSnap.walkingRunningDistance
        } else {
            if healthSnap.walkingRunningDistance != nil {
                collapsed.walkingRunningDistance! += healthSnap.walkingRunningDistance!
            }
        }

        if collapsed.weight == nil {
            collapsed.weight = healthSnap.weight
        } else {
            if healthSnap.weight != nil {
                collapsed.weight! = max(collapsed.weight!, healthSnap.weight!)
            }
        }
        
        if collapsed.activeEnergy == nil {
            collapsed.activeEnergy = healthSnap.activeEnergy
        } else {
            if healthSnap.activeEnergy != nil {
                collapsed.activeEnergy! += healthSnap.activeEnergy!
            }
        }
        
        if collapsed.sleepHours == nil {
            collapsed.sleepHours = healthSnap.sleepHours
        } else {
            if healthSnap.sleepHours != nil {
                collapsed.sleepHours! += healthSnap.sleepHours!
            }
        }
        
        if collapsed.menstrual == nil {
            collapsed.menstrual = healthSnap.menstrual
        }
    }

    return collapsed
}
