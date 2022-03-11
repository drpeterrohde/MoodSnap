import SwiftUI
import HealthKitUI

func fetchHealthData(date: Date) -> CGFloat {
    var returnValue: CGFloat = 0
    let healthStore = HKHealthStore()
    if HKHealthStore.isHealthDataAvailable() {
        let readData = Set([HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!])
        healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
            if success {
                guard let type = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
                    fatalError("Something went wrong")
                }
                let cal = Calendar(identifier: Calendar.Identifier.gregorian)
                let newDate = cal.startOfDay(for: date)
                let predicate = HKQuery.predicateForSamples(withStart: newDate, end: date, options: .strictStartDate)
                
                let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { (query, statistics, error) in
                    var value: CGFloat = 0
                    if error != nil {
                        print("Something went wrong")
                    } else if let quantity = statistics?.sumQuantity() {
                        value = quantity.doubleValue(for: HKUnit.mile())
                    }
                    DispatchQueue.main.async {
                        returnValue = value
                    }
                }
                
                healthStore.execute(query)
            } else {
                print("Authorization failed")
            }
        }
    } else {
        print("No HealthKit data available")
    }
    
    return returnValue
}
