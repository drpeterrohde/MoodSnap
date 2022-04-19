import HealthKit
import SwiftUI

class HealthManager {
    public var healthSnaps: [HealthSnapStruct] = []

    public let healthStore = HKHealthStore()

    public func requestPermissions() {
        let readDataTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!]

        healthStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: { success, error in
            if success {
                print("Authorization complete")
                //  return true
                // self.fetchWeightData()
            } else {
                print("Authorization error: \(String(describing: error?.localizedDescription))")
                // return false
            }
        })
    }

    func makeHealthSnapsForDates(startDate: Date, endDate: Date) {
        var thisDate = startDate.startOfDay()
        while thisDate <= endDate {
            makeHealthSnapForDate(date: thisDate)
            thisDate = thisDate.addDays(days: 1)
        }
    }
    
    func makeHealthSnapForDate(date: Date) {
        print("Fetching data")
        let startDate = date.startOfDay()
        let endDate = date.addDays(days: 1).startOfDay()

        let quantityType: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!]

        let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                    end: endDate,
                                                    options: .strictStartDate)

        let sampleQuery = HKSampleQuery(sampleType: quantityType.first!,
                                        predicate: predicate,
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: nil,
                                        resultsHandler: { _, results, _ in
                                            DispatchQueue.main.async(execute: {
                                                let maxWeight = self.maxWeight(results: results)
                                                if maxWeight != nil {
                                                    var healthSnap = HealthSnapStruct()
                                                    healthSnap.timestamp = date
                                                    healthSnap.weight = CGFloat(maxWeight!)
                                                    self.healthSnaps.append(healthSnap)
                                                    print("HealthSnap", healthSnap)
                                                }
                                            })
                                        })

        healthStore.execute(sampleQuery)
    }

    func maxWeight(results: [HKSample]?) -> Double? {
        if results == nil {
            return nil
        }

        if results!.count == 0 {
            return nil
        }
        
        var maxKg: Double = 0

        for result in results! {
            let thisMassSample = result as! HKQuantitySample
            let thisMassKg = thisMassSample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            maxKg = max(maxKg, thisMassKg)
        }

        return maxKg
    }
}
