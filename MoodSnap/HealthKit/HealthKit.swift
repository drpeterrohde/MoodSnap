import HealthKit
import SwiftUI

class HealthManager: ObservableObject {
    public var healthSnaps: [HealthSnapStruct] = []
    public let healthStore = HKHealthStore()

    public func requestPermissions() {
        let readDataTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
                                  HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
                                  HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
                                  HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.menstrualFlow)!,
                                  HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!]

        healthStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: { success, error in
            if success {
                print("Authorization complete")
            } else {
                print("Authorization error: \(String(describing: error?.localizedDescription))")
            }
        })
    }

    func makeHealthSnaps(data: DataStoreClass) {
        var date: Date = getLastDate(moodSnaps: data.moodSnaps)
        let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)

        healthSnaps = []

        while date >= earliest {
            makeHealthSnapForDate(date: date)
            date = date.addDays(days: -1)
        }
    }

    func makeHealthSnapForDate(date: Date) {
        let startDate = date.startOfDay()
        let endDate = date.endOfDay()

        let quantityTypeWeight = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let quantityTypeDistance = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        let quantityTypeActiveEnergy = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let quantityTypeMenstrual = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.menstrualFlow)!
        let quantityTypeSleep = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!

        let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                    end: endDate,
                                                    options: .strictStartDate)

        let sampleQueryWeight = HKSampleQuery(sampleType: quantityTypeWeight,
                                              predicate: predicate,
                                              limit: HKObjectQueryNoLimit,
                                              sortDescriptors: nil,
                                              resultsHandler: { _, results, _ in
                                                  DispatchQueue.main.async {
                                                      let maxWeight = self.maxWeight(results: results)
                                                      if maxWeight != nil {
                                                          var healthSnap = HealthSnapStruct()
                                                          healthSnap.timestamp = date
                                                          healthSnap.weight = CGFloat(maxWeight!)
                                                          self.healthSnaps.append(healthSnap)
                                                      }
                                                  }
                                              })

        let sampleQueryDistance = HKSampleQuery(sampleType: quantityTypeDistance,
                                                predicate: predicate,
                                                limit: HKObjectQueryNoLimit,
                                                sortDescriptors: nil,
                                                resultsHandler: { _, results, _ in
                                                    DispatchQueue.main.async {
                                                        let distance = self.totalDistance(results: results)
                                                        if distance != nil {
                                                            var healthSnap = HealthSnapStruct()
                                                            healthSnap.timestamp = date
                                                            healthSnap.walkingRunningDistance = CGFloat(distance!)
                                                            self.healthSnaps.append(healthSnap)
                                                        }
                                                    }
                                                })

        let sampleQueryActiveEnergy = HKSampleQuery(sampleType: quantityTypeActiveEnergy,
                                                    predicate: predicate,
                                                    limit: HKObjectQueryNoLimit,
                                                    sortDescriptors: nil,
                                                    resultsHandler: { _, results, _ in
                                                        DispatchQueue.main.async {
                                                            let energy = self.totalEnergy(results: results)
                                                            if energy != nil {
                                                                var healthSnap = HealthSnapStruct()
                                                                healthSnap.timestamp = date
                                                                healthSnap.activeEnergy = CGFloat(energy!)
                                                                self.healthSnaps.append(healthSnap)
                                                            }
                                                        }
                                                    })

        let sampleQueryMenstrual = HKSampleQuery(sampleType: quantityTypeMenstrual,
                                                 predicate: predicate,
                                                 limit: HKObjectQueryNoLimit,
                                                 sortDescriptors: nil,
                                                 resultsHandler: { _, results, _ in
                                                     DispatchQueue.main.async {
                                                         let menstrual = self.maxMenstrual(results: results)
                                                         if menstrual != nil {
                                                             var healthSnap = HealthSnapStruct()
                                                             healthSnap.timestamp = date
                                                             healthSnap.menstrual = CGFloat(menstrual!)
                                                             if healthSnap.menstrual != 0 {
                                                                 self.healthSnaps.append(healthSnap)
                                                             }
                                                         }
                                                     }
                                                 })

        let sampleQuerySleep = HKSampleQuery(sampleType: quantityTypeSleep,
                                             predicate: predicate,
                                             limit: HKObjectQueryNoLimit,
                                             sortDescriptors: nil,
                                             resultsHandler: { _, results, _ in
                                                 DispatchQueue.main.async {
                                                     let sleep = self.totalSleep(results: results)
                                                     if sleep != nil {
                                                         var healthSnap = HealthSnapStruct()
                                                         healthSnap.timestamp = date
                                                         healthSnap.sleepHours = CGFloat(sleep!)
                                                         self.healthSnaps.append(healthSnap)
                                                     }
                                                 }
                                             })

        healthStore.execute(sampleQueryWeight)
        healthStore.execute(sampleQueryDistance)
        healthStore.execute(sampleQueryActiveEnergy)
        healthStore.execute(sampleQueryMenstrual)
        healthStore.execute(sampleQuerySleep)
    }

    /**
     Maximum weight for given HealthKit `results`
     */
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

    /**
     Total sleep for given HealthKit `results`
     */
    func totalSleep(results: [HKSample]?) -> Double? {
        if results == nil {
            return nil
        }

        if results!.count == 0 {
            return nil
        }

        var sleep: Double = 0.0

        for result in results! {
            let thisSleepSample = result as! HKCategorySample
            if thisSleepSample.value == HKCategoryValueSleepAnalysis.inBed.rawValue {
                let endDate = thisSleepSample.endDate
                let startDate = thisSleepSample.startDate
                let timeInterval = endDate.timeIntervalSince(startDate) / (60 * 60)
                sleep += Double(timeInterval)
            }
        }

        return sleep
    }

    /**
     Total distance for given HealthKit `results`
     */
    func totalDistance(results: [HKSample]?) -> Double? {
        if results == nil {
            return nil
        }

        if results!.count == 0 {
            return nil
        }

        var distance: Double = 0.0

        for result in results! {
            let thisDistanceSample = result as! HKQuantitySample
            distance += thisDistanceSample.quantity.doubleValue(for: HKUnit.meterUnit(with: .kilo))
        }

        return distance
    }

    /**
     Total active energy for given HealthKit `results`
     */
    func totalEnergy(results: [HKSample]?) -> Double? {
        if results == nil {
            return nil
        }

        if results!.count == 0 {
            return nil
        }

        var energy: Double = 0.0

        for result in results! {
            let thisEnergySample = result as! HKQuantitySample
            energy += thisEnergySample.quantity.doubleValue(for: HKUnit.jouleUnit(with: .kilo))
        }

        return energy
    }

    /**
     Maximum menstrual flow for given HealthKit `results`
     */
    func maxMenstrual(results: [HKSample]?) -> Double? {
        if results == nil {
            return nil
        }

        var flow = 0

        for result in results! {
            let thisMenstrualSample = result as! HKCategorySample

            if Int(thisMenstrualSample.value) != HKCategoryValueMenstrualFlow.none.rawValue {
                flow = thisMenstrualSample.value
            }
        }

        return Double(flow)
    }
}
