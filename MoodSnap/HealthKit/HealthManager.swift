import HealthKit
import SwiftUI

final class HealthManager: ObservableObject {
    var healthSnaps: [HealthSnapStruct] = []
    @Published var processingTask: Task<Void, Never>? = nil
    
    @Published var weightSamples: Int = 0
    @Published var weightAverage: CGFloat = 0
    @Published var weightAverageStr: String = ""
    @Published var minimumWeightStr: String = ""
    @Published var maximumWeightStr: String = ""
    @Published var weightCorrelationsMood: [CGFloat?] = [nil, nil, nil, nil]
    @Published var weightData: [CGFloat?] = []
    @Published var minWeight: CGFloat = 0
    @Published var maxWeight: CGFloat = 0
    
    @Published var sleepSamples: Int = 0
    @Published var sleepAverage: CGFloat = 0
    @Published var sleepAverageStr: String = ""
    @Published var sleepCorrelationsMood: [CGFloat?] = [nil, nil, nil, nil]
    @Published var sleepData: [CGFloat?] = []
    @Published var maxSleep: CGFloat = 0
    
    @Published var energySamples: Int = 0
    @Published var energyAverage: CGFloat = 0
    @Published var energyAverageStr: String = ""
    @Published var energyData: [CGFloat?] = []
    @Published var energyCorrelationsMood: [CGFloat?] = [nil, nil, nil, nil]
    @Published var maxEnergy: CGFloat = 0
    @Published var maxEnergyStr: String = ""
    
    @Published var distanceSamples: Int = 0
    @Published var distanceAverage: CGFloat = 0
    @Published var distanceAverageStr: String = ""
    @Published var distanceData: [CGFloat?] = []
    @Published var distanceCorrelationsMood: [CGFloat?] = [nil, nil, nil, nil]
    @Published var maxDistance: CGFloat = 0
    @Published var maxDistanceStr: String = ""
    
    @Published var menstrualData: [CGFloat?] = []
    @Published var menstrualDates: [Date] = []
    @Published var menstrualButterfly: ButterflyEntryStruct = ButterflyEntryStruct()
    
    public let healthStore = HKHealthStore()

    public func requestPermissions() {
        let readDataTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
                                  HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
                                  HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
                                  HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.menstrualFlow)!,
                                  HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!]

        healthStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: { success, error in
            //            if success {
            //                print("Authorization complete")
            //            } else {
            //                print("Authorization error: \(String(describing: error?.localizedDescription))")
            //            }
        })
    }

    func makeHealthSnaps(data: DataStoreClass) {
        var date: Date = getLastDate(moodSnaps: data.moodSnaps)
        let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)

        self.healthSnaps = []

        let group = DispatchGroup()

        while date >= earliest {
            makeHealthSnapForDate(date: date, group: group)
            date = date.addDays(days: -1)
        }

        group.notify(queue: DispatchQueue.global()) {
            DispatchQueue.main.async {
                data.healthSnaps = self.healthSnaps
            }
            self.startProcessing(data: data)
        }
    }

    func makeHealthSnapForDate(date: Date, group: DispatchGroup) {
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

        group.enter()
        let sampleQueryWeight = HKSampleQuery(sampleType: quantityTypeWeight,
                                              predicate: predicate,
                                              limit: HKObjectQueryNoLimit,
                                              sortDescriptors: nil,
                                              resultsHandler: { _, results, _ in
            DispatchQueue.global(qos: .userInteractive).async {
                let maxWeight = self.maxWeight(results: results)
                if maxWeight != nil {
                    var healthSnap = HealthSnapStruct()
                    healthSnap.timestamp = date
                    healthSnap.weight = CGFloat(maxWeight!)
                    self.healthSnaps.append(healthSnap)
                }
                group.leave()
            }
        })

        group.enter()
        let sampleQueryDistance = HKSampleQuery(sampleType: quantityTypeDistance,
                                                predicate: predicate,
                                                limit: HKObjectQueryNoLimit,
                                                sortDescriptors: nil,
                                                resultsHandler: { _, results, _ in
            DispatchQueue.global(qos: .userInteractive).async {
                let distance = self.totalDistance(results: results)
                if distance != nil {
                    var healthSnap = HealthSnapStruct()
                    healthSnap.timestamp = date
                    healthSnap.walkingRunningDistance = CGFloat(distance!)
                    self.healthSnaps.append(healthSnap)
                }
                group.leave()
            }
        })

        group.enter()
        let sampleQueryActiveEnergy = HKSampleQuery(sampleType: quantityTypeActiveEnergy,
                                                    predicate: predicate,
                                                    limit: HKObjectQueryNoLimit,
                                                    sortDescriptors: nil,
                                                    resultsHandler: { _, results, _ in
            DispatchQueue.global(qos: .userInteractive).async {
                let energy = self.totalEnergy(results: results)
                if energy != nil {
                    var healthSnap = HealthSnapStruct()
                    healthSnap.timestamp = date
                    healthSnap.activeEnergy = CGFloat(energy!)
                    self.healthSnaps.append(healthSnap)
                }
                group.leave()
            }
        })

        group.enter()
        let sampleQueryMenstrual = HKSampleQuery(sampleType: quantityTypeMenstrual,
                                                 predicate: predicate,
                                                 limit: HKObjectQueryNoLimit,
                                                 sortDescriptors: nil,
                                                 resultsHandler: { _, results, _ in
            DispatchQueue.global(qos: .userInteractive).async {
                let menstrual = self.maxMenstrual(results: results)
                if menstrual != nil {
                    var healthSnap = HealthSnapStruct()
                    healthSnap.timestamp = date
                    healthSnap.menstrual = CGFloat(menstrual!)
                    if healthSnap.menstrual != 0 {
                        self.healthSnaps.append(healthSnap)
                    }
                }
                group.leave()
            }
        })

        group.enter()
        let sampleQuerySleep = HKSampleQuery(sampleType: quantityTypeSleep,
                                             predicate: predicate,
                                             limit: HKObjectQueryNoLimit,
                                             sortDescriptors: nil,
                                             resultsHandler: { _, results, _ in
            DispatchQueue.global(qos: .userInteractive).async {
                let sleep = self.totalSleep(results: results)
                if sleep != nil {
                    var healthSnap = HealthSnapStruct()
                    healthSnap.timestamp = date
                    healthSnap.sleepHours = CGFloat(sleep!)
                    self.healthSnaps.append(healthSnap)
                }
                group.leave()
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

    /**
     Pre-process data.
     */
    func process(data: DataStoreClass) async {
        // Weight
        let weightSamplesUI = countHealthSnaps(healthSnaps: self.healthSnaps, type: .weight)
        let weightAverageUI = average(healthSnaps: self.healthSnaps, type: .weight) ?? 0.0
        let weightAverageStrUI = getWeightString(value: weightAverageUI, units: data.settings.healthUnits)
        let weightCorrelationsMoodUI = getCorrelation(data: data, health: self, type: .weight)
        let weightDataUI = getWeightData(data: data, health: self)
        let minWeightUI = minWithNils(data: weightDataUI) ?? 0
        let maxWeightUI = maxWithNils(data: weightDataUI) ?? 0
        let minimumWeightStrUI = getWeightString(value: minWeightUI, units: data.settings.healthUnits)
        let maximumWeightStrUI = getWeightString(value: maxWeightUI, units: data.settings.healthUnits)

        // Sleep
        let sleepSamplesUI = countHealthSnaps(healthSnaps: self.healthSnaps, type: .sleep)
        let sleepAverageUI = average(healthSnaps: self.healthSnaps, type: .sleep) ?? 0.0
        let sleepAverageStrUI = String(format: "%.1f", sleepAverageUI) + "hrs"
        let sleepCorrelationsMoodUI = getCorrelation(data: data, health: self, type: .sleep)
        let sleepDataUI = getSleepData(data: data, health: self)
        let maxSleepUI = maxWithNils(data: sleepDataUI) ?? 0
        
        // Active energy
        let energySamplesUI = countHealthSnaps(healthSnaps: self.healthSnaps, type: .energy)
        let energyAverageUI = average(healthSnaps: self.healthSnaps, type: .energy) ?? 0.0
        let energyAverageStrUI = getEnergyString(value: energyAverageUI, units: data.settings.healthUnits)
        let energyDataUI = getEnergyData(data: data, health: self)
        let energyCorrelationsMoodUI = getCorrelation(data: data, health: self, type: .energy)
        let maxEnergyUI = maxWithNils(data: energyDataUI) ?? 0
        let maxEnergyStrUI = getEnergyString(value: maxEnergyUI, units: data.settings.healthUnits)

        // Walking & running distance
        let distanceSamplesUI = countHealthSnaps(healthSnaps: self.healthSnaps, type: .distance)
        let distanceAverageUI = average(healthSnaps: self.healthSnaps, type: .distance) ?? 0.0
        let distanceAverageStrUI = getDistanceString(value: distanceAverageUI, units: data.settings.healthUnits)
        let distanceDataUI = getDistanceData(data: data, health: self)
        let distanceCorrelationsMoodUI = getCorrelation(data: data, health: self, type: .distance)
        let maxDistanceUI = maxWithNils(data: distanceDataUI) ?? 0
        let maxDistanceStrUI = getDistanceString(value: maxDistanceUI, units: data.settings.healthUnits)
        
        // Menstrual
        let menstrualDataUI = getMenstrualData(data: data, health: self)
        let menstrualDatesUI = getMenstrualDates(healthSnaps: self.healthSnaps)
        let menstrualButterflyUI = averageMenstrualTransientForDates(dates: menstrualDatesUI, data: data, maxWindow: menstrualTransientWindow)
        
        DispatchQueue.main.async {
            self.weightSamples = weightSamplesUI
            self.weightAverage = weightAverageUI
            self.weightAverageStr = weightAverageStrUI
            self.weightCorrelationsMood = weightCorrelationsMoodUI
            self.weightData = weightDataUI
            self.minWeight = minWeightUI
            self.maxWeight = maxWeightUI
            self.minimumWeightStr = minimumWeightStrUI
            self.maximumWeightStr = maximumWeightStrUI
            
            self.sleepSamples = sleepSamplesUI
            self.sleepAverage = sleepAverageUI
            self.sleepAverageStr = sleepAverageStrUI
            self.sleepCorrelationsMood = sleepCorrelationsMoodUI
            self.sleepData = sleepDataUI
            self.maxSleep = maxSleepUI
            
            self.energySamples = energySamplesUI
            self.energyAverage = energyAverageUI
            self.energyAverageStr = energyAverageStrUI
            self.energyData = energyDataUI
            self.energyCorrelationsMood = energyCorrelationsMoodUI
            self.maxEnergy = maxEnergyUI
            self.maxEnergyStr = maxEnergyStrUI
            
            self.distanceSamples = distanceSamplesUI
            self.distanceAverage = distanceAverageUI
            self.distanceAverageStr = distanceAverageStrUI
            self.distanceData = distanceDataUI
            self.distanceCorrelationsMood = distanceCorrelationsMoodUI
            self.maxDistance = maxDistanceUI
            self.maxDistanceStr = maxDistanceStrUI
            
            self.menstrualData = menstrualDataUI
            self.menstrualDates = menstrualDatesUI
            self.menstrualButterfly = menstrualButterflyUI
        }
    }

    /**
     Start asynchronous processing of data
     */
    func startProcessing(priority: TaskPriority = .high, data: DataStoreClass) {
        if self.processingTask != nil {
            self.processingTask?.cancel()
        }

        DispatchQueue.main.async {
            self.processingTask = Task(priority: priority) {
                await self.process(data: data)
                DispatchQueue.main.async {
                    self.processingTask = nil
                }
            }
        }
    }
}
