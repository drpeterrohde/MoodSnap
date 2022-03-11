import SwiftUI
import Charts

struct ButterflyAverageView: View {
    //var entriesLevels: [[ChartDataEntry]]
    //var entriesVolatility: [[ChartDataEntry]]
    //var color: [NSUIColor]
    var timescale: TimeScaleEnum
    var data: DataStoreStruct
    @State private var selectedEvent: String = activityList[0]
    
    var body: some View {
        let samples = getFlattenedPaddedSamples(moodSnaps: data.moodSnaps)
        
        let dataE = samples[0]
        let dataD = samples[1]
        let dataA = samples[2]
        let dataI = samples[3]
        
        let dataLevelsButterflyE = butterflyAverage(data: dataE, center: 50, maxWindowSize: 40)!
        let dataLevelsButterflyD = butterflyAverage(data: dataD, center: 50, maxWindowSize: 40)!
        let dataLevelsButterflyA = butterflyAverage(data: dataA, center: 50, maxWindowSize: 40)!
        let dataLevelsButterflyI = butterflyAverage(data: dataI, center: 50, maxWindowSize: 40)!
        
        //        let dataVolatilityButterflyE = butterflyAverage(data: slidingVolE, center: 50, minWindowSize: 1, maxWindowSize: 40)
        //        let dataVolatilityButterflyD = butterflyAverage(data: slidingVolD, center: 50, minWindowSize: 1, maxWindowSize: 40)
        //        let dataVolatilityButterflyA = butterflyAverage(data: slidingVolA, center: 50, minWindowSize: 1, maxWindowSize: 40)
        //        let dataVolatilityButterflyI = butterflyAverage(data: slidingVolI, center: 50, minWindowSize: 1, maxWindowSize: 40)
        
        let entriesButterflyE = makeLineData(y: dataLevelsButterflyE)
        let entriesButterflyD = makeLineData(y: dataLevelsButterflyD)
        let entriesButterflyA = makeLineData(y: dataLevelsButterflyA)
        let entriesButterflyI = makeLineData(y: dataLevelsButterflyI)
        
        //        let entriesVolatilityButterflyE = makeLineData(y: dataVolatilityButterflyE)
        //        let entriesVolatilityButterflyD = makeLineData(y: dataVolatilityButterflyD)
        //        let entriesVolatilityButterflyA = makeLineData(y: dataVolatilityButterflyA)
        //        let entriesVolatilityButterflyI = makeLineData(y: dataVolatilityButterflyI)
        
        let entriesLevels = [entriesButterflyE, entriesButterflyD, entriesButterflyA, entriesButterflyI]
        let entriesVolatility = [entriesButterflyE, entriesButterflyD, entriesButterflyA, entriesButterflyI] // ??? CHANGE TO VOLATILITY
        
        let color = moodUIColors(settings: data.settings)
        
            VStack{
                if(entriesLevels[0].count == 0 && entriesVolatility[0].count == 0) {
                    Text("Insufficient data").foregroundColor(.primary)
                } else {
                    if (entriesLevels[0].count > 0) {
                    HStack(alignment: .center) {
                        Text("Levels").font(.caption)
                    }
                    MultipleLineChart(entries: entriesLevels, color: color, showMidBar: true, guides: 2)
                            .padding(.top, -15)
                }
                
                if (entriesVolatility[0].count > 0) {
                    HStack(alignment: .center) {
                        Text("Volatility").font(.caption)
                    }
                    MultipleLineChart(entries: entriesVolatility, color: color, showMidBar: true, guides: 2)
                        .padding(.top, -15)
                }
                
                Picker("", selection: $selectedEvent) {
                    let eventsList = getEventsList(moodSnaps: data.moodSnaps) 
//                    var eventStrings: [String] = []
//                    
//                    for event in eventsList {
//                        eventStrings.append("\(event.0) (\(calculateDate(date: event.1)))")
//                    }
                    
                    // Events
                    Section {
                        ForEach(0..<eventsList.count) {i in
                            Text("\(eventsList[i].0) (\(calculateDate(date: eventsList[i].1)))")
                        }
                    }
                    
                    // Social
                    Section {
                        ForEach(0..<socialList.count) {i in
                            if (data.settings.socialVisibility[i]) {
                                Text(socialList.reversed()[i])
                                    .tag(socialList.reversed()[i])
                            }
                        }
                    }
                    
                    // Activities
                    Section {
                        ForEach(0..<activityList.count) {i in
                            if (data.settings.activityVisibility[i]) {
                                Text(activityList.reversed()[i])
                                    .tag(activityList.reversed()[i])
                            }
                        }
                    }
                }
            }
        }.frame(height: 450)
    }
    
}
