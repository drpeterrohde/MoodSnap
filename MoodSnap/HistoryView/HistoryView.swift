import SwiftUI

/**
 View showing history based on `filter` with `searchText`.
 */
struct HistoryView: View {
    @Environment(\.dismissSearch) var dismissSearch
    @Environment(\.isSearching) var isSearching
    @Binding var filter: SnapTypeEnum
    @Binding var searchText: String
    @Binding var data: DataStoreStruct
    @State var searchPrompt: String = "Search all"

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($data.moodSnaps, id: \.id) { moodSnap in
                    HistoryItemView(moodSnap: moodSnap, filter: $filter, searchText: $searchText, data: $data)
                }
                Spacer()
            }
            .navigationBarTitle(Text("History"))
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: searchPrompt // ,
//                suggestions: {
//                    Button(action: {
//                        filter = .none
//                        searchText = ""
//                        searchPrompt = "Search all"
//                    }) {
//                        Label("Search all", systemImage: "magnifyingglass")
//                            .font(.subheadline)
//                    }
//                    Button(action: {
//                        filter = .mood
//                        searchText = ""
//                        searchPrompt = "Search MoodSnaps"
//                    }) {
//                        Label("Search MoodSnaps", systemImage: "brain.head.profile")
//                            .font(.subheadline)
//                    }
//                    Button(action: {
//                        filter = .event
//                        searchText = ""
//                        searchPrompt = "Search events"
//                    }) {
//                        Label("Search events", systemImage: "star.fill")
//                            .font(.subheadline)
//                    }
//                    Button(action: {
//                        filter = .note
//                        searchText = ""
//                        searchPrompt = "Search notes"
//                    }) {
//                        Label("Search notes", systemImage: "note.text")
//                            .font(.subheadline)
//                    }
//                    Button(action: {
//                        filter = .media
//                        searchText = ""
//                        searchPrompt = "Search media"
//                    }) {
//                        Label("Search media", systemImage: "photo.on.rectangle.angled")
//                            .font(.subheadline)
//                    }
//                }
            )
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    filter = .none
                    searchText = ""
                    searchPrompt = "Search all"
                } // Not doing anything ???
            }
        }
    }
}
