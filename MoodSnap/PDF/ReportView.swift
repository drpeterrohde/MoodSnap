import PDFKit
import SwiftUI

struct ReportView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var data: DataStoreClass
    var timescale: Int
    var blackAndWhite: Bool

    var body: some View {
        let url = generatePDF(data: data, timescale: timescale, blackAndWhite: blackAndWhite)

        ZStack {
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
                    shareSheet(url: url)
                }) {
                    Image(systemName: "square.and.arrow.up.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: themes[data.settings.theme].controlBigIconSize, height: themes[data.settings.theme].controlBigIconSize)
                }.padding(.bottom, 20)
            }
        }
    }

    func shareSheet(url: URL?) {
        let activityVC = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        var topVC = window?.rootViewController
        while let presentedVC = topVC?.presentedViewController {
            topVC = presentedVC
        }
        topVC?.present(activityVC, animated: true, completion: nil)
    }
}
