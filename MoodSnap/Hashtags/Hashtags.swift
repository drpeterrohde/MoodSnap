import SwiftUI

/**
 Extract an array of all the hashtags from `string`.
 */
func getHashtags(string: String) -> [String] {
    let delimiters = [".", ":", ",", "?", "!", "\n"]
    var delimited = string
    for i in 0 ..< delimiters.count {
        delimited = delimited.replacingOccurrences(of: delimiters[i], with: " ")
    }
    let separated = delimited.components(separatedBy: " ")
    let hashtags = separated.filter { $0.hasPrefix("#") }
    let unique = Array(Set(hashtags))
    let sorted = unique.sorted {
        $0.lowercased() < $1.lowercased()
    }
    return sorted
}

/**
 Extract an array of all the hashtags from an array of `moodSnaps`.
 */
func getHashtags(moodSnaps: [MoodSnapStruct]) -> [String] {
    var bigString: String = ""

    for moodSnap in moodSnaps {
        bigString += " " + moodSnap.notes.lowercased()
        bigString += " " + moodSnap.event.lowercased()
    }

    let hashtags: [String] = getHashtags(string: bigString)
    return hashtags
}

/**
 Count the number of `moodSnaps` that contain a given `hashtag`.
 */
func countHashtagOccurrences(hashtag: String, moodSnaps: [MoodSnapStruct]) -> Int {
    var occurrences = 0

    for moodSnap in moodSnaps {
        if containsHashtag(string: moodSnap.notes, hashtag: hashtag) || containsHashtag(string: moodSnap.event, hashtag: hashtag) {
        //if moodSnap.notes.contains(hashtag) || moodSnap.event.contains(hashtag) {
            occurrences += 1
        }
    }

    return occurrences
}

/**
 Count the number of occurrences of an array of `hashtags` in an array of `moodSnaps`.
 */
func countHashtagOccurrences(hashtags: [String], moodSnaps: [MoodSnapStruct]) -> [Int] {
    var occurrences: [Int] = []

    for hashtag in hashtags {
        let thisCount = countHashtagOccurrences(hashtag: hashtag, moodSnaps: moodSnaps)
        occurrences.append(thisCount)
    }

    return occurrences
}
