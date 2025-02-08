import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false   // Determines if we show main app
    @State private var fadeOut = false      // Controls the opacity animation

    var body: some View {
        Group {
            if isActive {
                // Once the splash screen is done, load the MainTabView.
            MainTabView()
            } else {
                // Splash screen view with dark background and logo/text.
                ZStack {
                    Color.black.ignoresSafeArea()  // Dark background
                    VStack {
                        // Replace with your custom logo image if available.
                        Image(systemName: "bolt.fill") // Placeholder SF Symbol
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.white)
                        
                        Text("Elite Athlete")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                    }
                }
                .opacity(fadeOut ? 0.0 : 1.0)  // Fade out effect when fadeOut becomes true
                .onAppear {
                    // After a short delay, trigger the fade-out animation.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeOut(duration: 1.0)) {
                            fadeOut = true
                        }
                        // After the animation completes, switch to the main view.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
