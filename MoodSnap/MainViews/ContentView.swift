import SwiftUI

/**
 Main content view.
 */
struct ContentView: View {
    @ObservedObject var data: DataStoreClass
    @ObservedObject var health: HealthManager
    @State var searchText: String = ""
    @State var filter: SnapTypeEnum = .none

    var body: some View {
        HistoryView(filter: $filter, searchText: $searchText, data: data)
            .padding(.bottom, -8)
        Divider()
        ControlView(data: data, health: health)
            .padding(.top, -10)
    }
}
