import SwiftUI

/**
 View for help page.
 */
struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    GroupBox(label: Label("need_help", systemImage: "heart.fill").foregroundColor(themes[data.settings.theme].emergencyColor)) {
                        Divider()
                        VStack(alignment: .leading) {
                            Text(.init("emergency_string"))
                                .font(.subheadline)
                        }
                    }
                    
                    GroupBox(label: Label("how_to_use_moodsnap", systemImage: "info.circle").foregroundColor(themes[data.settings.theme].iconColor)) {
                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Text(.init("help_how_to_use_moodsnap_string"))
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    Group {
                        GroupBox(label: Label("controls", systemImage: "gearshape").foregroundColor(themes[data.settings.theme].iconColor)) {
                            Group {
                                Divider()
                                let gridItemLayout = Array(repeating: GridItem(.flexible()), count: 2)
                                LazyVGrid(columns: gridItemLayout, alignment: .leading, spacing: themes[data.settings.theme].historyGridSpacing) {
                                    Label("settings", systemImage: "slider.horizontal.3")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    Label("insights", systemImage: "waveform.path.ecg.rectangle")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    Label("add_event", systemImage: "star.square")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    Label("take_moodsnap", systemImage: "plus.circle")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    Label("diary_entry", systemImage: "note.text.badge.plus")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    Label("photo_diary", systemImage: "photo.on.rectangle.angled")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    Label("help", systemImage: "questionmark.circle")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    Label("save", systemImage: "arrowtriangle.right.circle")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                }
                            }
                            
                            Group {
                                Divider()
                                VStack(alignment: .leading) {
                                    Label("taking_moodsnaps", systemImage: "plus.circle")
                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                    Spacer()
                                    Text(.init("help_taking_moodsnaps_string"))
                                        .font(.subheadline)
                                }
                            }
                            
                            Group {
                                Divider()
                                VStack(alignment: .leading) {
                                    Label("events", systemImage: "star.square")
                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                    Spacer()
                                    Text(.init("help_events_string"))
                                        .font(.subheadline)
                                }
                            }
                            
                            Group {
                                Divider()
                                VStack(alignment: .leading) {
                                    Label("diary", systemImage: "note.text.badge.plus").foregroundColor(themes[data.settings.theme].iconColor)
                                    Spacer()
                                    Text(.init("help_notes_string"))
                                        .font(.subheadline)
                                }
                            }
                            
                            Group {
                                Divider()
                                VStack(alignment: .leading) {
                                    Label("photo_diary", systemImage: "photo.on.rectangle.angled")
                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                    Spacer()
                                    Text(.init("photo_diary_string"))
                                        .font(.subheadline)
                                }
                            }
                            
                            Group {
                                Divider()
                                VStack(alignment: .leading) {
                                    Label("settings", systemImage: "slider.horizontal.3")
                                        .foregroundColor(themes[data.settings.theme].iconColor)
                                    Spacer()
                                    Text(.init("help_settings_string"))
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    
                    Group {
                        GroupBox(label: Label("insights", systemImage: "waveform.path.ecg.rectangle")
                            .foregroundColor(themes[data.settings.theme].iconColor)) {
                                Group {
                                    Divider()
                                    Text(.init("statistics_intro_string"))
                                        .font(.subheadline)
                                }
                                
                                Group {
                                    Divider()
                                    VStack(alignment: .leading) {
                                        Label("average_mood", systemImage: "brain.head.profile")
                                            .foregroundColor(themes[data.settings.theme].iconColor)
                                        Spacer()
                                        Text(.init("average_mood_string"))
                                            .font(.subheadline)
                                        Image("average_mood")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                }
                                
                                Group {
                                    Divider()
                                    VStack(alignment: .leading) {
                                        Label("mood_history", systemImage: "chart.bar.xaxis")
                                            .foregroundColor(themes[data.settings.theme].iconColor)
                                        Spacer()
                                        Text(.init("statistics_mood_history_string"))
                                            .font(.subheadline)
                                        Image("mood_history")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                }
                                
                                Group {
                                    Divider()
                                    VStack(alignment: .leading) {
                                        Label("moving_average", systemImage: "chart.line.uptrend.xyaxis")
                                            .foregroundColor(themes[data.settings.theme].iconColor)
                                        Spacer()
                                        Text(.init("statistics_moving_average_string"))
                                            .font(.subheadline)
                                        Image("moving_average")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                }
                                
                                Group {
                                    Divider()
                                    VStack(alignment: .leading) {
                                        Label("volatility", systemImage: "waveform.path.ecg")
                                            .foregroundColor(themes[data.settings.theme].iconColor)
                                        Spacer()
                                        Text(.init("statistics_volatility_string_1"))
                                            .font(.subheadline)
                                        Image("volatility")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        Text(.init("statistics_volatility_string_2"))
                                            .font(.subheadline)
                                    }
                                }
                                
                                Group {
                                    Divider()
                                    VStack(alignment: .leading) {
                                        Label("tally", systemImage: "chart.bar.doc.horizontal")
                                            .foregroundColor(themes[data.settings.theme].iconColor)
                                        Spacer() // tally
                                        Text(.init("statistics_tally_string"))
                                            .font(.subheadline)
                                        Image("tally")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                }
                                
                                Group {
                                    Divider()
                                    VStack(alignment: .leading) {
                                        Label("influences", systemImage: "eye")
                                            .foregroundColor(themes[data.settings.theme].iconColor)
                                        Spacer()
                                        Text(.init("influences_string"))
                                            .font(.subheadline)
                                        Image("influences")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                }
                                
                                Group {
                                    Divider()
                                    VStack(alignment: .leading) {
                                        Label("transients", systemImage: "waveform.path.ecg.rectangle")
                                            .foregroundColor(themes[data.settings.theme].iconColor)
                                        Spacer()
                                        Text(.init("statistics_butterfly_average_string_1"))
                                            .font(.subheadline)
                                        Image("transients")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        Text(.init("statistics_butterfly_average_string_2"))
                                            .font(.subheadline)
                                    }
                                }
                                
                                Group {
                                    Divider()
                                    VStack(alignment: .leading) {
                                        Label("health_data", systemImage: "heart.text.square")
                                            .foregroundColor(themes[data.settings.theme].iconColor)
                                        Spacer()
                                        Text(.init("apple_health_info_1"))
                                            .font(.subheadline)
                                        Image("apple_health")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        Text(.init("apple_health_info_2"))
                                            .font(.subheadline)
                                    }
                                }
                            }
                    }
                    
                    GroupBox(label: Label("PDF_reports", systemImage: "doc").foregroundColor(themes[data.settings.theme].iconColor)) {
                        Divider()
                        VStack(alignment: .leading) {
                            Text(.init("pdf_report_string"))
                                .font(.subheadline)
                        }
                    }
                    
                    GroupBox(label: Label("privacy", systemImage: "lock.circle").foregroundColor(themes[data.settings.theme].iconColor)) {
                        Divider()
                        VStack(alignment: .leading) {
                            Text(.init("privacy_string"))
                                .font(.subheadline)
                        }
                    }
                    
                    GroupBox(label: Label("disclaimer", systemImage: "exclamationmark.circle").foregroundColor(themes[data.settings.theme].iconColor)) {
                        Divider()
                        VStack(alignment: .leading) {
                            Text(.init("disclaimer_string"))
                                .font(.subheadline)
                        }
                    }
                }
            }.navigationBarTitle(Text("information"))
        }
    }
}
