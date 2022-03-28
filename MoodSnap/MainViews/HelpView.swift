import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var data: DataStoreStruct

    var body: some View {
        NavigationView {
            ScrollView {
                GroupBox(label: Label("Need help?", systemImage: "heart.fill").foregroundColor(themes[data.settings.theme].emergencyColor)) {
                    Divider()
                    VStack(alignment: .leading) {
                        Text(.init(emergency_string)).font(.subheadline)
                    }
                }

                GroupBox(label: Label("How to use MoodSnap", systemImage: "info.circle").foregroundColor(themes[data.settings.theme].iconColor)) {
                    Group {
                        Divider()
                        VStack(alignment: .leading) {
                            Text(.init(help_how_to_use_moodsnap_string)).font(.subheadline)
                        }
                    }
                }

                Group {
                    GroupBox(label: Label("Controls", systemImage: "gearshape").foregroundColor(themes[data.settings.theme].iconColor)) {
                        Group {
                            Divider()
                            let gridItemLayout = Array(repeating: GridItem(.flexible()), count: 2)
                            LazyVGrid(columns: gridItemLayout, alignment: .leading, spacing: themes[data.settings.theme].historyGridSpacing) {
                                Label("Settings", systemImage: "slider.horizontal.3")
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                                Label("Insights", systemImage: "waveform.path.ecg.rectangle")
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                                Label("Add event", systemImage: "star.square")
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                                Label("Take MoodSnap", systemImage: "plus.circle")
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                                Label("Diary entry", systemImage: "note.text.badge.plus")
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                                Label("Photo diary", systemImage: "photo.on.rectangle.angled")
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                                Label("Help", systemImage: "questionmark.circle")
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                            }
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Taking MoodSnaps", systemImage: "plus.circle").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(help_taking_moodsnaps_string)).font(.subheadline)
                            }
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Events", systemImage: "star.square").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(help_events_string)).font(.subheadline)
                            }
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Diary", systemImage: "note.text.badge.plus").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(help_notes_string)).font(.subheadline)
                            }
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Photo diary", systemImage: "photo.on.rectangle.angled").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(photo_diary_string)).font(.subheadline)
                            }
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Settings", systemImage: "slider.horizontal.3").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(help_settings_string)).font(.subheadline)
                            }
                        }
                    }
                }

                Group {
                    GroupBox(label: Label("Insights", systemImage: "waveform.path.ecg.rectangle").foregroundColor(themes[data.settings.theme].iconColor)) {
                        Group {
                            Divider()
                            Text(.init(statistics_intro_string)).font(.subheadline)
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Average mood", systemImage: "brain.head.profile").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(average_mood_string)).font(.subheadline)
                                Image("average_mood")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Mood history", systemImage: "chart.bar.xaxis").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(statistics_mood_history_string)).font(.subheadline)
                                Image("mood_history")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Moving average", systemImage: "chart.line.uptrend.xyaxis").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(statistics_moving_average_string)).font(.subheadline)
                                Image("moving_average")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Volatility", systemImage: "waveform.path.ecg").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(statistics_volatility_string_1)).font(.subheadline)
                                Image("volatility")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text(.init(statistics_volatility_string_2)).font(.subheadline)
                            }
                        }
                        
                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Tally", systemImage: "chart.bar.doc.horizontal").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer() //tally
                                Text(.init(statistics_tally_string)).font(.subheadline)
                                Image("tally")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Influences", systemImage: "eye").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(influences_string)).font(.subheadline)
                                Image("influences")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }

                        Group {
                            Divider()
                            VStack(alignment: .leading) {
                                Label("Transients", systemImage: "waveform.path.ecg.rectangle").foregroundColor(themes[data.settings.theme].iconColor)
                                Spacer()
                                Text(.init(statistics_butterfly_average_string_1)).font(.subheadline)
                                Image("transients")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text(.init(statistics_butterfly_average_string_2)).font(.subheadline)
                            }
                        }
                    }
                }

                GroupBox(label: Label("PDF reports", systemImage: "doc").foregroundColor(themes[data.settings.theme].iconColor)) {
                    Divider()
                    VStack(alignment: .leading) {
                        Text(.init(pdf_report_string)).font(.subheadline)
                    }
                }

                GroupBox(label: Label("Privacy", systemImage: "lock.circle").foregroundColor(themes[data.settings.theme].iconColor)) {
                    Divider()
                    VStack(alignment: .leading) {
                        Text(.init(privacy_string)).font(.subheadline)
                    }
                }

                GroupBox(label: Label("Disclaimer", systemImage: "exclamationmark.circle").foregroundColor(themes[data.settings.theme].iconColor)) {
                    Divider()
                    VStack(alignment: .leading) {
                        Text(.init(disclaimer_string)).font(.subheadline)
                    }
                }
            }.navigationBarTitle(Text("Information"))
        }
    }
}
