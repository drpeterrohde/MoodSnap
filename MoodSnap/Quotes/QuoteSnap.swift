import SwiftUI

/**
 Quotes array
 */
let quotes = ["quote_1", "quote_2", "quote_3", "quote_4", "quote_5",
              "quote_6", "quote_7", "quote_8", "quote_9", "quote_10",
              "quote_11", "quote_12", "quote_13", "quote_14", "quote_15",
              "quote_16", "quote_17", "quote_18", "quote_19", "quote_20",
              "quote_21", "quote_22", "quote_23", "quote_24", "quote_25",
              "quote_26", "quote_27", "quote_28", "quote_29", "quote_30",
              "quote_31", "quote_32", "quote_33", "quote_34", "quote_35",
              "quote_36", "quote_37", "quote_38", "quote_39", "quote_40",
              "quote_41", "quote_42", "quote_43", "quote_44", "quote_45",
              "quote_46", "quote_47", "quote_48", "quote_49", "quote_50"]

/**
 Generate a QuoteSnap bsaed on MoodSnap `count` and `quoteFrequency`.
 */
func getQuoteSnap(count: Int) -> MoodSnapStruct? {
    if Locale.current.languageCode != "en" {
            return nil
    }
    
    let remainder: Int = count % quoteFrequency
    let multiple: Int = (count / quoteFrequency - 1) % quotes.count

    if count >= quoteFrequency * quotes.count {
        return nil
    }
    
    if remainder == 0 && count != 0 {
        var quoteSnap = MoodSnapStruct()
        quoteSnap.snapType = .quote
        quoteSnap.notes = "\"" + NSLocalizedString(quotes[multiple], comment: "") + "\""
        return quoteSnap
    } else {
        return nil
    }
}
