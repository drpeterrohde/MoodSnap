import SwiftUI

struct MenstrualView: View {
    var timescale: Int
    var data: DataStoreStruct
    var health: HealthManager 

    var body: some View {
        let samples: Int = countHealthSnaps(healthSnaps: health.healthSnaps, type: .menstrual)
       // let average: CGFloat = average(healthSnaps: health.healthSnaps, type: .menstrual) ?? 0.0
        //let averageStr: String = String(format: "%.1f", average) + "kg"
       // let r2mood: [CGFloat?] = getCorrelation(data: data, health: health, type: .menstrual)
        let weightData: [CGFloat?] = getMenstrualData(data: data, health: health)
        // let entries = makeBarData(y: weightData, timescale: timescale)
        let entries2 = makeBarData2(y: weightData, timescale: timescale)
        
        let entriesE2 = makeBarData2(y: data.processedData.levelE, timescale: timescale)
        let entriesD2 = makeBarData2(y: data.processedData.levelD, timescale: timescale)
        let entriesA2 = makeBarData2(y: data.processedData.levelA, timescale: timescale)
        let entriesI2 = makeBarData2(y: data.processedData.levelI, timescale: timescale)

       // let entries = [entriesE, entriesD, entriesA, entriesI]
        let color = moodUIColors(settings: data.settings)

        if samples == 0 {//|| r2mood[0] == nil || r2mood[1] == nil || r2mood[2] == nil || r2mood[3] == nil {
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            ZStack {
                VerticalBarChartOpacity2(values: entries2,
                                  color: themes[data.settings.theme].buttonColor,
                                  min: 0,
                                  max: 1,
                                  shaded: true,
                                  settings: data.settings)
                    .frame(height: 60)
                BorderlessLineChart2(data: [entriesE2, entriesD2, entriesA2, entriesI2],
                                     color: [Color(color[0]), Color(color[1]), Color(color[2]), Color(color[3])])
                    .frame(height: 60)
            }
        }
    }
}
