import SwiftUI

struct ContentView: View {
    @State private var meals: [Meal] = [
        Meal(name: "Breakfast", details: "Oatmeal, toast, fruit", calories: 400),
        Meal(name: "Lunch", details: "Pasta, rice, quinoa", calories: 700),
        Meal(name: "Dinner", details: "Chicken, sweet potato, vegetables", calories: 800)
    ]
    @State private var totalCaloriesConsumed: Double = 0 // ✅ Add this

    var body: some View {
        TabView {
            HomeView(meals: $meals, totalCaloriesConsumed: $totalCaloriesConsumed)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            MenuView(meals: $meals, totalCaloriesConsumed: $totalCaloriesConsumed)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Menu")
                }
        }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
