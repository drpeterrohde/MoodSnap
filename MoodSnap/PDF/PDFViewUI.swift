import PDFKit
import SwiftUI

struct PDFViewUI: UIViewRepresentable {
    var pdfView: PDFView
    var url: URL?

    init(pdfView: PDFView, url: URL?) {
        self.pdfView = pdfView
        self.url = url
    }

    func makeUIView(context: Context) -> UIView {
        if let url = url {
            pdfView.document = PDFDocument(url: url)
        }

        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
