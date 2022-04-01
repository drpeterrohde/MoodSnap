import SwiftUI

/**
 Generate a QuoteSnap bsaed on MoodSnap `count` and `quoteFrequency`.
 */
func getQuoteSnap(count: Int) -> MoodSnapStruct? {
    let remainder: Int = count % quoteFrequency
    let multiple: Int = (count / quoteFrequency - 1) % quotes.count

    if remainder == 0 && multiple < quotes.count && count != 0 {
        var quoteSnap = MoodSnapStruct()
        quoteSnap.snapType = .quote
        quoteSnap.notes = quotes[multiple]
        return quoteSnap
    } else {
        return nil
    }
}
