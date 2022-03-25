import SwiftUI

let quote_1 = "First quote"
let quote_2 = "Second quote"
let quote_3 = "Third quote"

let quotes = [quote_1, quote_2, quote_3]

func getQuoteSnap(count: Int) -> MoodSnapStruct? {
    let remainder: Int = count % quoteFrequency
    let multiple: Int = count / quoteFrequency - 1
    
    if remainder == 0 && multiple < quotes.count && count != 0 {
        var quoteSnap = MoodSnapStruct()
        quoteSnap.snapType = .quote
        quoteSnap.notes = quotes[multiple]
        return quoteSnap
    } else {
        return nil
    }
}
