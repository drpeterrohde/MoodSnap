import SwiftUI

/**
 Quotes array
 */
let quotes = ["quote_1", "quote_2", "quote_3", "quote_4", "quote_5",
              "quote_6", "quote_7", "quote_8", "quote_9", "quote_10",
              "quote_11", "quote_12", "quote_13", "quote_14", "quote_15",
              "quote_16", "quote_17", "quote_18", "quote_19", "quote_20",
              "quote_21", "quote_22", "quote_23", "quote_24", "quote_25"]

/**
 Generate a QuoteSnap bsaed on MoodSnap `count` and `quoteFrequency`.
 */
func getQuoteSnap(count: Int) -> MoodSnapStruct? {
    let remainder: Int = count % quoteFrequency
    let multiple: Int = (count / quoteFrequency - 1) % quotes.count

    if remainder == 0 && count != 0 {
        var quoteSnap = MoodSnapStruct()
        quoteSnap.snapType = .quote
        quoteSnap.notes = "\"" + NSLocalizedString(quotes[multiple], comment: "") + "\""
        return quoteSnap
    } else {
        return nil
    }
}
