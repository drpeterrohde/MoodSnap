import SwiftUI

struct HistoryItemView: View {
    @Binding var moodSnap: MoodSnapStruct
    @Binding var filter: SnapTypeEnum
    @Binding var searchText: String
    @Binding var data: DataStoreStruct
    @State private var showingDeleteAlert: Bool = false
    @State private var showingMoodSnapSheet: Bool = false
    
    var body: some View {
        if snapFilter(moodSnap: moodSnap, filter: filter, searchText: searchText) {
            GroupBox {
                Group {
                    HStack {
                        if (moodSnap.snapType == .mood) {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "brain.head.profile")
                                .font(.caption)
                        }
                        if (moodSnap.snapType == .note) {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "note.text")
                                .font(.caption)
                        }
                        if (moodSnap.snapType == .event) {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "star.fill")
                                .font(.caption)
                        }
                        if (moodSnap.snapType == .media) {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "photo")
                                .font(.caption)
                        }
                        if (moodSnap.snapType == .custom) {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "eye")
                                .font(.caption)
                        }
                        if (moodSnap.snapType == .quote) {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "quote.opening")
                                //.labelStyle(.iconOnly)
                                .font(.caption)
                        }
                        
                        Spacer()
                        Menu {
                            Button(action: {
                                showingMoodSnapSheet.toggle()
                            }, label: {
                                Image(systemName: "pencil")
                                Text("Edit")
                            })
                            
                            Button(role: .destructive, action: {
                                showingDeleteAlert = true
                            }, label: {
                                Image(systemName: "trash")
                                Text("Delete")
                            })
                        } label:{Image(systemName: "gearshape")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.primary)
                        }
                        .sheet(isPresented: $showingMoodSnapSheet) {
                            switch moodSnap.snapType {
                            case .mood:
                                MoodSnapView(moodSnap: moodSnap, data: $data)
                            case .event:
                                EventView(moodSnap: moodSnap, data: $data)
                            case .note:
                                NoteView(moodSnap: moodSnap, data: $data)
                            case .media:
                                MediaView(moodSnap: moodSnap, data: $data)
                            default:
                                EmptyView()
                            }
                        }
                        .alert(isPresented: $showingDeleteAlert) {
                            Alert(
                                title: Text("Delete this MoodSnap?"),
                                message: Text("Are you sure you want to delete this item? This action cannot be undone."),
                                primaryButton: .cancel(),
                                secondaryButton: .destructive(
                                    Text("Delete"),
                                    action: {
                                        data.moodSnaps = deleteHistoryItem(moodSnaps: data.moodSnaps, moodSnap: moodSnap)
                                        DispatchQueue.global(qos: .userInteractive).async {
                                            data.process()
                                            data.save()
                                        }
                                    }
                                )
                            )
                        }
                    }
                }
                
                Group {
                    if (moodSnap.snapType == .event) {
                        HistoryEventView(moodSnap: moodSnap, data: data)
                    }
                    if (moodSnap.snapType == .mood) {
                        HistoryMoodView(moodSnap: moodSnap, data: data)
                    }
                    if (moodSnap.snapType == .note) {
                        HistoryNoteView(moodSnap: moodSnap, data: data)
                    }
                    if (moodSnap.snapType == .media) {
                        HistoryMediaView(moodSnap: moodSnap, data: data)
                    }
                    if (moodSnap.snapType == .custom) {
                        HistoryCustomView(which: moodSnap.customView, data: data)
                    }
                    if (moodSnap.snapType == .quote) {
                        HistoryQuoteView(moodSnap: moodSnap, data: data)
                    }
                }
            }
            .padding([.leading, .trailing], 7)
            .padding(.bottom, -2)
        }
    }
}
