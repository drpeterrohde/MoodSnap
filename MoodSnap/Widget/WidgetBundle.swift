import WidgetKit
import SwiftUI

@main
struct WidgetsBundle: WidgetBundle {
    var body: some Widget {
        WidgetsMovingAverageSmallThirty()
        WidgetsMovingAverageMediumNinety()
        WidgetsMovingAverageMediumAll()
        WidgetsMoodHistoryLargeNinety()
        WidgetsMoodHistoryLargeAll()
    }
}
