import SwiftUI
import TPPDF

func generatePDF(data: DataStoreStruct, timescale: Int = TimeScaleEnum.month.rawValue, blackAndWhite: Bool) -> URL? {
    let document = PDFDocument(format: .a4)
    document.info.author = "MoodSnap"
    document.info.title = "MoodSnap report"
    
    generatePDFContent(document: document, data: data, timescale: timescale, blackAndWhite: blackAndWhite)
    
    let generator = PDFGenerator(document: document)
    var url: URL? = nil
    
    do {
        try url = generator.generateURL(filename: "MoodSnap report.pdf")
    } catch {
        print("PDF error")
    }
    
    return url
}

func generatePDFContent(document: PDFDocument, data: DataStoreStruct, timescale: Int = TimeScaleEnum.month.rawValue, blackAndWhite: Bool) {
    generateTitleHeaderFooterContent(document: document, data: data)
    generateInfluencesContent(document: document, data: data, timescale: timescale)
    generateAverageMoodContent(document: document, data: data, timescale: timescale, blackAndWhite: blackAndWhite)
    generateInterpretationGuideContent(document: document, data: data)
    generateMoodContent(document: document, data: data, timescale: timescale, blackAndWhite: blackAndWhite)
    if (data.settings.includeNotes) {
        generateNotesContent(document: document, data: data, timescale: timescale)
    }
}

func generateTitleHeaderFooterContent(document: PDFDocument, data: DataStoreStruct) {
    // Font styles
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let descriptorItalic = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withDesign(.serif)!.withSymbolicTraits(.traitItalic)
    let titleAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: titleFontSizePDF)]
    let headerAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorItalic!, size: headerFontSizePDF)]
    
    // Header
    var headerStr = "MoodSnap report"
    if (data.settings.username != "") {
        headerStr += " for \(data.settings.username)"
    }
    let attributedHeader = NSAttributedString(string: headerStr, attributes: headerAttributes)
    var textElement = PDFAttributedText(text: attributedHeader)
    document.add(.headerCenter, attributedTextObject: textElement)
    
    // Footer
    let footerStr = "Report generated on " + Date().dateTimeString()
    
    let attributedFooter = NSAttributedString(string: footerStr, attributes: headerAttributes)
    textElement = PDFAttributedText(text: attributedFooter)
    document.add(.footerRight, attributedTextObject: textElement)
    
    // Title
    let attributedTitle = NSAttributedString(string: "MoodSnap report\n", attributes: titleAttributes)
    textElement = PDFAttributedText(text: attributedTitle)
    document.add(.contentCenter, attributedTextObject: textElement)
}

func generateMoodContent(document: PDFDocument, data: DataStoreStruct, timescale: Int = TimeScaleEnum.month.rawValue, blackAndWhite: Bool) {
    let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5)
    
    // Font styles
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let subtitleAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: subtitleFontSizePDF)]
    let bodyAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: bodyFontSizePDF)]
    let notesAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: notesFontSizePDF)]
    let attributedStatistics = NSAttributedString(string: "\nAnalysis\n", attributes: subtitleAttributes)
    
    for mood in MoodsEnum.allCases {
        document.createNewPage()
        
        // Statistics
        var textElement = PDFAttributedText(text: attributedStatistics)
        document.add(.contentLeft, attributedTextObject: textElement)
        
        document.addLineSeparator(PDFContainer.contentLeft, style: lineStyle)
        
        // Mood type
        let attributedElevation = NSAttributedString(string: "\n" + moodLabels[mood.rawValue], attributes: bodyAttributes)
        textElement = PDFAttributedText(text: attributedElevation)
        document.add(.contentLeft, attributedTextObject: textElement)
        
        // Mood level
        
        let moodLevelsAttributedString = NSAttributedString(string: "Mood levels", attributes: notesAttributes)
        textElement = PDFAttributedText(text: moodLevelsAttributedString)
        document.add(.contentCenter, attributedTextObject: textElement)
        
        let pageSize = document.layout.size
        let pageMargin = document.layout.margin
        let pageWidth = pageSize.width - pageMargin.left - pageMargin.right
        let pageHeight = pageSize.height - pageMargin.top - pageMargin.bottom
        let graphHeight = pageHeight/5
        
        let view1 = PDFSingleMoodHistoryBarView(type: mood, timescale: timescale, data: data, blackAndWhite: blackAndWhite)
            .frame(width: pageWidth)
            .background(Color.white)
        let image1 = view1.asImage()
        addImage(document: document, image: image1, width: pageWidth, height: graphHeight)
        
        // Sliding average
        
        let slidingAverageAttributedString = NSAttributedString(string: "Sliding average", attributes: notesAttributes)
        textElement = PDFAttributedText(text: slidingAverageAttributedString)
        document.add(.contentCenter, attributedTextObject: textElement)
        
        let view2 = PDFSingleSlidingAverageView(type: mood, timescale: timescale, data: data, blackAndWhite: blackAndWhite).frame(width: 400).background(Color.white)
        let image2 = view2.asImage()
        addImage(document: document, image: image2, width: pageWidth, height: graphHeight)
        
        // Volatility
        
        let volatilityAttributedString = NSAttributedString(string: "Volatility", attributes: notesAttributes)
        textElement = PDFAttributedText(text: volatilityAttributedString)
        document.add(.contentCenter, attributedTextObject: textElement)
        
        let view3 = PDFSingleSlidingVolatilityView(type: mood, timescale: timescale, data: data, blackAndWhite: blackAndWhite).frame(width: 400).background(Color.white)
        let image3 = view3.asImage()
        addImage(document: document, image: image3, width: pageWidth, height: graphHeight)
    }
}

func generateInfluencesContent(document: PDFDocument, data: DataStoreStruct, timescale: Int = TimeScaleEnum.month.rawValue) {
    let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5)
    
    // Font styles
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let subtitleAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: subtitleFontSizePDF)]
    let bodyAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: bodyFontSizePDF)]
    let notesAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: notesFontSizePDF)]
    
    // Statistics
    let attributedStatistics = NSAttributedString(string: "\nStatistics\n", attributes: subtitleAttributes)
    var textElement = PDFAttributedText(text: attributedStatistics)
    document.add(.contentLeft, attributedTextObject: textElement)
    
    document.addLineSeparator(PDFContainer.contentLeft, style: lineStyle)
    
    // Influences
    
    let attributedInfluences = NSAttributedString(string: "\nInfluences\n\n", attributes: bodyAttributes)
    textElement = PDFAttributedText(text: attributedInfluences)
    
    document.add(.contentLeft, attributedTextObject: textElement)
    
    let attributedElevation = NSAttributedString(string: "Mood level / Mood volatility", attributes: notesAttributes)
    textElement = PDFAttributedText(text: attributedElevation)
    document.add(.contentLeft, attributedTextObject: textElement)
    
    // Table
    let table = PDFTable(rows: activityList.count + socialList.count + 1, columns: 5)
    var tableContent: PDFTableContent
    
    let tableStyle = PDFTableStyleDefaults.simple
    table.style = tableStyle
    table.widths = [0.2, 0.2, 0.2, 0.2, 0.2]
    
    // Column labels
    let columnLabels = ["Activity", "Elevation", "Depression", "Anxiety", "Irritability"]
    
    for column in 0...4 {
        let cell = table[0,column]
        cell.style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), font: UIFont.systemFont(ofSize: 8, weight: .bold))
        do {
            try tableContent = PDFTableContent(content: columnLabels[column])
            cell.content = tableContent
        } catch {
            print("PDF table eror")
        }
    }
    
    // Cells (activity)
    for activityCount in 0..<activityList.count {
        let cell = table[activityCount+1,0]
        cell.style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), font: UIFont.systemFont(ofSize: 10))
        
        // Activity labels
        do {
            try tableContent = PDFTableContent(content: activityList[activityCount])
            cell.content = tableContent
        } catch {
            print("PDF table eror")
        }
        
        // Numerical cells
        for moodCount in 1...4 {
            let cell = table[activityCount+1,moodCount]
            do {
                let str = formatMoodLevelString(value: data.processedData.activityButterfly[activityCount].influence()[moodCount-1]) + "/" + formatMoodLevelString(value: data.processedData.activityButterfly[activityCount].influence()[moodCount+3]) // only has activities ???
                try tableContent = PDFTableContent(content: str)
                cell.content = tableContent
                cell.style = PDFTableCellStyle(font: UIFont.monospacedSystemFont(ofSize: 10, weight: .regular))
            } catch {
                print("PDF table eror")
            }
        }
    }
    
    // Cells (social)
    for socialCount in 0..<socialList.count {
        let cell = table[socialCount+activityList.count+1,0]
        cell.style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), font: UIFont.systemFont(ofSize: 10))
        
        // Activity labels
        do {
            try tableContent = PDFTableContent(content: socialList[socialCount])
            cell.content = tableContent
        } catch {
            print("PDF table eror")
        }
        
        // Numerical cells
        for moodCount in 1...4 {
            let cell = table[socialCount+activityList.count+1,moodCount]
            do {
                let str = formatMoodLevelString(value: data.processedData.activityButterfly[socialCount].influence()[moodCount-1]) + "/" + formatMoodLevelString(value: data.processedData.activityButterfly[socialCount].influence()[moodCount+3]) // only has activities ???
                try tableContent = PDFTableContent(content: str)
                cell.content = tableContent
                cell.style = PDFTableCellStyle(font: UIFont.monospacedSystemFont(ofSize: 10, weight: .regular))
            } catch {
                print("PDF table eror")
            }
        }
    }
    
    document.add(.contentCenter, table: table)
}

func generateAverageMoodContent(document: PDFDocument, data: DataStoreStruct, timescale: Int = TimeScaleEnum.month.rawValue, blackAndWhite: Bool) {
    let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5)
    
    // Font styles
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let bodyAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: bodyFontSizePDF)]
    
    let pageSize = document.layout.size
    let pageMargin = document.layout.margin
    let pageWidth = pageSize.width - pageMargin.left - pageMargin.right
    
    document.addLineSeparator(PDFContainer.contentLeft, style: lineStyle)
    
    let attributedMood = NSAttributedString(string: "\nAverage mood level / volatility\n", attributes: bodyAttributes)
    let textElement = PDFAttributedText(text: attributedMood)
    document.add(.contentLeft, attributedTextObject: textElement)
    
    let view1 = PDFAverageMoodView(timescale: timescale, data: data, blackAndWhite: blackAndWhite)
        .frame(width: 400, height: 200)
        .background(Color.white)
    let image1 = view1.asImage()
    addImage(document: document, image: image1, width: pageWidth/2)
    
    // Bar chart summary
    
    let attributedLevels = NSAttributedString(string: "\nMood history\n", attributes: bodyAttributes)
    let textElement2 = PDFAttributedText(text: attributedLevels)
    document.add(.contentLeft, attributedTextObject: textElement2)
    
    let view2 = PDFMoodHistoryBarView(timescale: timescale, data: data, blackAndWhite: blackAndWhite)
        .frame(width: 400)
        .background(Color.white)
    let image2 = view2.asImage()
    addImage(document: document, image: image2, width: pageWidth/2)
}

func generateNotesContent(document: PDFDocument, data: DataStoreStruct, timescale: Int = TimeScaleEnum.month.rawValue) {
    let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5)
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let subtitleAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: subtitleFontSizePDF)]
    
    document.createNewPage()
    
    let attributedSubtitle = NSAttributedString(string: "\nNotes\n", attributes: subtitleAttributes)
    let notesAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: notesFontSizePDF)]
    let textElement = PDFAttributedText(text: attributedSubtitle)
    document.add(.contentLeft, attributedTextObject: textElement)
    
    document.addLineSeparator(PDFContainer.contentLeft, style: lineStyle)
    
    for moodSnap in sortByDate(moodSnaps: data.moodSnaps) {
        if (moodSnap.notes != "") {
            let attributedNotes = NSAttributedString(string: "\n" + moodSnap.timestamp.dateTimeString() + "\n" + moodSnap.notes + "\n", attributes: notesAttributes)
            let textElement = PDFAttributedText(text: attributedNotes)
            document.add(.contentLeft, attributedTextObject: textElement)
        }
    }
}

func generateInterpretationGuideContent(document: PDFDocument, data: DataStoreStruct) {
    document.createNewPage()
    
    let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5)
    let descriptorBody = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        .withDesign(.serif)
    let subtitleAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: subtitleFontSizePDF)]
    
    let attributedSubtitle = NSAttributedString(string: "\nInterpretation guide\n", attributes: subtitleAttributes)
    let notesAttributes = [NSAttributedString.Key.font: UIFont(descriptor: descriptorBody!, size: notesFontSizePDF)]
    var textElement = PDFAttributedText(text: attributedSubtitle)
    document.add(.contentLeft, attributedTextObject: textElement)
    
    document.addLineSeparator(PDFContainer.contentLeft, style: lineStyle)
    
    let attributedNotes = NSAttributedString(string: notes_on_interpretationa_string, attributes: notesAttributes)
    
    textElement = PDFAttributedText(text: attributedNotes)
    document.add(.contentLeft, attributedTextObject: textElement)
}


func addImage(document: PDFDocument, image: UIImage, width: CGFloat? = nil, height: CGFloat? = nil) {
    if (width == nil) {
        let imageElement = PDFImage(image: image, sizeFit: .width, quality: 1.0)
        document.add(image: imageElement)
    } else {
        let aspectRatio: CGFloat = image.size.width/image.size.height
        var imageSize: CGSize
        if (height == nil) {
            imageSize = CGSize(width: width!, height: width!/aspectRatio)
        } else {
            imageSize = CGSize(width: width!, height: height!)
        }
        let imageElement = PDFImage(image: image, size: imageSize, quality: 1.0)
        document.add(.contentCenter, image: imageElement)
    }
}