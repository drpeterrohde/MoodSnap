import SwiftUI
import Charts

struct HorizontalBarChart : UIViewRepresentable {
    var entries : [BarChartDataEntry]
    var settings: SettingsStruct
    
    func makeUIView(context: Context) -> BarChartView {
        let chart = HorizontalBarChartView()
        chart.data = addData()
        chart.drawBarShadowEnabled = false
        chart.drawValueAboveBarEnabled = false
        chart.leftAxis.labelCount = 4
        chart.leftAxis.axisMinimum = 0
        chart.leftAxis.axisMaximum = 4
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.xAxis.granularity = 1
        chart.drawBarShadowEnabled = false
        chart.drawValueAboveBarEnabled = false
        chart.drawGridBackgroundEnabled = false
        chart.drawMarkers = false
        chart.highlightPerTapEnabled = false
        chart.isUserInteractionEnabled = false
        
        return chart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        uiView.data = addData()
    }
    
    func addData() -> BarChartData {
        let data = BarChartData()
        data.barWidth = 0.8
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.colors = moodUIColors(settings: settings)
        dataSet.valueFont = UIFont.systemFont(ofSize: 0)
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = BarChartView
}
