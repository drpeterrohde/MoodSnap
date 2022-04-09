import Charts
import SwiftUI

/**
 View with multiple line charts.
 */
struct MultipleLineChart: UIViewRepresentable {
    var entries: [[ChartDataEntry]]
    var color: [NSUIColor]
    var showMidBar: Bool = false
    var min: CGFloat = 0
    var max: CGFloat = 4
    var guides: Int = 4

    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        chart.data = addData()
        chart.leftAxis.labelCount = guides
        chart.leftAxis.axisMinimum = min
        chart.leftAxis.axisMaximum = max
        chart.leftAxis.labelTextColor = UIColor(Color.secondary)
        chart.rightAxis.labelCount = guides
        chart.rightAxis.axisMinimum = min
        chart.rightAxis.axisMaximum = max
        if entries[0].count == 0 {
            chart.xAxis.axisMinimum = -1
            chart.xAxis.axisMaximum = 0
        }
        chart.rightAxis.enabled = true
        chart.legend.enabled = false
        chart.xAxis.granularity = 1000
        chart.drawMarkers = true
        chart.drawBordersEnabled = false
        chart.highlightPerTapEnabled = false
        chart.isUserInteractionEnabled = false
        chart.leftAxis.labelFont = .systemFont(ofSize: 10)
        chart.rightAxis.labelFont = .systemFont(ofSize: 0)
        chart.xAxis.labelFont = .systemFont(ofSize: 0)

        return chart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData()
        uiView.leftAxis.axisMinimum = min
        uiView.leftAxis.axisMaximum = max
        uiView.rightAxis.labelCount = guides
        uiView.rightAxis.axisMinimum = min
        uiView.rightAxis.axisMaximum = max
    }

    func addData() -> LineChartData {
        let data = LineChartData()

        for i in 0 ... (entries.count - 1) {
            let dataSet = LineChartDataSet(entries[i])
            dataSet.colors = [color[i]]
            dataSet.lineWidth = 2
            dataSet.circleRadius = 0 // 4
            // dataSet.circleHoleRadius = 2
            // dataSet.circleColors = [color[i]]
            // dataSet.circleHoleColor = NSUIColor(Color(UIColor.systemBackground))
            dataSet.valueFont = UIFont.systemFont(ofSize: 0)
            data.addDataSet(dataSet)
        }

        if showMidBar {
            let n = entries[0].count - 1
            let bar = makeVerticalLine(x: (CGFloat(n) / 2.0) - 1.0)
            let dataSet = LineChartDataSet(entries: bar)
            dataSet.colors = [NSUIColor(Color.primary).withAlphaComponent(0.6)]
            dataSet.lineWidth = midLineWidth
            dataSet.circleRadius = 0
            dataSet.valueFont = UIFont.systemFont(ofSize: 0)
            data.addDataSet(dataSet)
        }

        return data
    }

    typealias UIViewType = LineChartView
}
