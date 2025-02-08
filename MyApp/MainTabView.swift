import SwiftUI

struct MainTabView: View {
    // Sample state variables to pass into HomeView.
    @State private var meals: [Meal] = [
        Meal(name: "Breakfast", details: "Oatmeal, toast, fruit", calories: 400),
        Meal(name: "Lunch", details: "Pasta, rice, quinoa", calories: 700),
        Meal(name: "Dinner", details: "Chicken, sweet potato, vegetables", calories: 800),
        Meal(name: "Snack", details: "Yogurt, nuts, fruit", calories: 300)
    ]
    @State private var totalCaloriesConsumed: Double = 1100

    var body: some View {
        TabView {
            // Home tab using your existing HomeView.
            HomeView(meals: $meals, totalCaloriesConsumed: $totalCaloriesConsumed)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // Meals tab – this calls your MealsView struct.
            MealsView()
                .tabItem {
                    Label("Meals", systemImage: "fork.knife")
                }
            
            // Settings tab.
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .preferredColorScheme(.dark)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
