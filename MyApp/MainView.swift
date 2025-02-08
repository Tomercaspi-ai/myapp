import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Apply our custom background
                Color.clear.professionalBackground()
                
                VStack(spacing: 30) {
                    Text("Elite Athlete")
                        .font(.custom("AvenirNext-Bold", size: 36))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 2)
                    
                    Text("Welcome back, Champion!")
                        .font(.custom("AvenirNext-Regular", size: 20))
                        .foregroundColor(.white)
                    
                    Button(action: {
                        // Action for starting training
                    }) {
                        Text("Start Training")
                    }
                    .buttonStyle(ProfessionalButtonStyle())
                }
                .padding()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
