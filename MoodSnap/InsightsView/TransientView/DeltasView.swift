import SwiftUI

/**
 View for displaying an occurences summary.
 */
struct DeltasView: View {
    @Binding var selectedActivity: Int
    @Binding var selectedSocial: Int
    @Binding var selectedSymptom: Int
    @Binding var selectedEvent: Int
    @Binding var selectedHashtag: Int
    @Binding var selectionType: InfluenceTypeEnum
    @EnvironmentObject var data: DataStoreClass
    
    var body: some View {
        let butterfly = transientByType(
            type: selectionType,
            activity: selectedActivity,
            social: selectedSocial,
            symptom: selectedSymptom,
            event: selectedEvent,
            hashtag: selectedHashtag,
            processedData: data.processedData)
        
        if butterfly.deltas != nil {
            if displayActivities(delta: butterfly.deltas!) {
                DeltasActivityView(selectedActivity: $selectedActivity,
                                   selectedSocial: $selectedSocial,
                                   selectedSymptom: $selectedSymptom,
                                   selectedEvent: $selectedEvent,
                                   selectedHashtag: $selectedHashtag,
                                   selectionType: $selectionType)
            }
            
            if displaySocial(delta: butterfly.deltas!) {
                DeltasSocialView(selectedActivity: $selectedActivity,
                                 selectedSocial: $selectedSocial,
                                 selectedSymptom: $selectedSymptom,
                                 selectedEvent: $selectedEvent,
                                 selectedHashtag: $selectedHashtag,
                                 selectionType: $selectionType)
            }
            
            if displaySymptoms(delta: butterfly.deltas!) {
                DeltasSymptomView(selectedActivity: $selectedActivity,
                                  selectedSocial: $selectedSocial,
                                  selectedSymptom: $selectedSymptom,
                                  selectedEvent: $selectedEvent,
                                  selectedHashtag: $selectedHashtag,
                                  selectionType: $selectionType)
            }
            
            if displayHashtags(delta: butterfly.deltas!) {
                DeltasHashtagView(selectedActivity: $selectedActivity,
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
 Display a delta result?
 */
func displayDelta(before: Double, after: Double)  -> Bool {
    if before == 0 && after == 0 {
        return false
    } else {
        return true
    }
}

/**
 Display activites?
 */
func displayActivities(delta: OccurencesStruct) -> Bool {
    for i in 0 ..< delta.beforeActivities.count {
        if displayDelta(before: delta.beforeActivities[i], after: delta.afterActivities[i]) {
            return true
        }
    }
    
    return false
}

/**
 Display social?
 */
func displaySocial(delta: OccurencesStruct) -> Bool {
    for i in 0 ..< delta.beforeSocial.count {
        if displayDelta(before: delta.beforeSocial[i], after: delta.afterSocial[i]) {
            return true
        }
    }
    
    return false
}

/**
 Display symptoms?
 */
func displaySymptoms(delta: OccurencesStruct) -> Bool {
    for i in 0 ..< delta.beforeSymptoms.count {
        if displayDelta(before: delta.beforeSymptoms[i], after: delta.afterSymptoms[i]) {
            return true
        }
    }
    
    return false
}

/**
 Display hashtags?
 */
func displayHashtags(delta: OccurencesStruct) -> Bool {
    for i in 0 ..< delta.beforeHashtags.count {
        if delta.beforeHashtags[i] > 0 || delta.afterHashtags[i] > 0 {
            return true
        }
    }
    
    return false
}
