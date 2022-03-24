import SwiftUI

/// Version
let versionString = "0.1a"

/// Windows
let influenceWindowShort = 7
let butterflyWindowShort = 7
let influenceWindowLong = 28
let butterflyWindowLong = 28

/// PDF
let marginPDF = 0.5 * 72
let titleFontSizePDF = 24.0
let subtitleFontSizePDF = 18.0
let bodyFontSizePDF = 12.0
let notesFontSizePDF = 10.0
let headerFontSizePDF = 10.0

/// Time intervals
let dayInterval: CGFloat = 60 * 60 * 24
let weekInterval: CGFloat = 7 * dayInterval
let monthInterval: CGFloat = 4 * weekInterval
let threeMonthInterval: CGFloat = 3 * monthInterval
let sixMonthInterval: CGFloat = 6 * monthInterval
let yearInterval: CGFloat = 365 * dayInterval

/// UX
let zeroGraphicalBarOffset: CGFloat = 0.3
let midLineWidth: CGFloat = 3.0
let iconWidth: CGFloat = 15
var numericFont: Font = Font.system(.caption, design: .monospaced)

// Symptoms
let symptomList = [
    "Anhedonia",
    "Increased apetite",
    "Reduced apetite",
    "Compulsions",
    "Dissociation",
    "Euphoria",
    "Fatigue",
    "Flashbacks",
    "Headaches",
    "Hypersomnia",
    "Hypomania",
    "Insomnia",
    "Mania",
    "Mixed state",
    "Nightmares",
    "Panic attacks",
    "Paranoia",
    "Physical",
    "Psychosis",
    "Restless",
    "Rumination",
    "Self harm",
    "Stimming",
    "Suicidal thoughts"
]

let symptomListIndex = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]

/// Activities
let activityList = [
    "Alcohol", 
    "Caffeine", 
    "Excercise",
    "Meditation",
    "Missed medication",
    "Sexual activity",
    "Substance use",
    "Therapy"
]

let activityListIndex = [0,1,2,3,4,5,6,7]

/// Social
let socialList = [
    "Conflict",
    "Isolation",
    "Positive socialising",
    "Negative socialising",
    "No in-person contact",
]

let socialListIndex = [0,1,2,3,4]

// Mood labels
let moodLabels = ["Elevation", "Depresssion", "Anxiety", "Irritability"]
