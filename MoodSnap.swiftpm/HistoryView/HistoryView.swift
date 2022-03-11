import SwiftUI

struct HistoryView: View {
    @Binding var filter: SnapTypeEnum
    @Binding var searchText: String
    @Binding var data: DataStoreStruct
    @State var searchPrompt: String = "Search all"
    
    var body: some View {
        SearchBarView(searchText: $searchText, filter: $filter, data: $data)
        List {
            ForEach($data.moodSnaps, id: \.id) {moodSnap in
                HistoryItemView(moodSnap: moodSnap, filter: $filter, searchText: $searchText, data: $data)
            }.listRowSeparator(.hidden)
        }.listStyle(.plain).padding(.top, -8)
    }
}




//            .searchable(
//                text: $searchText,
//                placement: .navigationBarDrawer(displayMode: .always),
//                prompt: searchPrompt,
//                suggestions: {
//                    Button(action: {
//                        filter = .none
//                        searchText = ""
//                        searchPrompt = "Search all"
//                    }) { 
//                        Label("All", systemImage: "").font(.subheadline)
//                    }
//                    Button(action: {
//                        filter = .mood
//                        searchText = ""
//                        searchPrompt = "Search MoodSnaps"
//                    }) { 
//                        Label("MoodSnaps", systemImage: "brain.head.profile").font(.subheadline)
//                    }
//                    Button(action: {
//                        filter = .event
//                        searchText = ""
//                        searchPrompt = "Search events"
//                    }) { 
//                        Label("Events", systemImage: "star.fill").font(.subheadline)
//                    }
//                    Button(action: {
//                        filter = .note
//                        searchText = ""
//                        searchPrompt = "Search notes"
//                    }) { 
//                        Label("Notes", systemImage: "note.text").font(.subheadline)
//                    }
//                })
//.navigationBarTitle("")
//.navigationBarTitleDisplayMode(.automatic)
//.statusBar(hidden: true)
//.navigationBarHidden(true)
//}
//.padding([.top, .bottom], -40)
//.edgesIgnoringSafeArea([.top, .bottom])

//}
