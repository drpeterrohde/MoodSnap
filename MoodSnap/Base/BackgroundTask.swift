import SwiftUI
import BackgroundTasks
    
func scheduleAppRefresh() {
    let request = BGAppRefreshTaskRequest(identifier: "moodSnapRefresh")
    request.earliestBeginDate = .now
    try? BGTaskScheduler.shared.submit(request)
}

func backgroundProcess(data: DataStoreClass) async {
    print("background running")
    await data.process()
    print("background complete")
}

