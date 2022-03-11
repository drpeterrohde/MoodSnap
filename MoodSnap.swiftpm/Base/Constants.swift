import SwiftUI

let versionString = "0.1a"

// Demo data
let demoDataSize: Int = 100
let demoDataRandomMiss: CGFloat = 0

// PDF
let marginPDF = 0.5 * 72
let titleFontSizePDF = 24.0
let subtitleFontSizePDF = 18.0
let bodyFontSizePDF = 12.0
let notesFontSizePDF = 10.0
let headerFontSizePDF = 10.0

// Time intervals
let dayInterval: CGFloat = 60 * 60 * 24
let weekInterval: CGFloat = 7 * dayInterval
let monthInterval: CGFloat = 4 * weekInterval
let threeMonthInterval: CGFloat = 3 * monthInterval
let sixMonthInterval: CGFloat = 6 * monthInterval
let yearInterval: CGFloat = 365 * dayInterval

// UX
let zeroGraphicalBarOffset = 0.3
let midLineWidth = 3.0

let symptomList = [
    "Anhedonia",
    "Increased apetite",
    "Reduced apetite",
    "Compulsions",
    "Dissociation",
    "Euphoria",
    "Fatigue",
    "Flashbacks",
    "Hypersomnia",
    "Insomnia",
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

let socialList = [
    "Positive socialising",
    "Negative socialising",
    "No in-person contact",
]

let moodLabels = ["Elevation", "Depresssion", "Anxiety", "Irritability"]
