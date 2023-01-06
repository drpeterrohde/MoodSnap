import SwiftUI

/**
 View for displaying a tranisent.
 */
struct TransientWithPickerView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    @State private var selectedActivity: Int = 0
    @State private var selectedSocial: Int = 0
    @State private var selectedSymptom: Int = 0
    @State private var selectedEvent: Int = 0
    @State private var selectedHashtag: Int = 0
    @State private var selectionType: InfluenceTypeEnum = .activity
    @State private var drawerOpen: Bool = false
    
    var body: some View {
        let butterfly = transientByType(
            type: selectionType,
            activity: selectedActivity,
            social: selectedSocial,
            symptom: selectedSymptom,
            event: selectedEvent,
            hashtag: selectedHashtag,
            processedData: data.processedData)
        let (label, int) = transientLabel(selectionType: selectionType)
        let timeline = makeChartData(y: butterfly.timeline, timescale: timescale)
        
        VStack {
            VerticalBarChart(values: timeline,
                             color: themes[data.settings.theme].buttonColor,
                             min: 0,
                             max: 1,
                             settings: data.settings)
            .frame(height: 10)
            
            TransientView(butterfly: butterfly,
                          label: label,
                          timescale: 2 * int + 1)
            
            TransientReferencePickerView(selectedActivity: $selectedActivity,
                                         selectedSocial: $selectedSocial,
                                         selectedSymptom: $selectedSymptom,
                                         selectedEvent: $selectedEvent,
                                         selectedHashtag: $selectedHashtag,
                                         selectionType: $selectionType)
            
            Spacer()
            Button(action: {
                withAnimation(.easeInOut) {
                    drawerOpen.toggle()
                }
            }) {
                if drawerOpen {
                    Image(systemName: "chevron.down").foregroundColor(.secondary)
                } else {
                    Image(systemName: "chevron.right").foregroundColor(.secondary)
                }
            }
            
            if drawerOpen {
                Spacer()
                DeltasView(selectedActivity: $selectedActivity,
                           selectedSocial: $selectedSocial,
                           selectedSymptom: $selectedSymptom,
                           selectedEvent: $selectedEvent,
                           selectedHashtag: $selectedHashtag,
                           selectionType: $selectionType)
            }
        }
    }
}

/**
 Get axis label for `TransientView`.
 */
func transientLabel(selectionType: InfluenceTypeEnum) -> (String, Int) {
    var str: String = ""
    var int: Int = 0
    
    if selectionType == .event {
        str = "pm_30_days"
        int = butterflyWindowLong
    } else {
        str = "pm_7_days"
        int = butterflyWindowShort
    }
    
    return (str, int)
}
