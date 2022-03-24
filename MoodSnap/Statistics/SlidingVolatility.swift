import SwiftUI

func slidingVolatility(data: [CGFloat?], windowSize: Int) -> [CGFloat?] {
    var volatilities: [CGFloat?] = []
    
    if (data.count > windowSize) {
        for offset in 0...(data.count-windowSize-1) {
            let window = Array(data[offset...(offset+windowSize-1)])
            let thisVolatility = volatility(data: window)
            volatilities.append(thisVolatility)
        }
    } else {
        let thisVolatility = volatility(data: data)
        volatilities.append(thisVolatility)
    }
    
    return volatilities
}
