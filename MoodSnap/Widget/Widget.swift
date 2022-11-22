import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),
                    configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),
                                configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let date = Date()
        let entry = SimpleEntry(date: date,
                                configuration: configuration)
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
        let timeline = Timeline(entries: [entry],
                                policy: .after(nextUpdateDate))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    var configuration: ConfigurationIntent
}

struct WidgetsEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        let timescale = getTimescale(timescale: TimeScaleEnum.all.rawValue,
                                     moodSnaps: data.moodSnaps)
        ZStack {
            if family == .systemLarge {
                MoodHistoryBarView(timescale: timescale)
                    .padding([.top, .bottom, .leading, .trailing], 10)
            }
            if family == .systemMedium {
                SlidingAverageView(timescale: timescale)
                    .padding([.top, .bottom, .leading, .trailing], 10)
            }
        }
    }
}

struct Widgets: Widget {
    let kind: String = "MoodSnap widgets"
    let data: DataStoreClass = DataStoreClass(shared: true, process: true)
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: ConfigurationIntent.self,
                            provider: Provider()) { entry in
            WidgetsEntryView(entry: entry)
                .environmentObject(data)
        }
        .configurationDisplayName("MoodSnap widget")
        .description("MoodSnap widget")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct Widgets_Previews: PreviewProvider {
    static var previews: some View {
        WidgetsEntryView(entry: SimpleEntry(date: Date(),
                                            configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
