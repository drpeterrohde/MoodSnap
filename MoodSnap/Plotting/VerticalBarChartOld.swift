import Charts
import SwiftUI

/**
 View with vertical bar chart.
 */
struct VerticalBarChartOld: UIViewRepresentable {
    var entries: [BarChartDataEntry]
    var color: NSUIColor
    var settings: SettingsStruct
    var shaded: Bool = true
    var min: CGFloat = 0
    var max: CGFloat = 4
    var labelCount: Int = 4

    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.data = addData()
        chart.drawBarShadowEnabled = false
        chart.drawValueAboveBarEnabled = false
        chart.leftAxis.labelCount = labelCount
        chart.leftAxis.axisMinimum = min
        chart.leftAxis.axisMaximum = max
        chart.leftAxis.enabled = true
        chart.leftAxis.labelTextColor = UIColor(Color.secondary)
        chart.rightAxis.labelCount = labelCount
        chart.rightAxis.axisMinimum = min
        chart.rightAxis.axisMaximum = max
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

    func addData() -> BarChartData {
        let data = BarChartData()
        let dataSet = BarChartDataSet(entries: entries)

        // Color transparency scheme
        var colors: [NSUIColor] = []
        for item in entries {
            if shaded {
                let thisColor = NSUIColor(Color(color).opacity((item.y + themes[settings.theme].barShadeOffset) / (themes[settings.theme].barShadeOffset + 4.0)))
                colors.append(thisColor)
            } else {
                let thisColor = color
                colors.append(thisColor)
            }

        }

        dataSet.colors = colors
        dataSet.valueFont = UIFont.systemFont(ofSize: 0)
        data.addDataSet(dataSet)
        return data
    }

    typealias UIViewType = BarChartView
}
