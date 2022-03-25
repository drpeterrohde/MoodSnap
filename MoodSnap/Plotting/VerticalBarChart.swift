import SwiftUI
import Charts

struct VerticalBarChart : UIViewRepresentable {
    var entries : [BarChartDataEntry]
    var color: NSUIColor
    var settings: SettingsStruct
    
    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.data = addData()
        chart.drawBarShadowEnabled = false
        chart.drawValueAboveBarEnabled = false
        chart.leftAxis.labelCount = 4
        chart.leftAxis.axisMinimum = 0
        chart.leftAxis.axisMaximum = 4
        chart.leftAxis.enabled = true
        chart.leftAxis.labelTextColor = UIColor(Color.secondary)
        chart.rightAxis.labelCount = 4
        chart.rightAxis.axisMinimum = 0
        chart.rightAxis.axisMaximum = 4
        chart.rightAxis.enabled = true
        chart.legend.enabled = false
        chart.xAxis.granularity = 1000
        chart.drawBarShadowEnabled = false
        chart.drawValueAboveBarEnabled = false
        chart.fitBars = true
        chart.drawMarkers = false
        chart.highlightPerTapEnabled = false
        chart.isUserInteractionEnabled = false
        chart.maxVisibleCount = 10
        chart.xAxis.labelCount = 5
        chart.leftAxis.labelFont = .systemFont(ofSize: 0)
        chart.rightAxis.labelFont = .systemFont(ofSize: 0)
        chart.xAxis.labelFont = .systemFont(ofSize: 0)
        
        return chart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        uiView.data = addData()
    }
    
    func addData() -> BarChartData{
        let data = BarChartData()
        //data.barWidth = 0.9
        let dataSet = BarChartDataSet(entries: entries)
        
        // Color transparency scheme
        var colors: [NSUIColor] = []
        for item in entries {
            let thisColor = NSUIColor(Color(color).opacity((item.y+themes[settings.theme].barShadeOffset)/(themes[settings.theme].barShadeOffset + 4.0)))
            colors.append(thisColor)
        }
        
        dataSet.colors = colors
        dataSet.valueFont = UIFont.systemFont(ofSize: 0)
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = BarChartView
}