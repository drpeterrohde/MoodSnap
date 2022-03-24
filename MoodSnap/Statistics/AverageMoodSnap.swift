import SwiftUI

/**
 Return a `MoodSnapStruct` of the average of those in a given `timescale`.
 */
func averageMoodSnap(timescale: Int, data: DataStoreStruct) -> MoodSnapStruct? {
    let samples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
    
    let dataE = Array(samples[0].suffix(timescale))
    let dataD = Array(samples[1].suffix(timescale))
    let dataA = Array(samples[2].suffix(timescale))
    let dataI = Array(samples[3].suffix(timescale))
    
    let averageE = average(data: dataE)
    let averageD = average(data: dataD)
    let averageA = average(data: dataA)
    let averageI = average(data: dataI)
    
    if ((averageE == nil) || (averageD == nil) || (averageA == nil) || (averageI == nil)) {
        return nil
    } else {
        var averageMoodSnap = MoodSnapStruct()
        averageMoodSnap.elevation = averageE!
        averageMoodSnap.depression = averageD!
        averageMoodSnap.anxiety = averageA!
        averageMoodSnap.irritability = averageI!
        return averageMoodSnap
    }
}

/**
 Return a `MoodSnapStruct` of the volatility of those in a given `timescale`.
 */
func averageVolatilitySnap(timescale: Int, data: DataStoreStruct) -> MoodSnapStruct? {
    let samples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
    
    // ??? uses wrong samples
    let dataE = Array(samples[0].suffix(timescale))
    let dataD = Array(samples[1].suffix(timescale))
    let dataA = Array(samples[2].suffix(timescale))
    let dataI = Array(samples[3].suffix(timescale))
    
    let volatilityE = volatility(data: dataE)
    let volatilityD = volatility(data: dataD)
    let volatilityA = volatility(data: dataA)
    let volatilityI = volatility(data: dataI)
    
    if ((volatilityE == nil) || (volatilityD == nil) || (volatilityA == nil) || (volatilityI == nil)) {
        return nil
    } else {
        var averageMoodSnap = MoodSnapStruct()
        averageMoodSnap.elevation = 2 * volatilityE!
        averageMoodSnap.depression = 2 * volatilityD!
        averageMoodSnap.anxiety = 2 * volatilityA! 
        averageMoodSnap.irritability = 2 * volatilityI!
        return averageMoodSnap
    }
}
