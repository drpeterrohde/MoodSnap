import SwiftUI

func volatility(data: [CGFloat?]) -> CGFloat? {
    var sum: CGFloat = 0
    var count: CGFloat = 0
    let av = average(data: data)!
    var stdDev: CGFloat = 0
    
    for x in data {
        if (x != nil) {
            sum += pow(x! - av, 2)
            count += 1
        }
    }
    
    if (count > 0) {
        stdDev = sqrt(sum / count)
        return stdDev
    } else {
        return nil
    }
}
