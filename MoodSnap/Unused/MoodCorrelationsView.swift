//import SwiftUI
//
///**
// View for displaying correlations between mood levels.
// */
//struct MoodCorrelationsView: View {
//    @EnvironmentObject var data: DataStoreClass
//
//    var body: some View {
//        let correlationEE = pearson(dataX: data.processedData.levelE, dataY: data.processedData.levelE)
//        let correlationED = pearson(dataX: data.processedData.levelE, dataY: data.processedData.levelD)
//        let correlationEA = pearson(dataX: data.processedData.levelE, dataY: data.processedData.levelA)
//        let correlationEI = pearson(dataX: data.processedData.levelE, dataY: data.processedData.levelI)
//
//        let correlationDE = pearson(dataX: data.processedData.levelD, dataY: data.processedData.levelE)
//        let correlationDD = pearson(dataX: data.processedData.levelD, dataY: data.processedData.levelD)
//        let correlationDA = pearson(dataX: data.processedData.levelD, dataY: data.processedData.levelA)
//        let correlationDI = pearson(dataX: data.processedData.levelD, dataY: data.processedData.levelI)
//
//        let correlationAE = pearson(dataX: data.processedData.levelA, dataY: data.processedData.levelE)
//        let correlationAD = pearson(dataX: data.processedData.levelA, dataY: data.processedData.levelD)
//        let correlationAA = pearson(dataX: data.processedData.levelA, dataY: data.processedData.levelA)
//        let correlationAI = pearson(dataX: data.processedData.levelA, dataY: data.processedData.levelI)
//
//        let correlationIE = pearson(dataX: data.processedData.levelI, dataY: data.processedData.levelE)
//        let correlationID = pearson(dataX: data.processedData.levelI, dataY: data.processedData.levelD)
//        let correlationIA = pearson(dataX: data.processedData.levelI, dataY: data.processedData.levelA)
//        let correlationII = pearson(dataX: data.processedData.levelI, dataY: data.processedData.levelI)
//
//        HStack {
//            VStack {
//                Text(" ").font(.caption)
//                Text("E").font(.caption).foregroundColor(themes[data.settings.theme].elevationColor)
//                Text("D").font(.caption).foregroundColor(themes[data.settings.theme].depressionColor)
//                Text("A").font(.caption).foregroundColor(themes[data.settings.theme].anxietyColor)
//                Text("I").font(.caption).foregroundColor(themes[data.settings.theme].irritabilityColor)
//            }
//            VStack {
//                Text("E").font(.caption).foregroundColor(themes[data.settings.theme].elevationColor)
//                Text(formatCorrelationString(value: correlationEE)).font(numericFont)
//                Text(formatCorrelationString(value: correlationDE)).font(numericFont)
//                Text(formatCorrelationString(value: correlationAE)).font(numericFont)
//                Text(formatCorrelationString(value: correlationIE)).font(numericFont)
//            }
//            VStack {
//                Text("D").font(.caption).foregroundColor(themes[data.settings.theme].depressionColor)
//                Text(formatCorrelationString(value: correlationED)).font(numericFont)
//                Text(formatCorrelationString(value: correlationDD)).font(numericFont)
//                Text(formatCorrelationString(value: correlationAD)).font(numericFont)
//                Text(formatCorrelationString(value: correlationID)).font(numericFont)
//            }
//            VStack {
//                Text("A").font(.caption).foregroundColor(themes[data.settings.theme].anxietyColor)
//                Text(formatCorrelationString(value: correlationEA)).font(numericFont)
//                Text(formatCorrelationString(value: correlationDA)).font(numericFont)
//                Text(formatCorrelationString(value: correlationAA)).font(numericFont)
//                Text(formatCorrelationString(value: correlationIA)).font(numericFont)
//            }
//            VStack {
//                Text("I").font(.caption).foregroundColor(themes[data.settings.theme].irritabilityColor)
//                Text(formatCorrelationString(value: correlationEI)).font(numericFont)
//                Text(formatCorrelationString(value: correlationDI)).font(numericFont)
//                Text(formatCorrelationString(value: correlationAI)).font(numericFont)
//                Text(formatCorrelationString(value: correlationII)).font(numericFont)
//            }
//        }
//    }
//}
