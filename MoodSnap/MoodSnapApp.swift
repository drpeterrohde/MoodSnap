import Disk
import HealthKit
import HealthKitUI
import LocalAuthentication
import SwiftUI

@main
struct MoodSnapApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State private var data: DataStoreStruct = DataStoreStruct()
    @State private var health = HealthManager()
    @State private var isUnlocked = false

    var body: some Scene {
        WindowGroup {
            if !isUnlocked && data.settings.useFaceID {
                UnlockView(isUnlocked: $isUnlocked, data: $data)
            } else {
                ContentView(data: $data, health: $health)
                    .onAppear {
                        do {
                            let retrieved = try Disk.retrieve(
                                "data.json",
                                from: .documents,
                                as: DataStoreStruct.self)
                            data = retrieved
                        } catch {
                            print("Load failed")
                        }
                    }
            }
        }.onChange(of: scenePhase) { value in
            if value == .background {
                DispatchQueue.main.async {
                    isUnlocked = false
                    data.settings.firstUse = false
                    data.healthSnaps = health.healthSnaps
                    data.save() // add process???
                }
            }
            if value == .active {
                if HKHealthStore.isHealthDataAvailable() {
                    print("HealthKit is Available")
                    health.requestPermissions()
                    health.makeHealthSnaps(data: data)
                    data.healthSnaps = health.healthSnaps
                } else {
                    print("There is a problem accessing HealthKit")
                }
                DispatchQueue.global(qos: .userInteractive).async {
                    data.process()
                    data.save()
                }
            }
            if value == .inactive {
                DispatchQueue.main.async {
                    isUnlocked = false
                }
            }
        }
    }
}



//import SwiftUI
//
///**
// View for displaying mulptiple line chart.
// */
//struct BorderlessLineChart2: View {
//    var data: [[CGFloat?]]
//    var color: [Color]
//    var min: CGFloat
//    var max: CGFloat
//    var horizontalGridLines: Int = 0
//    var verticalGridLines: Int = 0
//    var blackAndWhite: Bool = false
//
//    private var fontColor: Color
//    private var lineColor: Color
//    private var gridColor: Color
//
//    init(data: [[CGFloat?]], color: [Color], min: CGFloat = 0.0, max: CGFloat = 4.0, horizontalGridLines: Int = 0, verticalGridLines: Int = 0, blackAndWhite: Bool = false) {
//        self.data = data
//        self.color = color
//        self.min = min
//        self.max = max
//        self.horizontalGridLines = horizontalGridLines
//        self.verticalGridLines = verticalGridLines
//        self.blackAndWhite = blackAndWhite
//
//        fontColor = Color.secondary
//        gridColor = Color.gray.opacity(0.3)
//        lineColor = Color.red
//
//        if blackAndWhite {
//            fontColor = Color.gray
//            self.color = [.black, .black, .black, .black]
//            gridColor = Color.gray
//        }
//    }
//
//    var body: some View {
//        GeometryReader { geometry in
//         //   let width = geometry.size.width
//          //  let spacing: CGFloat = chooseSpacing(values: data[0])
//            ZStack {
//                // Graph
//                ForEach(0 ..< data.count, id: \.self) { graph in
//                    Path { path in
//                        let thisData = data[graph]
//                       // let barWidth: CGFloat = [CGFloat(width) / CGFloat(data.count) - spacing, 1.0].max()!
//                        var first: Bool = true
//                        for i in 0 ..< thisData.count {
//                            let xPos: CGFloat = CGFloat(i) * (CGFloat(geometry.size.width) / CGFloat(thisData.count - 1)) //- (barWidth / 2)
//                            var yPos: CGFloat? = nil
//                            if thisData[i] != nil {
//                                yPos = CGFloat(geometry.size.height) - (thisData[i]! - min) * CGFloat(geometry.size.height) / (max - min)
//                            }
//
//                            if yPos != nil {
//                                if first {
//                                    path.move(to: CGPoint(x: xPos, y: yPos!))
//                                    first = false
//                                } else {
//                                    path.addLine(to: CGPoint(x: xPos, y: yPos!))
//                                }
//                            }
//                        }
//                    }.stroke(self.color[graph].opacity(0.6), lineWidth: 2)
//                }
//            }
//        }.frame(height: 60)
//    }
//}
//
//// Grid
////                Path { path in
////                    let horizontalGridStep: CGFloat = geometry.size.height / (CGFloat(horizontalGridLines) + 1.0)
////                    let verticalGridStep: CGFloat = geometry.size.width / (CGFloat(verticalGridLines) + 1.0)
////
////                    // Vertical gridlines
////                    for i in 0 ... (verticalGridLines + 1) {
////                        path.move(to: CGPoint(x: i * Int(verticalGridStep),
////                                              y: 0))
////                        path.addLine(to: CGPoint(x: i * Int(verticalGridStep),
////                                                 y: Int(geometry.size.height)))
////                    }
////
////                    // Horizontal gridlines
////                    for i in 0 ... (horizontalGridLines + 1) {
////                        path.move(to: CGPoint(x: 0,
////                                              y: i * Int(horizontalGridStep)))
////                        path.addLine(to: CGPoint(x: Int(geometry.size.width),
////                                                 y: i * Int(horizontalGridStep)))
////                    }
////
////                    path.closeSubpath()
////                }.stroke(self.gridColor, lineWidth: 1)
//
