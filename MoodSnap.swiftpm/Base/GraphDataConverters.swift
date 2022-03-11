import SwiftUI
import Charts

func makeLineData(y: [CGFloat?]) -> [ChartDataEntry] {
    if (y.count == 0) { return [] }
    
    let x: [CGFloat] = Array(stride(from: 0.0, to: CGFloat(y.count), by: 1.0))
    let entries = makeLineData(x: x, y: y)
    return entries
}

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

func makeBarData(y: [CGFloat?]) -> [BarChartDataEntry] {
    let x: [CGFloat] = Array(stride(from: 0.0, to: CGFloat(y.count), by: 1.0))
    let entries = makeBarData(x: x, y: y)
    return entries
}

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

func makeHorizontalBarData(y: [CGFloat]) -> [BarChartDataEntry] {
    let entries = makeBarData(x: [1,2,3,4].reversed(), y: y)
    return entries
}

func makeScatterData(x: [CGFloat], y: [CGFloat]) -> [ChartDataEntry] {
    return makeLineData(x: x, y: y)
}

func makeVerticalLine(x: CGFloat) -> [ChartDataEntry] {
    let bottom = ChartDataEntry(x: x+1, y: 0)
    let top = ChartDataEntry(x: x+1, y: 4)
    
    return [bottom, top]
}

func truncateEntries(data: [BarChartDataEntry], timescale: TimeScaleEnum) -> [BarChartDataEntry] {
    switch timescale {
    case .month:
        return data.suffix(TimeScaleEnum.month.rawValue)
    case .threeMonths:
        return data.suffix(TimeScaleEnum.threeMonths.rawValue)
    case .sixMonths:
        return data.suffix(TimeScaleEnum.sixMonths.rawValue)
    case .year:
        return data.suffix(TimeScaleEnum.year.rawValue)
    }
}

func truncateEntries(data: [ChartDataEntry], timescale: TimeScaleEnum) -> [ChartDataEntry] {
    switch timescale {
    case .month:
        return data.suffix(TimeScaleEnum.month.rawValue)
    case .threeMonths:
        return data.suffix(TimeScaleEnum.threeMonths.rawValue)
    case .sixMonths:
        return data.suffix(TimeScaleEnum.sixMonths.rawValue)
    case .year:
        return data.suffix(TimeScaleEnum.year.rawValue)
    }
}

func truncateEntriesArray(data: [[ChartDataEntry]], timescale: TimeScaleEnum) -> [[ChartDataEntry]] {
    var newData: [[ChartDataEntry]] = []
    
    for item in data {
        let truncatedItem = truncateEntries(data: item, timescale: timescale)
        newData.append(truncatedItem)
    }
    
    return newData
}
