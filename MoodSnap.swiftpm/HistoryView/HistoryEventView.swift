import SwiftUI

struct HistoryEventView: View {
    let moodSnap: MoodSnapStruct
    let data: DataStoreStruct
    
    var body: some View {
        Group {
            VStack(alignment: .center){
                Group {
                    Divider()
                        
                        Spacer().frame(height: 10)
                        Text(String(moodSnap.event)).font(.caption).fontWeight(.bold)
                    }
                
                if (!(String(moodSnap.notes).isEmpty)) {
                    Divider()
                    Spacer()
                    Text(String(moodSnap.notes)).font(.caption).padding(-5).frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
