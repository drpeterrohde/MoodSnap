import SwiftUI
import Charts

struct InsightsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var data: DataStoreStruct
    @State var timescale: Int = TimeScaleEnum.month.rawValue
    
    var body: some View {
        NavigationView {
            //ScrollView {
            VStack {
            Picker("", selection: $timescale) {
                Text("1mo").tag(TimeScaleEnum.month.rawValue)
                Text("3mo").tag(TimeScaleEnum.threeMonths.rawValue)
                Text("6mo").tag(TimeScaleEnum.sixMonths.rawValue)
                Text("1yr").tag(TimeScaleEnum.year.rawValue)
            }.pickerStyle(SegmentedPickerStyle())
                
                ScrollView(.vertical) {
            VStack{
                Group {
                    HStack{
                    Text("HISTORY")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.leading, 10)
                    .padding(.bottom, -5)
                    
                GroupBox {
                    HStack {
                        //Label("Average mood", systemImage: "brain.head.profile").font(.subheadline)
                        HStack {
                        Image(systemName: "brain.head.profile")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconWidth, height: iconWidth)
                            Text("Average mood").font(.subheadline)
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
                        //Label("Mood history", systemImage: "chart.bar.xaxis").font(.subheadline)
                        HStack {
                            Image(systemName: "chart.bar.xaxis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconWidth, height: iconWidth)
                            Text("Mood history").font(.subheadline)
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
                        //Label("Moving average", systemImage: "chart.line.uptrend.xyaxis").font(.subheadline)
                        HStack {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconWidth, height: iconWidth)
                            Text("Moving average").font(.subheadline)
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
                        //Label("Volatility", systemImage: "waveform.path.ecg").font(.subheadline)
                        HStack {
                            Image(systemName: "waveform.path.ecg")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconWidth, height: iconWidth)
                            Text("Volatility").font(.subheadline)
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
                            //Label("Volatility", systemImage: "waveform.path.ecg").font(.subheadline)
                            HStack {
                                Image(systemName: "chart.bar.doc.horizontal")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: iconWidth, height: iconWidth)
                                Text("Tally").font(.subheadline)
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
                    HStack{
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
                        //Label("Activities & social", systemImage: "eye").font(.subheadline)
                        HStack {
                            Image(systemName: "figure.walk")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconWidth, height: iconWidth)
                            Text("Activities").font(.subheadline)
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
                            //Label("Activities & social", systemImage: "eye").font(.subheadline)
                            HStack {
                                Image(systemName: "person.2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: iconWidth, height: iconWidth)
                                Text("Social").font(.subheadline)
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
                        //Label("Symptoms", systemImage: "heart.text.square").font(.subheadline)
                        HStack {
                            Image(systemName: "heart.text.square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconWidth, height: iconWidth)
                            Text("Symptoms").font(.subheadline)
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
                            //Label("Events", systemImage: "star.fill").font(.subheadline)
                            HStack {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: iconWidth, height: iconWidth)
                                Text("Events").font(.subheadline)
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
                            //Label("Symptoms", systemImage: "heart.text.square").font(.subheadline)
                            HStack {
                                Image(systemName: "number")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: iconWidth, height: iconWidth)
                                Text("Hashtags").font(.subheadline)
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
                        //Label("Butterfly average", systemImage: "waveform.path.ecg.rectangle").font(.subheadline)
                        HStack {
                            Image(systemName: "waveform.path.ecg.rectangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconWidth, height: iconWidth)
                            Text("Transients").font(.subheadline)
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
                        //InfluenceTransientView(timescale: timescale, data: data)
                        ButterflyAverageView(timescale: timescale, data: data)
                        EmptyView()
                    }
                }
                
//                Group {
//                    if (data.settings.healthWeightOn || data.settings.healthEnergyOn || data.settings.healthMenstrualOn || data.settings.healthSleepOn || data.settings.healthDistanceOn) {
//                    HStack{
//                        Text("HEALTH")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                        Spacer()
//                    }
//                    .padding(.leading, 10)
//                    .padding(.top, 2)
//                    .padding(.bottom, -5)
//                }
//                    
//                    if (data.settings.healthWeightOn) {
//                GroupBox {
//                    HStack {
//                        //Label("Weight", systemImage: "scalemass").font(.subheadline)
//                        HStack {
//                            Image(systemName: "scalemass")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: iconWidth, height: iconWidth)
//                            Text("Weight").font(.subheadline)
//                            Spacer()
//                        }
//                        Spacer()
//                        Button(action: {
//                            withAnimation(.easeInOut) {
//                                data.uxState.isWeightExpanded.toggle()
//                            }
//                        }) {
//                            if data.uxState.isWeightExpanded {
//                                Image(systemName: "chevron.down").foregroundColor(.secondary)
//                            } else {
//                                Image(systemName: "chevron.right").foregroundColor(.secondary)
//                            }
//                        }
//                    }
//                    if data.uxState.isWeightExpanded {
//                        Divider()
//                        WeightView(data: data)
//                    }
//                }
//                    }
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
//                    }
//                }
            }
            }
        }.navigationBarTitle(Text("Insights")).navigationBarTitleDisplayMode(.inline)
        }
    }
}
