import SwiftUI

struct PDFAverageMoodView: View {
    var timescale: Int
    var data: DataStoreStruct
    var blackAndWhite: Bool = true
    
    var body: some View {
        HStack {
        Group {
            VStack {
                //if (data.moodSnaps.count == 0) {
                //Text("Insufficient data")
                //.font(.caption)
                //.foregroundColor(.secondary)
                //} else {
            //if blackAndWhite {
                Label("Mood levels", systemImage: "brain.head.profile")
                    .font(.caption)
                    .foregroundColor(.black)
            //} else {
            //Label("Mood levels", systemImage: "brain.head.profile")
            //.font(.caption)
            //.foregroundColor(.secondary)
                //}
            
            let averageMoodSnap = averageMoodSnap(
                timescale: timescale,
                data: data)
            
            if (averageMoodSnap != nil) {
                MoodLevelsView(moodSnap: averageMoodSnap!,
                               data: data, 
                               blackAndWhite: blackAndWhite)
            } else {
                VStack(alignment: .center) {
                    Text("Insufficient data")
                        .foregroundColor(.secondary)
                }
            }
        }
            }
            
            Group {
                VStack {
                    //if blackAndWhite {
                Label("Volatility", systemImage: "waveform.path.ecg")
                    .font(.caption)
                    .foregroundColor(.black)
                    //} else {
                    //Label("Volatility", systemImage: "waveform.path.ecg")
                    //.font(.caption)
                    //.foregroundColor(.secondary)
                
                    //}
                    
            let averageVolatilitySnap = averageVolatilitySnap(
                timescale: timescale, 
                data: data)
            if (averageVolatilitySnap != nil) {
                Divider()
                MoodLevelsView(moodSnap: averageVolatilitySnap!, 
                               data: data, 
                               blackAndWhite: blackAndWhite)
            } else {
                VStack(alignment: .center) {
                    Text("Insufficient data")
                        .foregroundColor(.secondary)
                }
            }
                    //}
        }
        }
        }
    }
}
