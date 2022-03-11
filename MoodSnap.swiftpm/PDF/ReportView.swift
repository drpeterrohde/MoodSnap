import SwiftUI
import PDFKit

struct ReportView: View {
    @Environment(\.dismiss) var dismiss
    var data: DataStoreStruct
    
    var body: some View {
        let url = generatePDF(data: data)
        
        ZStack{
            PDFViewUI(pdfView: PDFView(), url: url)
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: themes[data.settings.theme].closeButtonIconSize, height: themes[data.settings.theme].closeButtonIconSize)
                        Spacer()
                    }.foregroundColor(.gray)
                    .padding([.top, .leading], 20)
                }
                Spacer()
                    Spacer()
                    Button(action: {
                        actionSheet(url: url)
                    }) {
                        Image(systemName: "square.and.arrow.up.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: themes[data.settings.theme].controlBigIconSize, height: themes[data.settings.theme].controlBigIconSize)
                    }.padding(.bottom, 20)
            }
        }
    }
    
    func actionSheet(url: URL?) {
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
        }
}
