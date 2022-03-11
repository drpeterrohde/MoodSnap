import SwiftUI
import Charts

struct MultipleLineChart : UIViewRepresentable {
    var entries : [[ChartDataEntry]]
    var color: [NSUIColor]
    var showMidBar: Bool = false
    var max: CGFloat = 4
    var guides: Int = 4
    
    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        chart.data = addData()
        chart.leftAxis.labelCount = guides
        chart.leftAxis.axisMinimum = 0
        chart.leftAxis.axisMaximum = max
        chart.rightAxis.labelCount = guides
        chart.rightAxis.axisMinimum = 0
        chart.rightAxis.axisMaximum = max
        chart.rightAxis.enabled = true
        chart.legend.enabled = false
        chart.xAxis.granularity = 1000
        chart.drawMarkers = false
        chart.highlightPerTapEnabled = false
        chart.isUserInteractionEnabled = false
        chart.leftAxis.labelFont = .systemFont(ofSize: 0)
        chart.rightAxis.labelFont = .systemFont(ofSize: 0)
        chart.xAxis.labelFont = .systemFont(ofSize: 0)
        
        return chart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData()
    }
    
    func addData() -> LineChartData{
        let data = LineChartData()
        
        for i in 0...(entries.count-1) {
            let dataSet = LineChartDataSet(entries[i])
            dataSet.colors = [color[i]]
            dataSet.lineWidth = 2
            dataSet.circleRadius = 0
            dataSet.valueFont = UIFont.systemFont(ofSize: 0)
            data.addDataSet(dataSet)
        }
        
        if showMidBar {
            let n = entries[0].count - 1
            let bar = makeVerticalLine(x: (CGFloat(n)/2.0)-1.0)
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
