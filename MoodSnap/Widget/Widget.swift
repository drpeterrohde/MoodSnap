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
        //WidgetCenter.shared.reloadAllTimelines()
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
    var type: WidgetTypeEnum
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {
        let timescaleAll = getTimescale(timescale: TimeScaleEnum.all.rawValue,
                                        moodSnaps: data.moodSnaps)
        ZStack {
            switch type {
            case .moodHistoryLargeAll:
                MoodHistoryBarView(timescale: timescaleAll)
                    .padding([.top, .bottom, .leading, .trailing], 10)
            case .moodHistoryLargeNinety:
                MoodHistoryBarView(timescale: TimeScaleEnum.threeMonths.rawValue)
                    .padding([.top, .bottom, .leading, .trailing], 10)
            case .movingAverageMediumAll:
                SlidingAverageView(timescale: timescaleAll)
                    .padding([.top, .bottom, .leading, .trailing], 10)
            case .movingAverageMediumNinety:
                SlidingAverageView(timescale: TimeScaleEnum.threeMonths.rawValue)
                    .padding([.top, .bottom, .leading, .trailing], 10)
            case .movingAverageSmallThirty:
                SlidingAverageView(timescale: TimeScaleEnum.month.rawValue)
                    .padding([.top, .bottom, .leading, .trailing], 10)
            }
        }
    }
}

struct WidgetsMoodHistoryLargeAll: Widget {
    let kind: String = "Mood history large all"
    let data: DataStoreClass = DataStoreClass(shared: true, process: false)
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: ConfigurationIntent.self,
                            provider: Provider()) { entry in
            WidgetsEntryView(entry: entry, type: .moodHistoryLargeAll)
                .environmentObject(data)
        }
                            .configurationDisplayName("mood_history")
                            .description("all_data")
                            .supportedFamilies([.systemLarge])
    }
}

struct WidgetsMoodHistoryLargeNinety: Widget {
    let kind: String = "Mood history large ninety"
    let data: DataStoreClass = DataStoreClass(shared: true, process: false)
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: ConfigurationIntent.self,
                            provider: Provider()) { entry in
            WidgetsEntryView(entry: entry, type: .moodHistoryLargeNinety)
                .environmentObject(data)
        }
                            .configurationDisplayName("mood_history")
                            .description("90_day_trend")
                            .supportedFamilies([.systemLarge])
    }
}

struct WidgetsMovingAverageMediumAll: Widget {
    let kind: String = "Moving average medium all"
    let data: DataStoreClass = DataStoreClass(shared: true, process: false)
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: ConfigurationIntent.self,
                            provider: Provider()) { entry in
            WidgetsEntryView(entry: entry, type: .movingAverageMediumAll)
                .environmentObject(data)
        }
                            .configurationDisplayName("moving_average")
                            .description("all_data")
                            .supportedFamilies([.systemMedium])
    }
}

struct WidgetsMovingAverageMediumNinety: Widget {
    let kind: String = "Moving average medium ninety"
    let data: DataStoreClass = DataStoreClass(shared: true, process: false)
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: ConfigurationIntent.self,
                            provider: Provider()) { entry in
            WidgetsEntryView(entry: entry, type: .movingAverageMediumNinety)
                .environmentObject(data)
        }
                            .configurationDisplayName("moving_average")
                            .description("90_day_trend")
                            .supportedFamilies([.systemMedium])
    }
}

struct WidgetsMovingAverageSmallThirty: Widget {
    let kind: String = "Moving average small thirty"
    let data: DataStoreClass = DataStoreClass(shared: true, process: false)
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: ConfigurationIntent.self,
                            provider: Provider()) { entry in
            WidgetsEntryView(entry: entry, type: .movingAverageSmallThirty)
                .environmentObject(data)
        }
                            .configurationDisplayName("moving_average")
                            .description("30_day_trend")
                            .supportedFamilies([.systemSmall])
    }
}
