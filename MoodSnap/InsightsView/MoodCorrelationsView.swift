import SwiftUI

/**
 View for displaying correlations between mood levels.
 */
struct MoodCorrelationsView: View {
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        HStack {
            VStack {
                Text(" ").font(.caption)
                Text("E").font(.caption).foregroundColor(themes[data.settings.theme].elevationColor)
                Text("D").font(.caption).foregroundColor(themes[data.settings.theme].depressionColor)
                Text("A").font(.caption).foregroundColor(themes[data.settings.theme].anxietyColor)
                Text("I").font(.caption).foregroundColor(themes[data.settings.theme].irritabilityColor)
            }
            VStack {
                Text("E").font(.caption).foregroundColor(themes[data.settings.theme].elevationColor)
                Text(formatCorrelationString(value: data.correlations.correlationEE)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationDE)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationAE)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationIE)).font(numericFont)
            }
            VStack {
                Text("D").font(.caption).foregroundColor(themes[data.settings.theme].depressionColor)
                Text(formatCorrelationString(value: data.correlations.correlationED)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationDD)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationAD)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationID)).font(numericFont)
            }
            VStack {
                Text("A").font(.caption).foregroundColor(themes[data.settings.theme].anxietyColor)
                Text(formatCorrelationString(value: data.correlations.correlationEA)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationDA)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationAA)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationIA)).font(numericFont)
            }
            VStack {
                Text("I").font(.caption).foregroundColor(themes[data.settings.theme].irritabilityColor)
                Text(formatCorrelationString(value: data.correlations.correlationEI)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationDI)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationAI)).font(numericFont)
                Text(formatCorrelationString(value: data.correlations.correlationII)).font(numericFont)
            }
        }
    }
}
