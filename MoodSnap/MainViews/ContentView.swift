import SwiftUI
import Charts

struct ContentView: View {
    @Binding var data: DataStoreStruct
    @State var searchText: String = ""
    @State var filter: SnapTypeEnum = .none
    
    var body: some View {
        HistoryView(filter: $filter, searchText: $searchText, data: $data)
        ControlView(data: $data)
    }
}
