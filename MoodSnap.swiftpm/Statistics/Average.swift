import SwiftUI

func average(data: [CGFloat?]) -> CGFloat? {
    var sum: CGFloat = 0
    var count: CGFloat = 0
    var av: CGFloat?
    
    for y in data {
        if (y != nil) {
            sum += y!
            count += 1
        }
    }
    
    if (count > 0) {
        av = sum / count
    } else {
        av = nil
    }
    
    return av
}
