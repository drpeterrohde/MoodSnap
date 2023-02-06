import SwiftUI
import StoreKit

struct StoreReviewHelper {
    static func incrementAppOpenedCount() {
        guard var appOpenCount = UserDefaults.standard.value(forKey: "APP_OPENED_COUNT") as? Int else {
            UserDefaults.standard.set(1, forKey: "APP_OPENED_COUNT")
            return
        }
        appOpenCount += 1
        UserDefaults.standard.set(appOpenCount, forKey: "APP_OPENED_COUNT")
    }
    
    static func checkAndAskForReview() {
        guard let appOpenCount = UserDefaults.standard.value(forKey: "APP_OPENED_COUNT") as? Int else {
            UserDefaults.standard.set(1, forKey: "APP_OPENED_COUNT")
            return
        }
        
        switch appOpenCount {
        case 20, 50, 100:
            StoreReviewHelper.requestReview()
        //case _ where appOpenCount % 100 == 0:
        //    StoreReviewHelper.requestReview()
        default:
            break
        }
    }
    
    static func requestReview() {
        //if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
//    static func requestAppStoreReview() {
//        let url = URL(string: "https://apps.apple.com/au/app/moodsnap-mood-diary/id1616291944?action=write-review")!
//        UIApplication.shared.open(url)
//    }
}
