import SwiftUI

/**
 View showing menus for choosing point of reference for a `TransientView`.
 */
struct TransientReferencePickerView: View {
    @Binding var selectedActivity: Int
    @Binding var selectedSocial: Int
    @Binding var selectedSymptom: Int
    @Binding var selectedEvent: Int
    @Binding var selectionType: InfluenceTypeEnum
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        let eventsList = getEventsList(moodSnaps: data.moodSnaps)

        HStack {
            Picker("", selection: $selectionType) {
                Text("activity")
                    .tag(InfluenceTypeEnum.activity)
                Text("social")
                    .tag(InfluenceTypeEnum.social)
                Text("symptom")
                    .tag(InfluenceTypeEnum.symptom)
                if eventsList.count > 0 {
                    Text("event")
                        .tag(InfluenceTypeEnum.event)
                }
            }.padding(.leading, 10)

            Spacer()

            // Events
            if selectionType == InfluenceTypeEnum.event {
                Picker("", selection: $selectedEvent) {
                    ForEach(0 ..< eventsList.count, id: \.self) { i in
                        Text("\(eventsList[i].0) (\(eventsList[i].1.dateString()))")
                            .tag(i)
                    }
                }.padding(.trailing, 10)
            }

            // Social
            if selectionType == InfluenceTypeEnum.social {
                Picker("", selection: $selectedSocial) {
                    ForEach(0 ..< socialList.count, id: \.self) { i in
                        if data.settings.socialVisibility[i] {
                            Text(.init(socialList[i]))
                                .tag(i)
                        }
                    }
                }.padding(.trailing, 10)
            }

            // Activity
            if selectionType == InfluenceTypeEnum.activity {
                Picker("", selection: $selectedActivity) {
                    ForEach(0 ..< activityList.count, id: \.self) { i in
                        if data.settings.activityVisibility[i] {
                            Text(.init(activityList[i]))
                                .tag(i)
                        }
                    }
                }.padding(.trailing, 10)
            }

            // Symptoms
            if selectionType == InfluenceTypeEnum.symptom {
                Picker("", selection: $selectedSymptom) {
                    ForEach(0 ..< symptomList.count, id: \.self) { i in
                        if data.settings.symptomVisibility[i] {
                            Text(.init(symptomList[i]))
                                .tag(i)
                        }
                    }
                }.padding(.trailing, 10)
            }
        }
    }
}
