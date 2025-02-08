import SwiftUI

// MARK: - Professional Background Modifier
struct ProfessionalBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("GradientStart"), Color("GradientEnd")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
            )
    }
}

extension View {
    func professionalBackground() -> some View {
        self.modifier(ProfessionalBackground())
    }
}

// MARK: - Professional Button Style
struct ProfessionalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("AvenirNext-Bold", size: 18)) // Replace with your preferred custom font
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("AccentColor"))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .foregroundColor(.white)
            .padding(.horizontal)
    }
}
