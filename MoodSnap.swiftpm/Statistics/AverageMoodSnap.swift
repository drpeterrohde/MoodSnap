import SwiftUI

func averageMoodSnap(timescale: TimeScaleEnum, data: DataStoreStruct) -> MoodSnapStruct? {
    let samples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
    
    let dataE = Array(samples[0].suffix(timescale.rawValue))
    let dataD = Array(samples[1].suffix(timescale.rawValue))
    let dataA = Array(samples[2].suffix(timescale.rawValue))
    let dataI = Array(samples[3].suffix(timescale.rawValue))
    
    let avE = average(data: dataE)
    let avD = average(data: dataD)
    let avA = average(data: dataA)
    let avI = average(data: dataI)
    
    if ((avE == nil) || (avD == nil) || (avA == nil) || (avI == nil)) {
        return nil
    } else {
        let averageMoodSnap = MoodSnapStruct(elevation: avE!, depression: avD!, anxiety: avA!, irritability: avI!)
        return averageMoodSnap
    }
}
