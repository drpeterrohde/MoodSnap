import SwiftUI

struct MoodSnapView: View {
    @Environment(\.dismiss) var dismiss
    @State var moodSnap: MoodSnapStruct
    @Binding var data: DataStoreStruct
    @State private var showingDatePickerSheet = false
    
    var body: some View {
        if ((moodSnap.elevation != nil) && (moodSnap.depression != nil) && (moodSnap.anxiety != nil) && (moodSnap.irritability != nil)) {
        GroupBox {
            ScrollView {
            Group {
            HStack{
                Label(calculateDateAndTime(date: moodSnap.timestamp), systemImage: "clock").font(.caption)
                
                Spacer()
                
                Button {
                    showingDatePickerSheet.toggle()
                } label:{Image(systemName: "calendar.badge.clock").resizable().scaledToFill().frame(width: 15, height: 15).foregroundColor(Color.primary)
                }.sheet(isPresented: $showingDatePickerSheet) {
                    DatePickerView(moodSnap: $moodSnap, settings: data.settings)
                }
            }
            }
            
            // Mood
            Group {
                Divider()
            VStack(spacing: themes[data.settings.theme].sliderSpacing) {
                Label("Mood", systemImage: "brain.head.profile").font(.caption)
                Spacer().frame(height: 20)
                Text("Elevation").font(Font.caption.bold()).foregroundColor(themes[data.settings.theme].elevationColor)
                    Slider(value: $moodSnap.elevation, in: 0...4, step: 1)
                Text("Depression").font(Font.caption.bold()).foregroundColor(themes[data.settings.theme].depressionColor)
                    Slider(value: $moodSnap.depression, in: 0...4, step: 1)
                Text("Anxiety").font(Font.caption.bold()).foregroundColor(themes[data.settings.theme].anxietyColor)
                Slider(value: $moodSnap.anxiety, in: 0...4, step: 1)
                Text("Irritability").font(Font.caption.bold()).foregroundColor(themes[data.settings.theme].irritabilityColor)
                Slider(value: $moodSnap.irritability, in: 0...4, step: 1)
            }
            }
            
            // Symptoms
                if (visibleSymptoms(settings: data.settings) > 0) {
            Group {
            Divider()
            Label("Symptoms", systemImage: "heart.text.square").font(.caption)
            
                let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)
                
            LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].moodSnapGridSpacing) {
                    ForEach(0..<symptomList.count) {i in
                        if (data.settings.symptomVisibility[i]) {
                            Toggle(symptomList[i], isOn: $moodSnap.symptoms[i])
                            .toggleStyle(.button)
                            .tint(themes[data.settings.theme].buttonColor)
                            .font(.caption)
                            .padding(0)
                        }
                    }
            }
            }
                }
            
            // Activities
                if (visibleActivities(settings: data.settings) > 0) {
            Group {
            Divider()
            Label("Activity", systemImage: "figure.walk").font(.caption)
            
                let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)
            
            LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].moodSnapGridSpacing) {
                ForEach(0..<activityList.count) {i in
                    if (data.settings.activityVisibility[i]) {
                    Toggle(activityList[i], isOn: $moodSnap.activities[i])
                        .toggleStyle(.button)
                        .tint(themes[data.settings.theme].buttonColor)
                        .font(.caption)
                    }
                }
            }
            }
                }
            
                // Social
                if (visibleSocial(settings: data.settings) > 0) {
                Group {
                    Divider()
                    Label("Social", systemImage: "person.2").font(.caption)
                    
                    let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)
                    
                    LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].moodSnapGridSpacing) {
                        ForEach(0..<socialList.count) {i in
                            if (data.settings.socialVisibility[i]) {
                                Toggle(socialList[i], isOn: $moodSnap.social[i])
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
                VStack{
                    Divider()
                Label("Notes", systemImage: "note.text").font(.caption)
                TextEditor(text: $moodSnap.notes).font(.caption).frame(minHeight: 50, alignment: .leading)
                }
            }
            
            // Save button
            Button {
                moodSnap.snapType = .mood
                data.moodSnaps = deleteHistoryItem(moodSnaps: data.moodSnaps, moodSnap: moodSnap)
                data.moodSnaps.append(moodSnap)
                data.moodSnaps = sortByDate(moodSnaps: data.moodSnaps)
                dismiss()
            } label:{Image(systemName: "arrowtriangle.right.circle").resizable().scaledToFill().frame(width: 30, height: 30)
            }
        }
        }
    }
    
//    func ??<CGFloat>(lhs: Binding<Optional<CGFloat>>, rhs: CGFloat) -> Binding<CGFloat> {
//        Binding(
//            get: { lhs.wrappedValue ?? rhs },
//            set: { lhs.wrappedValue = $0 }
//        )
//    }
}
}
