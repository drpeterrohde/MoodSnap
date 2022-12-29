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
            ScrollViewReader { scrollView in
                ScrollView {
                    LazyVStack {
                        ForEach(data.moodSnaps, id: \.id) { moodSnap in
                            HistoryItemView(moodSnap: moodSnap, filter: $filter, searchText: $searchText)
                        }
                        Spacer()
                    }
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
                .onTapGesture(count: 2) {
                    withAnimation(.easeOut(duration: 1.0)) {
                        scrollView.scrollTo(data.moodSnaps[0].id, anchor: .bottom)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Menu() {
                            Button(action: {
                                filter = .none
                                searchText = ""
                                searchPrompt = "Search_all"
                            }) {
                                Label("Search_all", systemImage: "magnifyingglass")
                                    .font(.subheadline)
                            }
                            Button(action: {
                                filter = .mood
                                searchText = ""
                                searchPrompt = "Search_MoodSnaps"
                            }) {
                                Label("Search_MoodSnaps", systemImage: "brain.head.profile")
                                    .font(.subheadline)
                            }
                            Button(action: {
                                filter = .event
                                searchText = ""
                                searchPrompt = "Search_events"
                            }) {
                                Label("Search_events", systemImage: "star.fill")
                                    .font(.subheadline)
                            }
                            Button(action: {
                                filter = .note
                                searchText = ""
                                searchPrompt = "Search_notes"
                            }) {
                                Label("Search_notes", systemImage: "note.text")
                                    .font(.subheadline)
                            }
                            Button(action: {
                                filter = .media
                                searchText = ""
                                searchPrompt = "Search_media"
                            }) {
                                Label("Search_media", systemImage: "photo.on.rectangle.angled")
                                    .font(.subheadline)
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }
                    }
                }
            }
        }
    }
}
