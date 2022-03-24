import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var filter: SnapTypeEnum
    @Binding var data: DataStoreStruct
    
    @State private var isEditing = false
    @State private var filterColor: Color = Color.gray
    
    var body: some View {
        Spacer()
        HStack {
            // Filter menu
            Menu(content: {
                Button(action: {
                    filter = .none
                    filterColor = Color.gray
                }) {
                    Text("No filter")
                }
                
                Button(action: {
                    filter = .mood
                    filterColor = themes[data.settings.theme].iconColor
                }) {
                    Image(systemName: "brain.head.profile")
                    Text("MoodSnaps")
                }
                
                Button(action: {
                    filter = .event
                    filterColor = themes[data.settings.theme].iconColor
                }) {
                    Image(systemName: "star.fill")
                    Text("Events")
                }
                
                Button(action: {
                    filter = .note
                    filterColor = themes[data.settings.theme].iconColor
                }) {
                    Image(systemName: "note.text")
                    Text("Notes")
                }
                
                Button(action: {
                    filter = .media
                    filterColor = themes[data.settings.theme].iconColor
                }) {
                    Image(systemName: "photo.on.rectangle.angled")
                    Text("Media")
                }
            },
            label: {
                    Image(systemName: "line.horizontal.3.decrease")
                }).padding(.leading, 14).foregroundColor(Color.secondary)//filterColor)
            
            // Search menu
            TextField("Search ...", text: $searchText)
                .padding(5)
                .padding(.horizontal, 25)
                .background(Color(.darkGray)) // .systemGray6
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    self.searchText = ""
                                }
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
            //.disabled(!self.isEditing)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.isEditing = false
                        self.searchText = ""
                    }
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
            }
        }
        Divider()
    }
}
