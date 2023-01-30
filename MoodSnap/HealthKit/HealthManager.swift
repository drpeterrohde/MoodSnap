import HealthKit
import SwiftUI

final class HealthManager: ObservableObject {
    var healthSnaps: [HealthSnapStruct] = []
    
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
        
        healthStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: { success, error in })
    }
    
    /**
     Generate `HealthSnapStruct`s for all dates and start processing.
     */
    func makeHealthSnaps(data: DataStoreClass) async {
        self.stopProcessing(data: data)
        self.healthSnaps = []
        
        DispatchQueue.main.async {
            data.processingStatus.weight = true
            data.processingStatus.sleep = true
            data.processingStatus.energy = true
            data.processingStatus.distance = true
            data.processingStatus.menstrual = true
        }
        
        var date: Date = getLastDate(moodSnaps: data.moodSnaps)
        let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "thread-safe-array")
        
        while date >= earliest {
            await makeHealthSnapForDate(date: date, group: group, queue: queue)
            date = date.addDays(days: -1)
        }
        
        group.notify(queue: DispatchQueue.global()) {
            self.healthSnaps = sortByDate(healthSnaps: self.healthSnaps)
            data.healthSnaps = self.healthSnaps
            self.startProcessing(data: data)
        }
    }
    
    /**
     Generate `HealthSnapStruct`s for a given date.
     */
    @inline(__always) func makeHealthSnapForDate(date: Date, group: DispatchGroup, queue: DispatchQueue) async {
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
            let maxWeight = self.maxWeight(results: results)
            if maxWeight != nil {
                var healthSnap = HealthSnapStruct()
                healthSnap.timestamp = date
                healthSnap.weight = CGFloat(maxWeight!)
                let healthSnapUI = healthSnap
                queue.sync() {
                    self.healthSnaps.append(healthSnapUI)
                }
            }
            group.leave()
        })
        
        group.enter()
        let sampleQueryDistance = HKSampleQuery(sampleType: quantityTypeDistance,
                                                predicate: predicate,
                                                limit: HKObjectQueryNoLimit,
                                                sortDescriptors: nil,
                                                resultsHandler: { _, results, _ in
            let distance = self.totalDistance(results: results)
            if distance != nil {
                var healthSnap = HealthSnapStruct()
                healthSnap.timestamp = date
                healthSnap.walkingRunningDistance = CGFloat(distance!)
                let healthSnapUI = healthSnap
                queue.sync() {
                    self.healthSnaps.append(healthSnapUI)
                }
            }
            group.leave()
        })
        
        group.enter()
        let sampleQueryActiveEnergy = HKSampleQuery(sampleType: quantityTypeActiveEnergy,
                                                    predicate: predicate,
                                                    limit: HKObjectQueryNoLimit,
                                                    sortDescriptors: nil,
                                                    resultsHandler: { _, results, _ in
            let energy = self.totalEnergy(results: results)
            if energy != nil {
                var healthSnap = HealthSnapStruct()
                healthSnap.timestamp = date
                healthSnap.activeEnergy = CGFloat(energy!)
                let healthSnapUI = healthSnap
                queue.sync() {
                    self.healthSnaps.append(healthSnapUI)
                }
            }
            group.leave()
        })
        
        group.enter()
        let sampleQueryMenstrual = HKSampleQuery(sampleType: quantityTypeMenstrual,
                                                 predicate: predicate,
                                                 limit: HKObjectQueryNoLimit,
                                                 sortDescriptors: nil,
                                                 resultsHandler: { _, results, _ in
            let menstrual = self.maxMenstrual(results: results)
            if menstrual != nil {
                var healthSnap = HealthSnapStruct()
                healthSnap.timestamp = date
                healthSnap.menstrual = CGFloat(menstrual!)
                if healthSnap.menstrual != 0 {
                    let healthSnapUI = healthSnap
                    queue.sync() {
                        self.healthSnaps.append(healthSnapUI)
                    }
                }
            }
            group.leave()
        })
        
        group.enter()
        let sampleQuerySleep = HKSampleQuery(sampleType: quantityTypeSleep,
                                             predicate: predicate,
                                             limit: HKObjectQueryNoLimit,
                                             sortDescriptors: nil,
                                             resultsHandler: { _, results, _ in
            let sleep = self.totalSleep(results: results)
            if sleep != nil {
                var healthSnap = HealthSnapStruct()
                healthSnap.timestamp = date
                healthSnap.sleepHours = CGFloat(sleep!)
                let healthSnapUI = healthSnap
                queue.sync() {
                    self.healthSnaps.append(healthSnapUI)
                }
            }
            group.leave()
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
    @inline(__always) func maxWeight(results: [HKSample]?) -> Double? {
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
    @inline(__always) func totalSleep(results: [HKSample]?) -> Double? {
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
    @inline(__always) func totalDistance(results: [HKSample]?) -> Double? {
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
    @inline(__always) func totalEnergy(results: [HKSample]?) -> Double? {
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
    @inline(__always) func maxMenstrual(results: [HKSample]?) -> Double? {
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
     Process weight data.
     */
    func processWeight(data: DataStoreClass) async -> Bool {
        let moodSnaps = data.moodSnaps
        let healthSnaps = data.healthSnaps
        let units = data.settings.healthUnits
        
        let weightSamplesUI: Int = countHealthSnaps(healthSnaps: healthSnaps, type: .weight)
        let weightAverageUI: CGFloat = average(healthSnaps: healthSnaps, type: .weight) ?? 0.0
        let weightAverageStrUI: String = getWeightString(value: weightAverageUI, units: units)
        let weightCorrelationsMoodUI: [CGFloat?] = getCorrelation(moodSnaps: moodSnaps, healthSnaps: healthSnaps, type: .weight)
        let weightDataUI: [CGFloat?] = getWeightData(moodSnaps: moodSnaps, healthSnaps: healthSnaps)
        let minWeightUI: CGFloat = minWithNils(data: weightDataUI) ?? 0
        let maxWeightUI: CGFloat = maxWithNils(data: weightDataUI) ?? 0
        let minimumWeightStrUI: String = getWeightString(value: minWeightUI, units: units)
        let maximumWeightStrUI: String = getWeightString(value: maxWeightUI, units: units)
        
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
            data.processingStatus.weight = false
        }
        
        return true
    }
    
    /**
     Process sleep data
     */
    func processSleep(data: DataStoreClass) async -> Bool {
        let moodSnaps = data.moodSnaps
        let healthSnaps = data.healthSnaps
        
        let sleepSamplesUI: Int = countHealthSnaps(healthSnaps: healthSnaps, type: .sleep)
        let sleepAverageUI: CGFloat = average(healthSnaps: healthSnaps, type: .sleep) ?? 0.0
        let sleepAverageStrUI: String = String(format: "%.1f", sleepAverageUI) + "hrs"
        let sleepCorrelationsMoodUI: [CGFloat?] = getCorrelation(moodSnaps: moodSnaps, healthSnaps: healthSnaps, type: .sleep)
        let sleepDataUI: [CGFloat?] = getSleepData(moodSnaps: moodSnaps, healthSnaps: healthSnaps)
        let maxSleepUI: CGFloat = maxWithNils(data: sleepDataUI) ?? 0
        
        DispatchQueue.main.async {
            self.sleepSamples = sleepSamplesUI
            self.sleepAverage = sleepAverageUI
            self.sleepAverageStr = sleepAverageStrUI
            self.sleepCorrelationsMood = sleepCorrelationsMoodUI
            self.sleepData = sleepDataUI
            self.maxSleep = maxSleepUI
            data.processingStatus.sleep = false
        }
        
        return true
    }
    
    /**
     Process active energy data.
     */
    func processEnergy(data: DataStoreClass) async -> Bool {
        let moodSnaps = data.moodSnaps
        let healthSnaps = data.healthSnaps
        let units = data.settings.healthUnits
   
        let energySamplesUI: Int = countHealthSnaps(healthSnaps: healthSnaps, type: .energy)
        let energyAverageUI: CGFloat = average(healthSnaps: healthSnaps, type: .energy) ?? 0.0
        let energyAverageStrUI: String = getEnergyString(value: energyAverageUI, units: units)
        let energyDataUI: [CGFloat?] = getEnergyData(moodSnaps: moodSnaps, healthSnaps: healthSnaps)
        let energyCorrelationsMoodUI: [CGFloat?] = getCorrelation(moodSnaps: moodSnaps, healthSnaps: healthSnaps, type: .energy)
        let maxEnergyUI: CGFloat = maxWithNils(data: energyDataUI) ?? 0
        let maxEnergyStrUI: String = getEnergyString(value: maxEnergyUI, units: units)
        
        DispatchQueue.main.async {
            self.energySamples = energySamplesUI
            self.energyAverage = energyAverageUI
            self.energyAverageStr = energyAverageStrUI
            self.energyData = energyDataUI
            self.energyCorrelationsMood = energyCorrelationsMoodUI
            self.maxEnergy = maxEnergyUI
            self.maxEnergyStr = maxEnergyStrUI
            data.processingStatus.energy = false
        }
        
        return true
    }
    
    /**
     Process walking/running distance data.
     */
    func processDistance(data: DataStoreClass) async -> Bool {
        let moodSnaps = data.moodSnaps
        let healthSnaps = data.healthSnaps
        let units = data.settings.healthUnits
   
        let distanceSamplesUI: Int = countHealthSnaps(healthSnaps: healthSnaps, type: .distance)
        let distanceAverageUI: CGFloat = average(healthSnaps: healthSnaps, type: .distance) ?? 0.0
        let distanceAverageStrUI: String = getDistanceString(value: distanceAverageUI, units: units)
        let distanceDataUI: [CGFloat?] = getDistanceData(moodSnaps: moodSnaps, healthSnaps: healthSnaps)
        let distanceCorrelationsMoodUI: [CGFloat?] = getCorrelation(moodSnaps: moodSnaps, healthSnaps: healthSnaps, type: .distance)
        let maxDistanceUI: CGFloat = maxWithNils(data: distanceDataUI) ?? 0
        let maxDistanceStrUI: String = getDistanceString(value: maxDistanceUI, units: units)
        
        DispatchQueue.main.async {
            self.distanceSamples = distanceSamplesUI
            self.distanceAverage = distanceAverageUI
            self.distanceAverageStr = distanceAverageStrUI
            self.distanceData = distanceDataUI
            self.distanceCorrelationsMood = distanceCorrelationsMoodUI
            self.maxDistance = maxDistanceUI
            self.maxDistanceStr = maxDistanceStrUI
            data.processingStatus.distance = false
        }
        
        return true
    }
    
    /**
     Process menstrual data.
     */
    func processMenstrual(data: DataStoreClass) async -> Bool {
        let moodSnaps = data.moodSnaps
        let healthSnaps = data.healthSnaps
   
        let menstrualDataUI: [CGFloat?] = getMenstrualData(moodSnaps: moodSnaps, healthSnaps: healthSnaps)
        let menstrualDatesUI: [Date] = getMenstrualDates(healthSnaps: healthSnaps)
        let menstrualButterflyUI: ButterflyEntryStruct = averageTransientForDates(dates: menstrualDatesUI, data: data, maxWindow: menstrualTransientWindow)
        
        DispatchQueue.main.async {
            self.menstrualData = menstrualDataUI
            self.menstrualDates = menstrualDatesUI
            self.menstrualButterfly = menstrualButterflyUI
            data.processingStatus.menstrual = false
        }
        
        return true
    }
    
    /**
     Pre-process data.
     */
    func process(data: DataStoreClass) async {
        async let weightComplete = processWeight(data: data)
        async let sleepComplete = processSleep(data: data)
        async let energyComplete = processEnergy(data: data)
        async let distanceComplete = processDistance(data: data)
        async let processMenstrual = processMenstrual(data: data)
        
        await _ = [weightComplete, sleepComplete, energyComplete, distanceComplete, processMenstrual]
        
        DispatchQueue.main.async {
            data.processingStatus.health = nil
        }
    }
    
    /**
     Start asynchronous processing of data
     */
    @inline(__always) func startProcessing(priority: TaskPriority = .high, data: DataStoreClass) {
        self.stopProcessing(data: data)
        
        DispatchQueue.main.async {
            data.processingStatus.weight = true
            data.processingStatus.distance = true
            data.processingStatus.energy = true
            data.processingStatus.sleep = true
            data.processingStatus.menstrual = true
            data.processingStatus.health = Task(priority: priority) {
                await self.process(data: data)
            }
        }
    }
    
    /**
     Stop asynchronous processing of data.
     */
    @inline(__always) func stopProcessing(data: DataStoreClass) {
        if data.processingStatus.health != nil {
            data.processingStatus.health?.cancel()
        }
        DispatchQueue.main.async {
            data.processingStatus.health = nil
            data.processingStatus.weight = false
            data.processingStatus.distance = false
            data.processingStatus.energy = false
            data.processingStatus.sleep = false
            data.processingStatus.menstrual = false
        }
    }
}
