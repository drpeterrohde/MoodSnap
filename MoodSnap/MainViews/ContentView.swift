import SwiftUI

/**
 Main content view.
 */
struct ContentView: View {
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager
    @State var searchText: String = ""
    @State var filter: SnapTypeEnum = .none

    var body: some View {
        HistoryView(filter: $filter, searchText: $searchText)
            .padding(.bottom, -8)
        Divider()
        ControlView()
            .padding(.top, -10)
    }
}
