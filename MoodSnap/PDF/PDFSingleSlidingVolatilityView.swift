import SwiftUI

struct PDFSingleSlidingVolatilityView: View {
    var type: MoodsEnum
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    var blackAndWhite: Bool
    
    var body: some View {
        let entries = [Array(data.processedData.volatilityE.suffix(timescale)),
                       Array(data.processedData.volatilityD.suffix(timescale)),
                       Array(data.processedData.volatilityA.suffix(timescale)),
                       Array(data.processedData.volatilityI.suffix(timescale))]
        
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
                             blackAndWhite: false,
                             shaded: true,
                             settings: data.settings)
            .frame(height: 65)
        }
    }
}
