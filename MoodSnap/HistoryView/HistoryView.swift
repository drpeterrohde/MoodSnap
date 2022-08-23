import SwiftUI

/**
 View showing history based on `filter` with `searchText`.
 */
struct HistoryView: View {
    @Environment(\.dismissSearch) var dismissSearch
    @Environment(\.isSearching) var isSearching
    @Binding var filter: SnapTypeEnum
    @Binding var searchText: String
    @EnvironmentObject var data: DataStoreClass
    @State var searchPrompt: String = "search_all"
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(data.moodSnaps, id: \.id) { moodSnap in
                    HistoryItemView(moodSnap: moodSnap, filter: $filter, searchText: $searchText)
                }
                Spacer()
            }
            .navigationBarTitle(Text("history"))
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: LocalizedStringKey(searchPrompt)
            )
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    filter = .none
                    searchText = ""
                    searchPrompt = "search_all"
                }
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Menu() {
                        Button(action: {
                            filter = .none
                            searchText = ""
                            searchPrompt = "Search all"
                        }) {
                            Label("Search all", systemImage: "magnifyingglass")
                                .font(.subheadline)
                        }
                        Button(action: {
                            filter = .mood
                            searchText = ""
                            searchPrompt = "Search MoodSnaps"
                        }) {
                            Label("Search MoodSnaps", systemImage: "brain.head.profile")
                                .font(.subheadline)
                        }
                        Button(action: {
                            filter = .event
                            searchText = ""
                            searchPrompt = "Search events"
                        }) {
                            Label("Search events", systemImage: "star.fill")
                                .font(.subheadline)
                        }
                        Button(action: {
                            filter = .note
                            searchText = ""
                            searchPrompt = "Search notes"
                        }) {
                            Label("Search notes", systemImage: "note.text")
                                .font(.subheadline)
                        }
                        Button(action: {
                            filter = .media
                            searchText = ""
                            searchPrompt = "Search media"
                        }) {
                            Label("Search media", systemImage: "photo.on.rectangle.angled")
                                .font(.subheadline)
                        }
                    } label: { Image(systemName: "line.3.horizontal.decrease")
                    }
                }
            }
        }
    }
}
