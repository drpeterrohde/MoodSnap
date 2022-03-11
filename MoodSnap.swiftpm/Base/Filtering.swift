import SwiftUI

func getAllSamples(moodSnaps: [MoodSnapStruct?]) -> [[CGFloat?]] {
    var samplesE: [CGFloat?] = []
    var samplesD: [CGFloat?] = []
    var samplesA: [CGFloat?] = []
    var samplesI: [CGFloat?] = []
    
    for moodSnap in moodSnaps {
        if moodSnap == nil {
            samplesE.append(nil)
            samplesD.append(nil)
            samplesA.append(nil)
            samplesI.append(nil)
        } else {
            samplesE.append(moodSnap!.elevation)
            samplesD.append(moodSnap!.depression)
            samplesA.append(moodSnap!.anxiety)
            samplesI.append(moodSnap!.irritability)
        }
    }
    
    return [samplesE, samplesD, samplesA, samplesI]
}

func getSamplesByWindow(moodSnaps: [MoodSnapStruct?], date: Date, reverseWindow: Int = 1) -> [[CGFloat]] {
    // ???
    return [[]]
}

func getFlattenedSamplesByWindow(moodSnaps: [MoodSnapStruct?], date: Date, reverseWindow: Int = 1) -> [[CGFloat]] {
    //padded = ???
    return [[]]
}

func getFlattenedPaddedSamples(moodSnaps: [MoodSnapStruct]) -> [[CGFloat?]] {
    let flattenedMoodSnaps = flattenAndPadMoodSnaps(moodSnaps: moodSnaps)
    return getAllSamples(moodSnaps: flattenedMoodSnaps)
}

func getMoodSnapByUUID(moodSnaps: [MoodSnapStruct], id: UUID) -> MoodSnapStruct? {
    if let item = moodSnaps.first(where: { $0.id == id }) {
        return item
    }
    return nil
}

func dateWindow(date: Date, reverseWindow: Int = 1) -> (Date, Date) {
    let start = Calendar.current.date(
        byAdding: .day, 
        value: -reverseWindow, 
        to: Calendar.current.startOfDay(for: date))!
    let end = Calendar.current.date(
        byAdding: .day, 
        value: 1, 
        to: Calendar.current.startOfDay(for: date))!
    
    return (start, end)
}

func getMoodSnapsByDate(moodSnaps: [MoodSnapStruct], date: Date, reverseWindow: Int = 1) -> [MoodSnapStruct] {
    let (start, end) = dateWindow(date: date, reverseWindow: reverseWindow)
    let dateRange = start ... end
    var moodSnapsByDate: [MoodSnapStruct] = []
    
    for moodSnap in moodSnaps {
        if (moodSnap.snapType == .mood) {
            if dateRange.contains(moodSnap.timestamp) {
                moodSnapsByDate.append(moodSnap)
            }
        }
    }
    
    return moodSnapsByDate
}

//func getSamplesByDateComponents(moodSnaps: [MoodSnapStruct], dateComponents: DateComponents, reverseWindow: Int = 1) -> [[CGFloat]] {
//    let moodSnapsByDateComponents = getMoodSnapsByDateComponents(moodSnaps: moodSnaps, dateComponents: dateComponents, reverseWindow: reverseWindow)
//
//    var samplesE: [CGFloat] = []
//    var samplesD: [CGFloat] = []
//    var samplesA: [CGFloat] = []
//    var samplesI: [CGFloat] = []
//    
//    for moodSnap in moodSnapsByDateComponents {
//        if (moodSnap.snapType == .mood) {
//            samplesE.append(moodSnap.elevation)
//            samplesD.append(moodSnap.depression)
//            samplesA.append(moodSnap.anxiety)
//            samplesI.append(moodSnap.irritability)
//        }
//    }
//    
//    return [samplesE, samplesD, samplesA, samplesI]
//}

func getFirstDate(moodSnaps: [MoodSnapStruct]) -> Date {
    var firstDate = Date()
    for moodSnap in moodSnaps {
        if moodSnap.timestamp < firstDate {
            firstDate = moodSnap.timestamp 
        }
    }
    return firstDate
}

func getLastDate(moodSnaps: [MoodSnapStruct]) -> Date {
    var lastDate = Date()
    for moodSnap in moodSnaps {
        if moodSnap.timestamp > lastDate {
            lastDate = moodSnap.timestamp 
        }
    }
    return lastDate
}

func flattenAndPadMoodSnaps(moodSnaps: [MoodSnapStruct]) -> [MoodSnapStruct?] {
    var flattened: [MoodSnapStruct?] = []
    let firstDate = getFirstDate(moodSnaps: moodSnaps)
    let lastDate = getLastDate(moodSnaps: moodSnaps)
    var currentDate = firstDate
    //var blank: MoodSnapStruct
    
    while (currentDate <= lastDate) {
        let currentSnaps = getMoodSnapsByDate(moodSnaps: moodSnaps, date: currentDate)
        if let mergedSnap = mergeMoodSnaps(moodSnaps: currentSnaps) {
            flattened.append(mergedSnap)
        } else {
            flattened.append(nil)
        }
        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
    }
    
    return flattened
}

func getMergedSampleByDate(moodSnaps: [MoodSnapStruct], date: Date) -> [CGFloat?] {
    let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    var moodSnapsByDate: [MoodSnapStruct] = []
    
    for moodSnap in moodSnaps {
        if (moodSnap.snapType == .mood) {
            let thisDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: moodSnap.timestamp)
            
            if (dateComponents == thisDateComponents) {
                moodSnapsByDate.append(moodSnap)
            }
        }
    }
    
    var sampleE: CGFloat? = nil
    var sampleD: CGFloat? = nil
    var sampleA: CGFloat? = nil
    var sampleI: CGFloat? = nil
    
    if let mergedMoodSnap = mergeMoodSnaps(moodSnaps: moodSnapsByDate) {
        sampleE = mergedMoodSnap.elevation
        sampleD = mergedMoodSnap.depression
        sampleA = mergedMoodSnap.anxiety
        sampleI = mergedMoodSnap.irritability
    }
    
    return [sampleE, sampleD, sampleA, sampleI]
}

func getSamplesByDateWindow(moodSnaps: [MoodSnapStruct], endDate: Date, windowInterval: Int, type: MoodsEnum) -> [CGFloat?] {
    let endDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: endDate)
    let startDate = subtractDaysFromDate(date: endDate, days: windowInterval-1)!
    let startDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: startDate)
    
    var samples: [CGFloat] = []
    
    for moodSnap in moodSnaps {
        if (moodSnap.snapType == .mood) {
            let thisDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: moodSnap.timestamp)
            
            if (thisDateComponents >= startDateComponents && thisDateComponents <= endDateComponents) {
                switch type {
                case .elevation:
                    samples.append(moodSnap.elevation)
                case .depression:
                    samples.append(moodSnap.depression)
                case .anxiety:
                    samples.append(moodSnap.anxiety)
                case .irritability:
                    samples.append(moodSnap.irritability)
                }
            }
        }
    }
    
    return samples
}

func sortByDate(moodSnaps: [MoodSnapStruct]) -> [MoodSnapStruct] {
    let newMoodSnaps = moodSnaps.sorted(by: { $0.timestamp > $1.timestamp })
    return newMoodSnaps
}

func getEventsList(moodSnaps: [MoodSnapStruct]) -> [(String, Date)] {
    var list: [(String, Date)] = []
    
    for moodSnap in sortByDate(moodSnaps: moodSnaps) {
        if (moodSnap.snapType == .event) {
            list.append((moodSnap.event, moodSnap.timestamp))
        }
    }
    
    return list
}

func mergeMoodSnaps(moodSnaps: [MoodSnapStruct]) -> MoodSnapStruct? {
    if (moodSnaps.count == 0) {
        return nil
    }
    
    var collapsed = MoodSnapStruct()
    
    for moodSnap in moodSnaps {
        collapsed.timestamp = Calendar.current.startOfDay(for: moodSnap.timestamp)
        collapsed.elevation = max(collapsed.elevation, moodSnap.elevation)
        collapsed.depression = max(collapsed.depression, moodSnap.depression)
        collapsed.anxiety = max(collapsed.anxiety, moodSnap.anxiety)
        collapsed.irritability = max(collapsed.irritability, moodSnap.irritability)
    
        for i in 0..<symptomList.count {
            collapsed.symptoms[i] = collapsed.symptoms[i] && moodSnap.symptoms[i]
        }
    
        for i in 0..<activityList.count {
            collapsed.activities[i] = collapsed.activities[i] && moodSnap.activities[i]
        }
        
        for i in 0..<socialList.count {
            collapsed.social[i] = collapsed.social[i] && moodSnap.social[i]
        }
    }
    
    return collapsed
}

func snapFilter(moodSnap: MoodSnapStruct, filter: SnapTypeEnum, searchText: String) -> Bool {
    let filterOutcome =
    (filter == .mood && moodSnap.snapType == .mood) || 
    (filter == .event && moodSnap.snapType == .event) || 
    (filter == .note && moodSnap.snapType == .note) ||
    (filter == .media && moodSnap.snapType == .media)
    
    if filterOutcome { return true }
    
    if (filter == .none) {
        let eventTextOutcome = moodSnap.event.lowercased().contains(searchText.lowercased()) || (searchText == "")
        let notesTextOutcome = moodSnap.notes.lowercased().contains(searchText.lowercased())  || (searchText == "")
        
        if (eventTextOutcome || notesTextOutcome) {
            return true
        }
    }
    
    return false
}
