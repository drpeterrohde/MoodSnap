import SwiftUI
import TPPDF

func generatePDF(data: DataStoreClass, timescale: Int, blackAndWhite: Bool) -> URL? {
    let document = PDFDocument(format: .a4)
    document.info.author = "MoodSnap"
    document.info.title = "moodsnap_report"

    generatePDFContent(document: document,
                       data: data,
                       timescale: timescale,
                       blackAndWhite: blackAndWhite)

    let generator = PDFGenerator(document: document)
    var url: URL?

    do {
        try url = generator.generateURL(filename: "MoodSnap report.pdf")
    } catch {
        // print("PDF error")
    }

    return url
}

func generatePDFContent(document: PDFDocument, data: DataStoreClass, timescale: Int, blackAndWhite: Bool) {
    generateTitleHeaderFooterContent(document: document, data: data)
    generateInfluencesContent(document: document, data: data, timescale: timescale)
    generateAverageMoodContent(document: document, data: data, timescale: timescale, blackAndWhite: blackAndWhite)
    generateMoodContent(document: document, data: data, timescale: timescale, blackAndWhite: blackAndWhite)
    if data.settings.includeNotes {
        generateNotesContent(document: document, data: data, timescale: timescale)
    }
}

func generateTitleHeaderFooterContent(document: PDFDocument, data: DataStoreClass) {
    // Font styles
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let descriptorItalic = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withDesign(.serif)!.withSymbolicTraits(.traitItalic)
    let titleAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: titleFontSizePDF)]
    let headerAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorItalic!, size: headerFontSizePDF)]

    // Header
    var headerStr = NSLocalizedString("moodsnap_report", comment: "MoodSnap report")
    if data.settings.username != "" {
        headerStr += " for \(data.settings.username)"
    }
    headerStr += " " + Date().dateTimeString()
    let attributedHeader = NSAttributedString(string: headerStr, attributes: headerAttributes)
    var textElement = PDFAttributedText(text: attributedHeader)
    document.add(.headerCenter, attributedTextObject: textElement)

    // Footer
    //let footerStr = NSLocalizedString("report_generated_on", comment: "Report generated on ") + " " + Date().dateTimeString()
    let footerStr = NSLocalizedString("interpretation_guide_at", comment: "Interpretation guide ")
    
    let attributedFooter = NSAttributedString(string: footerStr, attributes: headerAttributes)
    textElement = PDFAttributedText(text: attributedFooter)
    document.add(.footerRight, attributedTextObject: textElement)

    // Title
    let attributedTitle = NSAttributedString(string: NSLocalizedString("moodsnap_report", comment: "MoodSnap report") + "\n", attributes: titleAttributes)
    textElement = PDFAttributedText(text: attributedTitle)
    document.add(.contentCenter, attributedTextObject: textElement)
}

func generateMoodContent(document: PDFDocument, data: DataStoreClass, timescale: Int, blackAndWhite: Bool) {
    let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5)

    // Font styles
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let subtitleAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: subtitleFontSizePDF)]
    let bodyAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: bodyFontSizePDF)]
    let notesAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: notesFontSizePDF)]
    let attributedStatistics = NSAttributedString(string: "\n" + NSLocalizedString("analysis", comment: "Analysis") + "\n", attributes: subtitleAttributes)

    for mood in MoodsEnum.allCases {
        document.createNewPage()

        // Statistics
        var textElement = PDFAttributedText(text: attributedStatistics)
        document.add(.contentLeft, attributedTextObject: textElement)

        document.addLineSeparator(PDFContainer.contentLeft, style: lineStyle)

        // Mood type
        let attributedElevation = NSAttributedString(string: "\n" + NSLocalizedString(moodLabels[mood.rawValue], comment: "EDAI"), attributes: bodyAttributes)
        textElement = PDFAttributedText(text: attributedElevation)
        document.add(.contentLeft, attributedTextObject: textElement)

        // Mood level

        let moodLevelsAttributedString = NSAttributedString(string: NSLocalizedString("mood_levels", comment: "Mood levels"), attributes: notesAttributes)
        textElement = PDFAttributedText(text: moodLevelsAttributedString)
        document.add(.contentCenter, attributedTextObject: textElement)

        let pageSize = document.layout.size
        let pageMargin = document.layout.margin
        let pageWidth = pageSize.width - pageMargin.left - pageMargin.right
        let pageHeight = pageSize.height - pageMargin.top - pageMargin.bottom
        let graphHeight = pageHeight / 5

        let view1 = PDFSingleMoodHistoryBarView(type: mood,
                                                timescale: timescale,
                                                blackAndWhite: blackAndWhite)
            .environmentObject(data)
            .frame(width: pageWidth)
            .background(Color.white)
        let image1 = view1.asImage()
        addImage(document: document,
                 image: image1,
                 width: pageWidth,
                 height: graphHeight)

        // Sliding average

        let slidingAverageAttributedString = NSAttributedString(string: NSLocalizedString("sliding_average", comment: "Sliding average"), attributes: notesAttributes)
        textElement = PDFAttributedText(text: slidingAverageAttributedString)
        document.add(.contentCenter, attributedTextObject: textElement)

        let view2 = PDFSingleSlidingAverageView(type: mood, timescale: timescale, blackAndWhite: blackAndWhite)
            .environmentObject(data)
            .frame(width: 400)
            .background(Color.white)
        let image2 = view2.asImage()
        addImage(document: document, image: image2, width: pageWidth, height: graphHeight)

        // Volatility

        let volatilityAttributedString = NSAttributedString(string: NSLocalizedString("volatility", comment: "Volatility"), attributes: notesAttributes)
        textElement = PDFAttributedText(text: volatilityAttributedString)
        document.add(.contentCenter, attributedTextObject: textElement)

        let view3 = PDFSingleSlidingVolatilityView(type: mood, timescale: timescale, blackAndWhite: blackAndWhite)
            .environmentObject(data)
            .frame(width: 400)
            .background(Color.white)
        let image3 = view3.asImage()
        addImage(document: document, image: image3, width: pageWidth, height: graphHeight)
    }
}

func generateInfluencesContent(document: PDFDocument, data: DataStoreClass, timescale: Int) {
    let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5)

    // Font styles
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let subtitleAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: subtitleFontSizePDF)]
    let bodyAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: bodyFontSizePDF)]
    let notesAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: notesFontSizePDF)]

    // Statistics
    let attributedStatistics = NSAttributedString(string: "\n" + NSLocalizedString("insights", comment: "Insights") + "\n", attributes: subtitleAttributes)
    var textElement = PDFAttributedText(text: attributedStatistics)
    document.add(.contentLeft, attributedTextObject: textElement)

    document.addLineSeparator(PDFContainer.contentLeft, style: lineStyle)

    // Influences

    let attributedInfluences = NSAttributedString(string: "\n" + NSLocalizedString("influences", comment: "Influences") + "\n\n", attributes: bodyAttributes)
    textElement = PDFAttributedText(text: attributedInfluences)

    document.add(.contentLeft, attributedTextObject: textElement)

    let attributedElevation = NSAttributedString(string: NSLocalizedString("mood_level_mood_volatility", comment: "Mood level / Mood volatility") + "\n", attributes: notesAttributes)
    textElement = PDFAttributedText(text: attributedElevation)
    document.add(.contentLeft, attributedTextObject: textElement)

    // Table
    let table = PDFTable(rows: activityList.count + socialList.count + 1, columns: 5)
    var tableContent: PDFTableContent

    let tableStyle = PDFTableStyleDefaults.simple
    table.style = tableStyle
    table.widths = [0.2, 0.2, 0.2, 0.2, 0.2]

    // Column labels
    let columnLabels = ["activity", "elevation", "depression", "anxiety", "irritability"]

    for column in 0 ... 4 {
        let cell = table[0, column]
        cell.style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), font: UIFont.systemFont(ofSize: 8, weight: .bold))
        do {
            try tableContent = PDFTableContent(content: NSLocalizedString(columnLabels[column], comment: ""))
            cell.content = tableContent
        } catch {
            // print("PDF table eror")
        }
    }

    // Cells (activity)
    for activityCount in 0 ..< activityList.count {
        let cell = table[activityCount + 1, 0]
        cell.style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), font: UIFont.systemFont(ofSize: 8))

        // Activity labels
        do {
            try tableContent = PDFTableContent(content: NSLocalizedString(activityList[activityCount], comment: ""))
            cell.content = tableContent
        } catch {
            // print("PDF table eror")
        }

        // Numerical cells
        for moodCount in 1 ... 4 {
            let cell = table[activityCount + 1, moodCount]
            do {
                let str = formatMoodLevelString(value: data.processedData.activityButterfly[activityCount].influence()[moodCount - 1]) + "/" + formatMoodLevelString(value: data.processedData.activityButterfly[activityCount].influence()[moodCount + 3]) // only has activities ???
                try tableContent = PDFTableContent(content: NSLocalizedString(str, comment: ""))
                cell.content = tableContent
                cell.style = PDFTableCellStyle(font: UIFont.monospacedSystemFont(ofSize: 8, weight: .regular))
            } catch {
                // print("PDF table eror")
            }
        }
    }

    // Cells (social)
    for socialCount in 0 ..< socialList.count {
        let cell = table[socialCount + activityList.count + 1, 0]
        cell.style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), font: UIFont.systemFont(ofSize: 8))

        // Activity labels
        do {
            try tableContent = PDFTableContent(content: NSLocalizedString(socialList[socialCount], comment: ""))
            cell.content = tableContent
        } catch {
            // print("PDF table eror")
        }

        // Numerical cells
        for moodCount in 1 ... 4 {
            let cell = table[socialCount + activityList.count + 1, moodCount]
            do {
                let str = formatMoodLevelString(value: data.processedData.activityButterfly[socialCount].influence()[moodCount - 1]) + "/" + formatMoodLevelString(value: data.processedData.activityButterfly[socialCount].influence()[moodCount + 3]) // only has activities ???
                try tableContent = PDFTableContent(content: str)
                cell.content = tableContent
                cell.style = PDFTableCellStyle(font: UIFont.monospacedSystemFont(ofSize: 8, weight: .regular))
            } catch {
                // print("PDF table eror")
            }
        }
    }

    document.add(.contentCenter, table: table)
}

func generateAverageMoodContent(document: PDFDocument, data: DataStoreClass, timescale: Int, blackAndWhite: Bool) {
    let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5)

    // Font styles
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let bodyAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: bodyFontSizePDF)]

    let pageSize = document.layout.size
    let pageMargin = document.layout.margin
    let pageWidth = pageSize.width - pageMargin.left - pageMargin.right

    document.addLineSeparator(PDFContainer.contentLeft, style: lineStyle)

    let attributedMood = NSAttributedString(string: "\n" + NSLocalizedString("average_mood_volatility", comment: "Average mood level / volatility") + "\n", attributes: bodyAttributes)
    let textElement = PDFAttributedText(text: attributedMood)
    document.add(.contentLeft, attributedTextObject: textElement)

    let view1 = PDFAverageMoodView(timescale: timescale, blackAndWhite: blackAndWhite)
        .environmentObject(data)
        .frame(width: 400, height: 200)
        .background(Color.white)
    let image1 = view1.asImage()
    addImage(document: document, image: image1, width: pageWidth / 2)

    // Bar chart summary

    let attributedLevels = NSAttributedString(string: "\n" + NSLocalizedString("mood_history", comment: "Mood history") + "\n", attributes: bodyAttributes)
    let textElement2 = PDFAttributedText(text: attributedLevels)
    document.add(.contentLeft, attributedTextObject: textElement2)

    let view2 = PDFMoodHistoryBarView(timescale: timescale, blackAndWhite: blackAndWhite)
        .environmentObject(data)
        .frame(width: 500)
        .background(Color.white)
    let image2 = view2.asImage()
    addImage(document: document, image: image2, width: pageWidth / 2)
}

func generateNotesContent(document: PDFDocument, data: DataStoreClass, timescale: Int) {
    let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5)
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let subtitleAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: subtitleFontSizePDF)]

    document.createNewPage()

    let attributedSubtitle = NSAttributedString(string: "\n" + NSLocalizedString("notes", comment: "Notes") + "\n", attributes: subtitleAttributes)
    let notesAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: notesFontSizePDF)]
    let textElement = PDFAttributedText(text: attributedSubtitle)
    document.add(.contentLeft, attributedTextObject: textElement)

    document.addLineSeparator(PDFContainer.contentLeft, style: lineStyle)

    for moodSnap in data.moodSnaps {
        if moodSnap.notes != "" && moodSnap.snapType != .quote && moodSnap.snapType != .custom {
            let attributedNotes = NSAttributedString(string: "\n" + moodSnap.timestamp.dateTimeString() + "\n" + moodSnap.notes + "\n", attributes: notesAttributes)
            let textElement = PDFAttributedText(text: attributedNotes)
            document.add(.contentLeft, attributedTextObject: textElement)
        }
    }
}

//func generateInterpretationGuideContent(document: PDFDocument, data: DataStoreClass) {
//    document.createNewPage()
//
//    let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5)
//    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
//        .withDesign(.serif)
//    let subtitleAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: subtitleFontSizePDF)]
//
//    let attributedSubtitle = NSAttributedString(string: "\n" + NSLocalizedString("interpretation_guide", comment: "") + "\n", attributes: subtitleAttributes)
//    let notesAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: notesFontSizePDF)]
//    var textElement = PDFAttributedText(text: attributedSubtitle)
//    document.add(.contentLeft, attributedTextObject: textElement)
//
//    document.addLineSeparator(PDFContainer.contentLeft, style: lineStyle)
//
//    let attributedNotes = NSAttributedString(string: NSLocalizedString("notes_on_interpretation_string", comment: ""), attributes: notesAttributes)
//
//    textElement = PDFAttributedText(text: attributedNotes)
//    document.add(.contentLeft, attributedTextObject: textElement)
//}

func addImage(document: PDFDocument, image: UIImage, width: CGFloat? = nil, height: CGFloat? = nil) {
    if width == nil {
        let imageElement = PDFImage(image: image, sizeFit: .width, quality: 1.0)
        document.add(image: imageElement)
    } else {
        let aspectRatio: CGFloat = image.size.width / image.size.height
        var imageSize: CGSize
        if height == nil {
            imageSize = CGSize(width: width!, height: width! / aspectRatio)
        } else {
            imageSize = CGSize(width: width!, height: height!)
        }
        let imageElement = PDFImage(image: image, size: imageSize, quality: 1.0)
        document.add(.contentCenter, image: imageElement)
    }
}
