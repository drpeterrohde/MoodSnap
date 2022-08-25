import SwiftUI

/**
 View showing insights panel.
 */
struct InsightsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager
    @State var timescale: Int = TimeScaleEnum.month.rawValue
    
    var body: some View {
        NavigationView {
            // ScrollView {
            VStack {
                Picker("", selection: $timescale) {
                    Text("1mo").tag(TimeScaleEnum.month.rawValue)
                    Text("3mo").tag(TimeScaleEnum.threeMonths.rawValue)
                    Text("6mo").tag(TimeScaleEnum.sixMonths.rawValue)
                    Text("1yr").tag(TimeScaleEnum.year.rawValue)
                }.pickerStyle(SegmentedPickerStyle())
                
                ScrollViewReader { scrollView in
                    ScrollView(.vertical) {
                        VStack {
                            Group {
                                HStack {
                                    Text("HISTORY")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                                .padding(.leading, 10)
                                .padding(.bottom, -5)
                                
                                GroupBox {
                                    HStack {
                                        HStack {
                                            Image(systemName: "brain.head.profile")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: iconWidth, height: iconWidth)
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                                .font(.subheadline.bold())
                                            Text("average_mood")
                                                .font(.subheadline.bold())
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                            Spacer()
                                        }
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                data.uxState.isAverageMoodExpanded.toggle()
                                            }
                                        }) {
                                            if data.uxState.isAverageMoodExpanded {
                                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                                            } else {
                                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    if data.uxState.isAverageMoodExpanded {
                                        //Divider()
                                        AverageMoodView(timescale: timescale)
                                    }
                                }
                                
                                GroupBox {
                                    HStack {
                                        HStack {
                                            Image(systemName: "chart.bar.xaxis")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: iconWidth, height: iconWidth)
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                                .font(.subheadline.bold())
                                            Text("mood_history")
                                                .font(.subheadline.bold())
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                            Spacer()
                                        }
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                data.uxState.isMoodHistoryExpanded.toggle()
                                            }
                                        }) {
                                            if data.uxState.isMoodHistoryExpanded {
                                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                                            } else {
                                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    if data.uxState.isMoodHistoryExpanded {
                                        //Divider()
                                        MoodHistoryBarView(timescale: timescale)
                                    }
                                }
                                
                                GroupBox {
                                    HStack {
                                        HStack {
                                            Image(systemName: "chart.line.uptrend.xyaxis")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: iconWidth, height: iconWidth)
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                                .font(.subheadline.bold())
                                            Text("moving_average")
                                                .font(.subheadline.bold())
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                            Spacer()
                                        }
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                data.uxState.isMovingAverageExpanded.toggle()
                                            }
                                        }) {
                                            if data.uxState.isMovingAverageExpanded {
                                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                                            } else {
                                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    if data.uxState.isMovingAverageExpanded {
                                        //Divider()
                                        SlidingAverageView(timescale: timescale)
                                    }
                                }
                                
                                GroupBox {
                                    HStack {
                                        HStack {
                                            Image(systemName: "waveform.path.ecg")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: iconWidth, height: iconWidth)
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                                .font(.subheadline.bold())
                                            Text("volatility")
                                                .font(.subheadline.bold())
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                            Spacer()
                                        }
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                data.uxState.isVolatilityExpanded.toggle()
                                            }
                                        }) {
                                            if data.uxState.isVolatilityExpanded {
                                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                                            } else {
                                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    if data.uxState.isVolatilityExpanded {
                                        //Divider()
                                        SlidingVolatilityView(timescale: timescale)
                                    }
                                }
                                
                                GroupBox {
                                    HStack {
                                        HStack {
                                            Image(systemName: "chart.bar.doc.horizontal")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: iconWidth, height: iconWidth)
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                                .font(.subheadline.bold())
                                            Text("tally")
                                                .font(.subheadline.bold())
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                            Spacer()
                                        }
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                data.uxState.isTallyExpanded.toggle()
                                            }
                                        }) {
                                            if data.uxState.isTallyExpanded {
                                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                                            } else {
                                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    if data.uxState.isTallyExpanded {
                                        TallyView(timescale: timescale)
                                    }
                                }
                            }
                            
                            Group {
                                HStack {
                                    Text("INFLUENCES")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                                .padding(.leading, 10)
                                .padding(.top, 2)
                                .padding(.bottom, -5)
                                
                                GroupBox {
                                    HStack {
                                        HStack {
                                            Image(systemName: "figure.walk")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: iconWidth, height: iconWidth)
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                                .font(.subheadline.bold())
                                            Text("activities")
                                                .font(.subheadline.bold())
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                            Spacer()
                                        }
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                data.uxState.isActivitiesExpanded.toggle()
                                            }
                                        }) {
                                            if data.uxState.isActivitiesExpanded {
                                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                                            } else {
                                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    if data.uxState.isActivitiesExpanded {
                                        Divider()
                                        InfluencesActivityView()
                                    }
                                }
                                
                                GroupBox {
                                    HStack {
                                        HStack {
                                            Image(systemName: "person.2")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: iconWidth, height: iconWidth)
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                                .font(.subheadline.bold())
                                            Text("social")
                                                .font(.subheadline.bold())
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                            Spacer()
                                        }
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                data.uxState.isSocialExpanded.toggle()
                                            }
                                        }) {
                                            if data.uxState.isSocialExpanded {
                                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                                            } else {
                                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    if data.uxState.isSocialExpanded {
                                        Divider()
                                        InfluencesSocialView()
                                    }
                                }
                                
                                GroupBox {
                                    HStack {
                                        HStack {
                                            Image(systemName: "heart.text.square")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: iconWidth, height: iconWidth)
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                                .font(.subheadline.bold())
                                            Text("symptoms")
                                                .font(.subheadline.bold())
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                            Spacer()
                                        }
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                data.uxState.isSymptomSummaryExpanded.toggle()
                                            }
                                        }) {
                                            if data.uxState.isSymptomSummaryExpanded {
                                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                                            } else {
                                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    if data.uxState.isSymptomSummaryExpanded {
                                        Divider()
                                        InfluencesSymptomView()
                                    }
                                }
                                
                                GroupBox {
                                    HStack {
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: iconWidth, height: iconWidth)
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                                .font(.subheadline.bold())
                                            Text("events")
                                                .font(.subheadline.bold())
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                            Spacer()
                                        }
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                data.uxState.isEventSummaryExpanded.toggle()
                                            }
                                        }) {
                                            if data.uxState.isEventSummaryExpanded {
                                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                                            } else {
                                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    if data.uxState.isEventSummaryExpanded {
                                        Divider()
                                        InfluencesEventsView()
                                    }
                                }
                                
                                GroupBox {
                                    HStack {
                                        HStack {
                                            Image(systemName: "number")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: iconWidth, height: iconWidth)
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                                .font(.subheadline.bold())
                                            Text("hashtags")
                                                .font(.subheadline.bold())
                                                .foregroundColor(themes[data.settings.theme].iconColor)
                                            Spacer()
                                        }
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                data.uxState.isHashtagSummaryExpanded.toggle()
                                            }
                                        }) {
                                            if data.uxState.isHashtagSummaryExpanded {
                                                Image(systemName: "chevron.down").foregroundColor(.secondary)
                                            } else {
                                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    if data.uxState.isHashtagSummaryExpanded {
                                        Divider()
                                        InfluencesHashtagView()
                                    }
                                }
                            }
                            
                            GroupBox {
                                HStack {
                                    HStack {
                                        Image(systemName: "waveform.path.ecg.rectangle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: iconWidth, height: iconWidth)
                                            .foregroundColor(themes[data.settings.theme].iconColor)
                                            .font(.subheadline.bold())
                                        Text("transients")
                                            .font(.subheadline.bold())
                                            .foregroundColor(themes[data.settings.theme].iconColor)
                                        Spacer()
                                    }
                                    Spacer()
                                    Button(action: {
                                        withAnimation(.easeInOut) {
                                            data.uxState.isButterflyAverageExpanded.toggle()
                                        }
                                    }) {
                                        if data.uxState.isButterflyAverageExpanded {
                                            Image(systemName: "chevron.down").foregroundColor(.secondary)
                                        } else {
                                            Image(systemName: "chevron.right").foregroundColor(.secondary)
                                        }
                                    }
                                }
                                if data.uxState.isButterflyAverageExpanded {
                                    //Divider()
                                    TransientWithPickerView(timescale: timescale)
                                    EmptyView()
                                }
                            }
                            
                            Group {
                                if data.settings.useHealthKit && (data.settings.healthWeightOn || data.settings.healthEnergyOn || data.settings.healthMenstrualOn || data.settings.healthSleepOn || data.settings.healthDistanceOn) {
                                    HStack {
                                        Text("HEALTH")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                    .padding(.leading, 10)
                                    .padding(.top, 2)
                                    .padding(.bottom, -5)
                                    
                                    if data.settings.healthWeightOn {
                                        GroupBox {
                                            HStack {
                                                // Label("Weight", systemImage: "scalemass").font(.subheadline)
                                                HStack {
                                                    Image(systemName: "scalemass")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: iconWidth, height: iconWidth)
                                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                                        .font(.subheadline.bold())
                                                    Text("Weight")
                                                        .font(.subheadline.bold())
                                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                                    Spacer()
                                                }
                                                Spacer()
                                                Button(action: {
                                                    withAnimation(.easeInOut) {
                                                        data.uxState.isWeightExpanded.toggle()
                                                    }
                                                }) {
                                                    if data.uxState.isWeightExpanded {
                                                        Image(systemName: "chevron.down").foregroundColor(.secondary)
                                                    } else {
                                                        Image(systemName: "chevron.right").foregroundColor(.secondary)
                                                    }
                                                }
                                            }
                                            if data.uxState.isWeightExpanded {
                                                //Divider()
                                                WeightView(timescale: timescale)
                                            }
                                        }
                                    }
                                    
                                    if data.settings.healthDistanceOn {
                                        GroupBox {
                                            HStack {
                                                // Label("Walking & running distance", systemImage: "figure.walk").font(.subheadline)
                                                HStack {
                                                    Image(systemName: "figure.walk")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: iconWidth, height: iconWidth)
                                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                                        .font(.subheadline.bold())
                                                    Text("Walking_running_distance")
                                                        .font(.subheadline.bold())
                                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                                    Spacer()
                                                }
                                                Spacer()
                                                Button(action: {
                                                    withAnimation(.easeInOut) {
                                                        data.uxState.isWalkingRunningDistanceExpanded.toggle()
                                                    }
                                                }) {
                                                    if data.uxState.isWalkingRunningDistanceExpanded {
                                                        Image(systemName: "chevron.down").foregroundColor(.secondary)
                                                    } else {
                                                        Image(systemName: "chevron.right").foregroundColor(.secondary)
                                                    }
                                                }
                                            }
                                            if data.uxState.isWalkingRunningDistanceExpanded {
                                                //Divider()
                                                WalkingRunningDistanceView(timescale: timescale)
                                            }
                                        }
                                    }
                                    
                                    if data.settings.healthEnergyOn {
                                        GroupBox {
                                            HStack {
                                                // Label("Walking & running distance", systemImage: "figure.walk").font(.subheadline)
                                                HStack {
                                                    Image(systemName: "bolt.heart")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: iconWidth, height: iconWidth)
                                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                                        .font(.subheadline.bold())
                                                    Text("Active_energy")
                                                        .font(.subheadline.bold())
                                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                                    Spacer()
                                                }
                                                Spacer()
                                                Button(action: {
                                                    withAnimation(.easeInOut) {
                                                        data.uxState.isActiveEnergyExpanded.toggle()
                                                    }
                                                }) {
                                                    if data.uxState.isActiveEnergyExpanded {
                                                        Image(systemName: "chevron.down").foregroundColor(.secondary)
                                                    } else {
                                                        Image(systemName: "chevron.right").foregroundColor(.secondary)
                                                    }
                                                }
                                            }
                                            if data.uxState.isActiveEnergyExpanded {
                                                //Divider()
                                                ActiveEnergyView(timescale: timescale)
                                            }
                                        }
                                    }
                                    
                                    if data.settings.healthSleepOn {
                                        GroupBox {
                                            HStack {
                                                HStack {
                                                    Image(systemName: "bed.double")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: iconWidth, height: iconWidth)
                                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                                        .font(.subheadline.bold())
                                                    Text("Sleep")
                                                        .font(.subheadline.bold())
                                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                                    Spacer()
                                                }
                                                Spacer()
                                                Button(action: {
                                                    withAnimation(.easeInOut) {
                                                        data.uxState.isSleepExpanded.toggle()
                                                    }
                                                }) {
                                                    if data.uxState.isSleepExpanded {
                                                        Image(systemName: "chevron.down").foregroundColor(.secondary)
                                                    } else {
                                                        Image(systemName: "chevron.right").foregroundColor(.secondary)
                                                    }
                                                }
                                            }
                                            if data.uxState.isSleepExpanded {
                                                //Divider()
                                                SleepView(timescale: timescale)
                                            }
                                        }
                                    }
                                    
                                    if data.settings.healthMenstrualOn {
                                        GroupBox {
                                            HStack {
                                                HStack {
                                                    Image(systemName: "staroflife")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: iconWidth, height: iconWidth)
                                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                                        .font(.subheadline.bold())
                                                    Text("Menstrual_cycle")
                                                        .font(.subheadline.bold())
                                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                                    Spacer()
                                                }
                                                Spacer()
                                                Button(action: {
                                                    withAnimation(.easeInOut) {
                                                        data.uxState.isMenstrualExpanded.toggle()
                                                    }
                                                }) {
                                                    if data.uxState.isMenstrualExpanded {
                                                        Image(systemName: "chevron.down").foregroundColor(.secondary)
                                                    } else {
                                                        Image(systemName: "chevron.right").foregroundColor(.secondary)
                                                    }
                                                }
                                            }
                                            if data.uxState.isMenstrualExpanded {
                                                //Divider()
                                                MenstrualView(timescale: timescale)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .onTapGesture(count: 2) {
                        withAnimation(.easeOut(duration: 1.0)) {
                            scrollView.scrollTo(0, anchor: .bottom)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("insights"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                    if data.processingTask != nil || health.processingTask != nil {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                }
            }
        }
    }
}
