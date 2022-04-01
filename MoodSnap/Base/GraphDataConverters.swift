import SwiftUI
import Charts

/**
 Make line chart data using `y` coordinates, truncated and padded to given `timescale`.
 */
func makeLineData(y: [CGFloat?], timescale: Int) -> [ChartDataEntry] {
    let yTrunc = Array(y.suffix(timescale))
    
    var xTotal: [CGFloat] = []
    var yTotal: [CGFloat?] = []
    
    if timescale > yTrunc.count {
        let x1: [CGFloat] = Array(stride(from: 0.0, to: CGFloat(timescale - yTrunc.count - 1), by: 1.0))
        let y1: [CGFloat?] = Array(repeating: 0.0, count: timescale-yTrunc.count)
        let x2: [CGFloat] = Array(stride(from: CGFloat(timescale-yTrunc.count), to: CGFloat(timescale), by: 1.0))
        let y2: [CGFloat?] = yTrunc
        
        xTotal = x1 + x2
        yTotal = y1 + y2
    } else {
        xTotal = Array(stride(from: 0.0, to: CGFloat(yTrunc.count), by: 1.0))
        yTotal = yTrunc
    }
    
    let entries = makeLineData(x: xTotal, y: yTotal)
    return entries
}

/**
 Make date for line plot using `y` coordinates.
 */
func makeLineData(y: [CGFloat?]) -> [ChartDataEntry] {
    if (y.count == 0) { return [] }
    
    let x: [CGFloat] = Array(stride(from: 0.0, to: CGFloat(y.count), by: 1.0))
    let entries = makeLineData(x: x, y: y)
    return entries
}

/**
 Make date for line plot using `x` and `y` coordinates.
 */
func makeLineData(x: [CGFloat], y: [CGFloat?]) -> [ChartDataEntry] {
    if (x.count == 0) { return [] }
    
    var entries: [ChartDataEntry] = []
    
    for i in 0..<x.count {
        if (y[i] == nil) {
            continue
        } else {
            entries.append(ChartDataEntry(x: x[i], y: y[i]!))
        }
    }
    
    return entries
}

/**
 Make date for bar chart using `y` coordinates.
 */
func makeBarData(y: [CGFloat?]) -> [BarChartDataEntry] {
    let x: [CGFloat] = Array(stride(from: 0.0, to: CGFloat(y.count), by: 1.0))
    let entries = makeBarData(x: x, y: y)
    return entries
}

/**
 Make bar chart data using `y` coordinates, truncated and padded to given `timescale`.
 */
func makeBarData(y: [CGFloat?], timescale: Int) -> [BarChartDataEntry] {
    let yTrunc = Array(y.suffix(timescale))
    
    var xTotal: [CGFloat] = []
    var yTotal: [CGFloat?] = []
    
    if timescale > yTrunc.count {
        let x1: [CGFloat] = Array(stride(from: 0.0, to: CGFloat(timescale-yTrunc.count), by: 1.0)) // removed -1???
        let y1: [CGFloat?] = Array(repeating: nil, count: timescale-yTrunc.count)
        let x2: [CGFloat] = Array(stride(from: CGFloat(timescale-yTrunc.count), to: CGFloat(timescale), by: 1.0))
        let y2: [CGFloat?] = yTrunc
        
        xTotal = x1 + x2
        yTotal = y1 + y2
    } else {
        xTotal = Array(stride(from: 0.0, to: CGFloat(yTrunc.count), by: 1.0))
        yTotal = yTrunc
    }
    
    let entries = makeBarData(x: xTotal, y: yTotal)
    return entries
}

/**
 Make date for bar chart using `x` and `y` coordinates.
 */
func makeBarData(x: [CGFloat], y: [CGFloat?]) -> [BarChartDataEntry] {
    var entries: [BarChartDataEntry] = []
    
    for i in 0..<x.count {
        if (y[i] == nil) {
            entries.append(BarChartDataEntry(x: x[i], y: 0))
        } else if (y[i] == 0) {
            entries.append(BarChartDataEntry(x: x[i], y: y[i]! + zeroGraphicalBarOffset))
        } else {
            entries.append(BarChartDataEntry(x: x[i], y: y[i]!))
        }
    }
    
    return entries
}

/**
 Make date for horizontal scatter plot using `x and `y` coordinates.
 */
func makeScatterData(x: [CGFloat], y: [CGFloat]) -> [ChartDataEntry] {
    return makeLineData(x: x, y: y)
}

/**
 Make a vertical line for a line chart.
 */
func makeVerticalLine(x: CGFloat) -> [ChartDataEntry] {
    let bottom = ChartDataEntry(x: x+1, y: -4)
    let top = ChartDataEntry(x: x+1, y: 4)
    
    return [bottom, top]
}
