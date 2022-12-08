import SwiftUI

/**
 View for rounded rectangle with superimposed dot.
 */
struct RoundedRectangleDot: View {
    var widthOuter: CGFloat
    var widthInner: CGFloat
    var radius: CGFloat
    var height: CGFloat
    var color: Color
    var withDot: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: radius, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .frame(width: widthOuter, height: height)
                .foregroundColor(color)
            if withDot {
                RoundedRectangle(cornerRadius: radius, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .frame(width: height, height: height, alignment: .topLeading)
                    .brightness(0.2)
                    .foregroundColor(color)
                    .padding(.leading, max(0, widthInner - radius))
            }
        }
    }
}
