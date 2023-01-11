import SwiftUI

/**
 View showing `moodSnap` history item with `filter` based on `searchText`.
 */
struct HistoryItemView: View {
    var moodSnap: MoodSnapStruct
    @Binding var filter: SnapTypeEnum
    @Binding var searchText: String
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager
    @State private var showingDeleteAlert: Bool = false
    @State private var showingMoodSnapSheet: Bool = false

    var body: some View {
        if snapFilter(moodSnap: moodSnap, filter: filter, searchText: searchText) && !(moodSnap.snapType == .quote && !data.settings.quoteVisibility) {
            GroupBox {
                Group {
                    HStack {
                        if moodSnap.snapType == .mood {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "brain.head.profile")
                                .font(.caption)
                        }
                        if moodSnap.snapType == .note {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "note.text")
                                .font(.caption)
                        }
                        if moodSnap.snapType == .event {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "star.fill")
                                .font(.caption)
                        }
                        if moodSnap.snapType == .media {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "photo.on.rectangle.angled")
                                .font(.caption)
                        }
                        if moodSnap.snapType == .custom {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "eye")
                                .font(.caption)
                        }
                        if moodSnap.snapType == .quote && data.settings.quoteVisibility {
                            Label(moodSnap.timestamp.dateTimeString(), systemImage: "quote.opening")
                                .labelStyle(.iconOnly)
                                .font(.caption)
                        }

                        Spacer()
                        Menu {
                            if moodSnap.snapType == .mood || moodSnap.snapType == .note || moodSnap.snapType == .event {
                                Button(action: {
                                    showingMoodSnapSheet.toggle()
                                }, label: {
                                    Image(systemName: "pencil")
                                    Text("edit")
                                })
                            }

                            Button(role: .destructive, action: {
                                showingDeleteAlert = true
                            }, label: {
                                Image(systemName: "trash")
                                Text("delete")
                            })
                        } label: { Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.primary)
                        }
                        .sheet(isPresented: $showingMoodSnapSheet) {
                            switch moodSnap.snapType {
                            case .mood:
                                MoodSnapView(moodSnap: moodSnap)
                            case .event:
                                EventView(moodSnap: moodSnap)
                            case .note:
                                NoteView(moodSnap: moodSnap)
                            case .media:
                                MediaView(moodSnap: moodSnap)
                            default:
                                EmptyView()
                            }
                        }
                        .alert(isPresented: $showingDeleteAlert) {
                            Alert(
                                title: Text("delete_this_moodsnap"),
                                message: Text("sure_to_delete"),
                                primaryButton: .cancel(),
                                secondaryButton: .destructive(
                                    Text("delete"),
                                    action: {
                                        DispatchQueue.main.async {
                                            withAnimation {
                                                data.stopProcessing()
                                                health.stopProcessing(data: data)
                                                data.moodSnaps = deleteHistoryItem(moodSnaps: data.moodSnaps, moodSnap: moodSnap)
                                                data.startProcessing()
                                                health.startProcessing(data: data)
                                            }
                                        }
                                    }
                                )
                            )
                        }
                    }
                }

                Group {
                    if moodSnap.snapType == .event {
                        HistoryEventView(moodSnap: moodSnap)
                    }
                    if moodSnap.snapType == .mood {
                        HistoryMoodView(moodSnap: moodSnap)
                    }
                    if moodSnap.snapType == .note {
                        HistoryNoteView(moodSnap: moodSnap)
                    }
                    if moodSnap.snapType == .media {
                        HistoryMediaView(moodSnap: moodSnap)
                    }
                    if moodSnap.snapType == .custom {
                        HistoryCustomView(which: moodSnap.customView)
                    }
                    if moodSnap.snapType == .quote && data.settings.quoteVisibility {
                        HistoryQuoteView(moodSnap: moodSnap)
                    }
                }
            }
            .padding([.leading, .trailing], 7)
            .padding(.bottom, -2)
        }
    }
}
