import SwiftUI


let quote_1 = "There is little doubt that those who get the most from life are those who look for the wonder in even the smallest things they do. Cultivate this skill and you'll find peace and satisfaction as well."
let quote_2 = "Recognise the difference between having and living."
let quote_3 = "When you no longer worry about the future, and no longer have regrets about the past, you exist purely in the moment. If you concentrate on that moment you instinctively know, that as long as you have life you have hope."
let quote_4 = "Enjoy the moment. Breathe easily. Relax."
let quote_5 = "To bear ill-feelings towards someone else is more damaging to the bearer than the recipient. For your own sake forgive quickly and freely."
let quote_6 = "There is seldom any rational reason for having regrets about past deeds or events. Because the past does not exist in any other way than in your memory. When you recognise this lack of reality, you can be calm."

let quotes = [quote_1,
              quote_2,
              quote_3,
              quote_4,
              quote_5,
              quote_6
]

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


