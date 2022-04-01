import Charts
import SwiftUI

/**
 Main content view.
 */
struct ContentView: View {
    @Binding var data: DataStoreStruct
    @State var searchText: String = ""
    @State var filter: SnapTypeEnum = .none

    var body: some View {
        HistoryView(filter: $filter, searchText: $searchText, data: $data)
            .padding(.bottom, -8)
        Divider()
        ControlView(data: $data)
            .padding(.top, -10)
    }
}
