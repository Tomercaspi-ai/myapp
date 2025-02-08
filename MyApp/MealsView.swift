import SwiftUI

struct MealsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea() // Use dark background
                VStack {
                    Text("Meals")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                    // Add additional meals content here as needed.
                }
            }
            .navigationBarTitle("Meals", displayMode: .inline)
        }
    }
}

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView()
    }
}
