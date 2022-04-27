import Charts
import SwiftUI

/**
 View with line chart.
 */
struct LineChartOld: UIViewRepresentable {
    var entries: [ChartDataEntry]
    var color: NSUIColor

    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        chart.data = addData()
        chart.leftAxis.labelCount = 4
        chart.leftAxis.axisMinimum = 0
        chart.leftAxis.axisMaximum = 4
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.xAxis.granularity = 1
        chart.drawMarkers = false
        chart.highlightPerTapEnabled = false
        chart.isUserInteractionEnabled = false

        return chart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData()
    }

    func addData() -> LineChartData {
        let data = LineChartData()
        let dataSet = LineChartDataSet(entries: entries)
        dataSet.colors = [color]
        dataSet.lineWidth = 1.5
        dataSet.circleRadius = 0
        dataSet.valueFont = UIFont.systemFont(ofSize: 0)
        data.addDataSet(dataSet)
        return data
    }

    typealias UIViewType = LineChartView
}
