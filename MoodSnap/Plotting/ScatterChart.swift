import SwiftUI
import Charts

struct ScatterChart : UIViewRepresentable {
    var entries : [ChartDataEntry]
    var color: UIColor
    var zeroOrigin: Bool = false
    
    func makeUIView(context: Context) -> ScatterChartView {
        let chart = ScatterChartView()
        chart.data = addData()
        chart.leftAxis.labelCount = 4
        chart.leftAxis.axisMinimum = 0
        chart.leftAxis.axisMaximum = 4
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.xAxis.granularity = 1
        if zeroOrigin {
            chart.xAxis.axisMinimum = 0
        }
        chart.highlightPerTapEnabled = false
        chart.isUserInteractionEnabled = false
        
        return chart
    }
    
    func updateUIView(_ uiView: ScatterChartView, context: Context) {
        uiView.data = addData()
    }
    
    func addData() -> ChartData {
        let data = ScatterChartData()
        let dataSet = ScatterChartDataSet(entries: entries)
        dataSet.colors = [color]
        dataSet.setScatterShape(.circle)
        dataSet.valueFont = UIFont.systemFont(ofSize: 0)
        dataSet.scatterShapeSize = 8
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = ScatterChartView
}
