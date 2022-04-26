import Charts
import SwiftUI

/**
 View for displaying a tranisent.
 */
struct TransientWithPickerView: View {
    var timescale: Int
    var data: DataStoreStruct
    @State private var selectedActivity: Int = 0
    @State private var selectedSocial: Int = 0
    @State private var selectedSymptom: Int = 0
    @State private var selectedEvent: Int = 0
    @State private var selectedHashtag: Int = 0
    @State private var selectionType: InfluenceTypeEnum = .activity

    var body: some View {
        let butterfly = transientByType(
            type: selectionType,
            activity: selectedActivity,
            social: selectedSocial,
            symptom: selectedSymptom,
            event: selectedEvent,
            hashtag: selectedHashtag,
            processedData: data.processedData)

        let label = transientLabel(selectionType: selectionType)

        VStack {
            TransientView(butterfly: butterfly,
                          label: label,
                          timescale: timescale,
                          data: data)
            TransientReferencePickerView(selectedActivity: $selectedActivity,
                                         selectedSocial: $selectedSocial,
                                         selectedSymptom: $selectedSymptom,
                                         selectedEvent: $selectedEvent,
                                         selectionType: $selectionType,
                                         data: data)
        }
    }
}

func transientLabel(selectionType: InfluenceTypeEnum) -> String {
    var str: String = ""

    if selectionType == .event {
        str = "pm_30_days"
    } else {
        str = "pm_7_days"
    }

    return str
}
