import SwiftUI

/// Version
let versionString = "1.0b"

/// Quote frequency
let quoteFrequency = 11

/// Time windows
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
let faceIDWidth: CGFloat = 40
let numericFont: Font = Font.system(.caption, design: .monospaced)

/// Symptom list
let symptomList = [
    "Anhedonia",
    "Increased apetite",
    "Reduced apetite",
    "Compulsions",
    "Dissociation",
    "Euphoria",
    "Fatigue",
    "Flashbacks",
    "Flattening",
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
    "Suicidal thoughts"
]

/// Activity list
let activityList = [
    "Alcohol", 
    "Caffeine", 
    "Excercise",
    "Meditation",
    "Missed medication",
    "Nicotine",
    "Sexual activity",
    "Substance use",
    "Therapy"
]

/// Social event list
let socialList = [
    "Affection",
    "Conflict",
    "Isolation",
    "Positive socialising",
    "Negative socialising",
    "No in-person contact"
]

/// Mood labels
let moodLabels = ["Elevation", "Depresssion", "Anxiety", "Irritability"]
