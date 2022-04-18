import Charts
import SwiftUI

/**
 View showing insights panel.
 */
struct InsightsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var data: DataStoreStruct
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
                                        Text("average_mood")
                                            .font(.subheadline)
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
                                    Divider()
                                    AverageMoodView(timescale: timescale, data: data)
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
                                        Text("mood_history")
                                            .font(.subheadline)
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
                                    Divider()
                                    MoodHistoryBarView(timescale: timescale, data: data)
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
                                        Text("moving_average")
                                            .font(.subheadline)
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
                                    Divider()
                                    SlidingAverageView(timescale: timescale, data: data)
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
                                        Text("volatility")
                                            .font(.subheadline)
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
                                    Divider()
                                    SlidingVolatilityView(timescale: timescale, data: data)
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
                                        Text("tally")
                                            .font(.subheadline)
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
                                    TallyView(timescale: timescale, data: data)
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
                                        Text("activities")
                                            .font(.subheadline)
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
                                    InfluencesActivityView(data: data)
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
                                        Text("social")
                                            .font(.subheadline)
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
                                    InfluencesSocialView(data: data)
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
                                        Text("symptoms")
                                            .font(.subheadline)
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
                                    InfluencesSymptomView(data: data)
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
                                        Text("events")
                                            .font(.subheadline)
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
                                    InfluencesEventsView(data: data)
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
                                        Text("hashtags")
                                            .font(.subheadline)
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
                                    InfluencesHashtagView(data: data)
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
                                    Text("transients")
                                        .font(.subheadline)
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
                                Divider()
                                TransientView(timescale: timescale, data: data)
                                EmptyView()
                            }
                        }

                        Group {
                            if data.settings.healthWeightOn || data.settings.healthEnergyOn || data.settings.healthMenstrualOn || data.settings.healthSleepOn || data.settings.healthDistanceOn {
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
                                                Text("Weight").font(.subheadline)
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
                                            if data.uxState.isWeightExpanded {
                                                Divider()
                                                WeightView(data: data)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("insights"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//
//                    if (data.settings.healthDistanceOn) {
//                GroupBox {
//                    HStack {
//                        //Label("Walking & running distance", systemImage: "figure.walk").font(.subheadline)
//                        HStack {
//                            Image(systemName: "figure.walk")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: iconWidth, height: iconWidth)
//                            Text("Walking & running distance").font(.subheadline)
//                            Spacer()
//                        }
//                        Spacer()
//                        Button(action: {
//                            withAnimation(.easeInOut) {
//                                data.uxState.isWalkingRunningDistanceExpanded.toggle()
//                            }
//                        }) {
//                            if data.uxState.isWalkingRunningDistanceExpanded {
//                                Image(systemName: "chevron.down").foregroundColor(.secondary)
//                            } else {
//                                Image(systemName: "chevron.right").foregroundColor(.secondary)
//                            }
//                        }
//                    }
//                    if data.uxState.isWalkingRunningDistanceExpanded {
//                        Divider()
//                        WalkingRunningDistanceView(data: data)
//                    }
//                }
//                    }
//
//                    if (data.settings.healthEnergyOn) {
//                    GroupBox {
//                        HStack {
//                            //Label("Active energy", systemImage: "flame").font(.subheadline)
//                            HStack {
//                                Image(systemName: "flame")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: iconWidth, height: iconWidth)
//                                Text("Active energy").font(.subheadline)
//                                Spacer()
//                            }
//                            Spacer()
//                            Button(action: {
//                                withAnimation(.easeInOut) {
//                                    data.uxState.isActiveEnergyExpanded.toggle()
//                                }
//                            }) {
//                                if data.uxState.isActiveEnergyExpanded {
//                                    Image(systemName: "chevron.down").foregroundColor(.secondary)
//                                } else {
//                                    Image(systemName: "chevron.right").foregroundColor(.secondary)
//                                }
//                            }
//                        }
//                        if data.uxState.isActiveEnergyExpanded {
//                            Divider()
//                            ActiveEnergyView(data: data)
//                        }
//                    }
//                    }
//
//                    if (data.settings.healthSleepOn) {
//                GroupBox {
//                    HStack {
//                        //Label("Sleep", systemImage: "bed.double").font(.subheadline)
//                        HStack {
//                            Image(systemName: "bed.double")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: iconWidth, height: iconWidth)
//                            Text("Sleep").font(.subheadline)
//                            Spacer()
//                        }
//                        Spacer()
//                        Button(action: {
//                            withAnimation(.easeInOut) {
//                                data.uxState.isSleepExpanded.toggle()
//                            }
//                        }) {
//                            if data.uxState.isSleepExpanded {
//                                Image(systemName: "chevron.down").foregroundColor(.secondary)
//                            } else {
//                                Image(systemName: "chevron.right").foregroundColor(.secondary)
//                            }
//                        }
//                    }
//                    if data.uxState.isSleepExpanded {
//                        Divider()
//                        SleepView(data: data)
//                    }
//                }
//                    }
//
//                    if (data.settings.healthMenstrualOn) {
//                    GroupBox {
//                        HStack {
//                            //Label("Menstrual cycle", systemImage: "alternatingcurrent").font(.subheadline)
//                            HStack {
//                                Image(systemName: "alternatingcurrent")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: iconWidth, height: iconWidth)
//                                Text("Menstrual cycle").font(.subheadline)
//                                Spacer()
//                            }
//                            Spacer()
//                            Button(action: {
//                                withAnimation(.easeInOut) {
//                                    data.uxState.isMenstrualExpanded.toggle()
//                                }
//                            }) {
//                                if data.uxState.isMenstrualExpanded {
//                                    Image(systemName: "chevron.down").foregroundColor(.secondary)
//                                } else {
//                                    Image(systemName: "chevron.right").foregroundColor(.secondary)
//                                }
//                            }
//                        }
//                        if data.uxState.isMenstrualExpanded {
//                            Divider()
//                            MenstrualView(data: data)
//                        }
//                    }
