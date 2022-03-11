import SwiftUI
import Charts

struct ScatterChart : UIViewRepresentable {
    var entries : [ChartDataEntry]
    
    func makeUIView(context: Context) -> ScatterChartView {
        let chart = ScatterChartView()
        chart.data = addData()
        chart.leftAxis.labelCount = 4
        chart.leftAxis.axisMinimum = 0
        chart.leftAxis.axisMaximum = 4
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.xAxis.granularity = 1
        
        return chart
    }
    
    func updateUIView(_ uiView: ScatterChartView, context: Context) {
        uiView.data = addData()
    }
    
    func addData() -> ChartData {
        let data = ScatterChartData()
        let dataSet = ScatterChartDataSet(entries: entries)
        dataSet.colors = [NSUIColor.green]
        dataSet.setScatterShape(.circle)
        dataSet.valueFont = UIFont.systemFont(ofSize: 0)
        dataSet.scatterShapeSize = 8
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = ScatterChartView
}
