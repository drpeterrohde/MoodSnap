import SwiftUI
import UserNotifications

/**
 Enable notifications.
 */
func toggleReminder(which: Int, settings: SettingsStruct) {
    if settings.reminderOn[which] {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
        }
    }
    updateNotifications(settings: settings)
}

/**
 Update reminder notifications.
 */
func updateNotifications(settings: SettingsStruct) {
    let center = UNUserNotificationCenter.current()
    center.removeAllPendingNotificationRequests()

    let times = [
        Calendar.current.dateComponents([.hour, .minute],
                                        from: settings.reminderTime[0]),
        Calendar.current.dateComponents([.hour, .minute],
                                        from: settings.reminderTime[1]),
    ]
    let triggers = [
        UNCalendarNotificationTrigger(dateMatching: times[0],
                                      repeats: true),
        UNCalendarNotificationTrigger(dateMatching: times[1],
                                      repeats: true),
    ]

    let content = UNMutableNotificationContent()
    content.title = "MoodSnap"
    content.body = "It's time to take a MoodSnap."
    content.sound = UNNotificationSound.default

    let requests = [
        UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggers[0]),
        UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggers[1]),
    ]

    if settings.reminderOn[0] { center.add(requests[0]) }
    if settings.reminderOn[1] { center.add(requests[1]) }
}
