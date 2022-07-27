import SwiftUI

struct PDFSingleSlidingVolatilityView: View {
    var type: MoodsEnum
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool
    
    var body: some View {
        let entries = [Array(data.processedData.volatilityE.suffix(Int(monthInterval))),
                       Array(data.processedData.volatilityD.suffix(Int(monthInterval))),
                       Array(data.processedData.volatilityA.suffix(Int(monthInterval))),
                       Array(data.processedData.volatilityI.suffix(Int(monthInterval)))]
        
        if blackAndWhite {
            VerticalBarChart(values: entries[type.rawValue],
                             color: Color.black,
                             min: 0,
                             max: 4,
                             horizontalGridLines: 0,
                             verticalGridLines: 0,
                             blackAndWhite: true,
                             shaded: true,
                             settings: data.settings)
            .frame(height: 65)
        } else {
            let color = moodUIColors(settings: data.settings)[type.rawValue]
            VerticalBarChart(values: entries[type.rawValue],
                             color: Color(color),
                             min: 0,
                             max: 4,
                             horizontalGridLines: 0,
                             verticalGridLines: 0,
                             blackAndWhite: true,
                             shaded: true,
                             settings: data.settings)
            .frame(height: 65)
        }
    }
}
