import SwiftUI

func normButterflyAverage(data: [CGFloat?], center: Int, maxWindowSize: Int) -> [CGFloat?] {
    let avs: [CGFloat?] = butterflyAverage(data: data, center: center, maxWindowSize: maxWindowSize)!
    var zeroAvs: [CGFloat?] = []
    let center: CGFloat? = avs[Int(round(CGFloat(avs.count-1)/2))]
    
    for x in avs {
        if (x != nil && center != nil) {
            zeroAvs.append(x! - center!)
        }
    }
    
    return zeroAvs
}

// ???
