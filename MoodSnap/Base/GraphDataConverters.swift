import SwiftUI

/**
 Make line chart data using `y` coordinates, truncated and padded to given `timescale`.
 */
@inline(__always) func makeLineData(y: [CGFloat?], timescale: Int) -> [CGFloat?] {
    let yTrunc = Array(y.suffix(timescale))
    var yTotal: [CGFloat?] = []

    if timescale > yTrunc.count {
        let y1: [CGFloat?] = Array(repeating: nil, count: timescale - yTrunc.count)
        let y2: [CGFloat?] = yTrunc
        yTotal = y1 + y2
    } else {
        yTotal = yTrunc
    }

    let entries = yTotal
    return entries
}

/**
 Make bar chart data using `y` coordinates, truncated and padded to given `timescale`.
 */
@inline(__always) func makeChartData(y: [CGFloat?]?, timescale: Int) -> [CGFloat?] {
    if y == nil {
        return []
    }
    
    let yTrunc = Array(y!.suffix(timescale))
    var yTotal: [CGFloat?] = []

    if timescale > yTrunc.count {
        let y1: [CGFloat?] = Array(repeating: nil, count: timescale - yTrunc.count)
        let y2: [CGFloat?] = yTrunc
        yTotal = y1 + y2
    } else {
        yTotal = yTrunc
    }

    return yTotal
}
