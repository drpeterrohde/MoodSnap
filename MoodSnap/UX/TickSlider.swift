import SwiftUI

struct TickSlider: View {
    @Binding var value: CGFloat

    var body: some View {
        VStack {
            ZStack {
                    HStack {
                        Text("    I")
                            .foregroundColor(.gray.opacity(0.25))
                            .font(.system(size: 9))
                        Spacer()
                        Text("I")
                            .foregroundColor(.gray.opacity(0.25))
                            .font(.system(size: 9))
                        Spacer()
                        Text("I")
                            .foregroundColor(.gray.opacity(0.25))
                            .font(.system(size: 9))
                        Spacer()
                        Text("I")
                            .foregroundColor(.gray.opacity(0.25))
                            .font(.system(size: 9))
                        Spacer()
                        Text("I    ")
                            .foregroundColor(.gray.opacity(0.25))
                            .font(.system(size: 9))
                    }
                    Slider(value: $value, in: 0...4, step: 1)
            }
        }
    }
}
