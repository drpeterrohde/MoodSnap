import SwiftUI
import BackgroundTasks

func scheduleAppRefresh() {
    let request = BGAppRefreshTaskRequest(identifier: "moodsnaprefresh")
    request.earliestBeginDate = .now.addingTimeInterval(24 * 3600)
    try? BGTaskScheduler.shared.submit(request)
}
