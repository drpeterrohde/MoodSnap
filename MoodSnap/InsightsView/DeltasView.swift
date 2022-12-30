import SwiftUI

/**
 View for displaying an occurences summary.
 */
struct DeltasView: View {
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {
        // Activities
        Group {
            Divider()
            Label("activity", systemImage: "figure.walk")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    ForEach(0 ..< activityList.count, id: \.self) { i in
                        if data.settings.activityVisibility[i] {
                            Text(.init(activityList[i])).font(.caption) + Text("  ").font(.caption)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    ForEach(0 ..< data.processedData.activityButterfly[0].deltas!.beforeActivities.count, id: \.self) { i in
                        if data.settings.activityVisibility[i] {
                            Text(String(data.processedData.activityButterfly[0].deltas!.beforeActivities[i]))
                                .font(numericFont)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    ForEach(0 ..< data.processedData.activityButterfly[0].deltas!.afterActivities.count, id: \.self) { i in
                        if data.settings.activityVisibility[i] {
                            Text(String(data.processedData.activityButterfly[0].deltas!.afterActivities[i]))
                                .font(numericFont)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    ForEach(0 ..< data.processedData.activityButterfly[0].deltas!.deltaActivities.count, id: \.self) { i in
                        if data.settings.activityVisibility[i] {
                            Text(String(data.processedData.activityButterfly[0].deltas!.deltaActivities[i]))
                                .font(numericFont)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
