import SwiftUI

/**
 View for MoodSnap sheet.
 */
struct MoodSnapView: View {
    @Environment(\.dismiss) var dismiss
    @State var moodSnap: MoodSnapStruct
    @Binding var data: DataStoreStruct
    @State private var showingDatePickerSheet = false

    var body: some View {
        GroupBox {
            ScrollView {
                Group {
                    HStack {
                        Label(moodSnap.timestamp.dateTimeString(), systemImage: "clock").font(.caption)

                        Spacer()

                        Button {
                            showingDatePickerSheet.toggle()
                        } label: { Image(systemName: "calendar.badge.clock").resizable().scaledToFill().frame(width: 15, height: 15).foregroundColor(Color.primary)
                        }.sheet(isPresented: $showingDatePickerSheet) {
                            DatePickerView(moodSnap: $moodSnap, settings: data.settings)
                        }
                    }
                }

                // Mood
                Group {
                    Divider()
                    VStack(spacing: themes[data.settings.theme].sliderSpacing) {
                        Label("mood", systemImage: "brain.head.profile").font(.caption)
                        Spacer().frame(height: 20)
                        Text("elevation").font(Font.caption.bold()).foregroundColor(themes[data.settings.theme].elevationColor)
                        Slider(value: $moodSnap.elevation, in: 0 ... 4, step: 1)
                        Text("depression").font(Font.caption.bold()).foregroundColor(themes[data.settings.theme].depressionColor)
                        Slider(value: $moodSnap.depression, in: 0 ... 4, step: 1)
                        Text("anxiety").font(Font.caption.bold()).foregroundColor(themes[data.settings.theme].anxietyColor)
                        Slider(value: $moodSnap.anxiety, in: 0 ... 4, step: 1)
                        Text("irritability").font(Font.caption.bold()).foregroundColor(themes[data.settings.theme].irritabilityColor)
                        Slider(value: $moodSnap.irritability, in: 0 ... 4, step: 1)
                    }
                }

                // Symptoms
                if visibleSymptomsCount(settings: data.settings) > 0 {
                    Group {
                        Divider()
                        Label("symptoms", systemImage: "heart.text.square").font(.caption)

                        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)

                        LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].moodSnapGridSpacing) {
                            ForEach(0 ..< symptomList.count, id: \.self) { i in
                                if data.settings.symptomVisibility[i] {
                                    Toggle(.init(symptomList[i]), isOn: $moodSnap.symptoms[i])
                                        .toggleStyle(.button)
                                        .tint(themes[data.settings.theme].buttonColor)
                                        .font(.caption)
                                        .padding(1)
                                }
                            }
                        }
                    }
                }

                // Activities
                if visibleActivitiesCount(settings: data.settings) > 0 {
                    Group {
                        Divider()
                        Label("activity", systemImage: "figure.walk").font(.caption)

                        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)

                        LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].moodSnapGridSpacing) {
                            ForEach(0 ..< activityList.count, id: \.self) { i in
                                if data.settings.activityVisibility[i] {
                                    Toggle(.init(activityList[i]), isOn: $moodSnap.activities[i])
                                        .toggleStyle(.button)
                                        .tint(themes[data.settings.theme].buttonColor)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }

                // Social
                if visibleSocialCount(settings: data.settings) > 0 {
                    Group {
                        Divider()
                        Label("social", systemImage: "person.2").font(.caption)

                        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)

                        LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].moodSnapGridSpacing) {
                            ForEach(0 ..< socialList.count, id: \.self) { i in
                                if data.settings.socialVisibility[i] {
                                    Toggle(.init(socialList[i]), isOn: $moodSnap.social[i])
                                        .toggleStyle(.button)
                                        .tint(themes[data.settings.theme].buttonColor)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }

                // Notes
                Group {
                    VStack {
                        Divider()
                        Label("notes", systemImage: "note.text").font(.caption)
                        TextEditor(text: $moodSnap.notes)
                            .font(.caption)
                            .frame(minHeight: 50, alignment: .leading)
                    }
                }

                // Save button
                Button { // put in async main???
                    moodSnap.snapType = .mood
                    data.moodSnaps = deleteHistoryItem(moodSnaps: data.moodSnaps, moodSnap: moodSnap)
                    data.moodSnaps.append(moodSnap)
                    data.settings.addedSnaps += 1
                    let quoteSnap = getQuoteSnap(count: data.settings.addedSnaps)
                    if quoteSnap != nil {
                        data.moodSnaps.append(quoteSnap!)
                    }
                    data.moodSnaps = sortByDate(moodSnaps: data.moodSnaps)
                    DispatchQueue.global(qos: .userInteractive).async {
                        data.process()
                        data.save()
                    }
                    dismiss()
                } label: { Image(systemName: "arrowtriangle.right.circle")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(themes[data.settings.theme].buttonColor)
                    .frame(width: themes[data.settings.theme].controlBigIconSize, height: themes[data.settings.theme].controlBigIconSize)
                }
            }
        }
    }
}
