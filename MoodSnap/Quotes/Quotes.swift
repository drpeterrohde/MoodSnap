import SwiftUI


let quote_1 = "There is little doubt that those who get the most from life are those who look for the wonder in even the smallest things they do. Cultivate this skill and you'll find peace and satisfaction as well."
let quote_2 = "Recognise the difference between having and living."
let quote_3 = "When you no longer worry about the future, and no longer have regrets about the past, you exist purely in the moment. If you concentrate on that moment you instinctively know, that as long as you have life you have hope."
let quote_4 = "Enjoy the moment. Breathe easily. Relax."
let quote_5 = "To bear ill-feelings towards someone else is more damaging to the bearer than the recipient. For your own sake forgive quickly and freely."
let quote_6 = "There is seldom any rational reason for having regrets about past deeds or events. Because the past does not exist in any other way than in your memory. When you recognise this lack of reality, you can be calm."
let quote_7 = "Reality is what trips you up when you walk around with your eyes closed."
let quote_8 = "If you come to a fight thinking it will be a fair one, you didn't come prepared."
let quote_9 = "Look for things to make you laugh. If you see nothing worth laughing at pretend you do, then laugh." // Black Books
let quote_10 = "Add a drop of lavender to your bath, and soon, you'll soak yourself calm." // Black Books
let quote_11 = "When you're feeling under pressure, do something different. Roll up your sleeves or eat an orange." // Black Books
let quote_12 = "Add some lavender to milk. Leave town with an orange. Pretend you're laughing at it." // Black Books
let quote_13 = "Conquer anger with non-anger. Conquer badness with goodness. Conquer meanness with generosity. Conquer dishonesty with truth."
let quote_14 = "May all beings have happy minds."
let quote_15 = "Hatred is never appeased by hatred in this world. By non-hatred alone is hatred appeased."
let quote_16 = "It is the time you have wasted for your rose that makes your rose so important."
let quote_17 = "‘What makes the desert beautiful,' said the little prince, 'is that somewhere it hides a well."
let quote_18 = "All grown-ups were once children, but only few of them remember it."
let quote_19 = "Grown-ups never understand anything by themselves, and it is tiresome for children to be always and forever explaining things to them."
let quote_20 = "And now here is my secret, a very simple secret: It is only with the heart that one can see rightly; what is essential is invisible to the eye."
let quote_21 = "The most beautiful things in the world cannot be seen or touched, they are felt with the heart."
let quote_22 = "People have forgotten this truth,’ the fox said. ‘But you mustn't forget it. You become responsible forever for what you've tamed. You're responsible for your rose."
let quote_23 = "It is such a mysterious place, the land of tears."
let quote_24 = "Well, I must endure the presence of a few caterpillars if I wish to become acquainted with the butterflies."
let quote_25 = "You become responsible, forever, for what you have tamed."

let quotes = [quote_1, quote_2, quote_3, quote_4, quote_5,
              quote_6, quote_7, quote_8, quote_9, quote_10,
              quote_11, quote_12, quote_13, quote_14, quote_15,
              quote_16, quote_17, quote_18, quote_19, quote_20,
              quote_21, quote_22, quote_23, quote_24, quote_25
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


