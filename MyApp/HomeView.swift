import SwiftUI

struct HomeView: View {
    @Binding var meals: [Meal]                   // Meals array from parent view
    @Binding var totalCaloriesConsumed: Double     // Syncs with parent view
    let caloriesTargetConsumed: Double = 2200      // Daily target calories
    let caloriesBurned: Double = 1800              // Example burned calories
    
    @State private var selectedMeal: Meal?         // Tracks the selected meal for detail view
    @State private var showMealDetail = false        // Controls meal detail sheet
    @State private var eatenMeals: Set<UUID> = []    // Tracks eaten meals
    
    var body: some View {
        ZStack {
            // Background: Dark gradient covering the entire screen.
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(.darkGray)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header
                Text("Dashboard")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                // Rings for calories
                ZStack {
                    // Outer ring: Consumed Calories (Green)
                    RingView(
                        progress: totalCaloriesConsumed / caloriesTargetConsumed,
                        lineWidth: 22,
                        color: .green
                    )
                    .frame(width: 220, height: 220)
                    .shadow(color: Color.green.opacity(0.6), radius: 10, x: 0, y: 4)
                    
                    // Inner ring: Burned Calories (Red, full circle)
                    Circle()
                        .stroke(Color.red, lineWidth: 14)
                        .frame(width: 160, height: 160)
                        .shadow(color: Color.red.opacity(0.6), radius: 8, x: 0, y: 3)
                    
                    // Center text displaying numerical values
                    VStack(spacing: 4) {
                        Text("Consumed")
                            .font(.footnote)
                            .foregroundColor(.green)
                        Text("\(Int(totalCaloriesConsumed)) / \(Int(caloriesTargetConsumed))")
                            .font(.title3)
                            .foregroundColor(.green)
                        
                        Divider()
                            .frame(width: 30)
                            .background(Color.white)
                        
                        Text("Burned")
                            .font(.footnote)
                            .foregroundColor(.red)
                        Text("\(Int(caloriesBurned)) cal")
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                }
                .padding()
                
                // Meal Bubble Button (Opens Meal Detail)
                if let meal = mealForCurrentTime() {
                    HStack(spacing: 16) {
                        // Button to toggle whether the meal has been eaten.
                        Button(action: {
                            toggleMealEaten(meal)
                        }) {
                            Image(systemName: eatenMeals.contains(meal.id) ? "checkmark.circle.fill" : "circle")
                                .font(.system(size: 28))
                                .foregroundColor(eatenMeals.contains(meal.id) ? .green : .gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Button that shows the meal bubble.
                        Button(action: {
                            selectedMeal = meal
                            showMealDetail = true
                        }) {
                            MealBubbleView(meal: meal)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
        }
        // Meal detail sheet presentation
        .sheet(isPresented: $showMealDetail) {
            if let meal = selectedMeal {
                MealDetailView(
                    mealName: .constant(meal.name),
                    carbs: .constant("Carbs: \(meal.details)"),
                    protein: .constant("Protein: Example"),
                    vegetables: .constant("Vegetables: Example"),
                    mealCalories: .constant(meal.calories)
                )
            }
        }
    }
    
    /// Determines the current meal based on the time of day.
    func mealForCurrentTime() -> Meal? {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 8 && hour <= 11 {
            return meals.first { $0.name == "Breakfast" }
        } else if hour >= 12 && hour <= 15 {
            return meals.first { $0.name == "Lunch" }
        } else if hour >= 16 && hour <= 20 {
            return meals.first { $0.name == "Dinner" }
        } else {
            return meals.first { $0.name == "Snack" }
        }
    }
    
    /// Toggles whether a meal has been eaten and updates the total calories accordingly.
    private func toggleMealEaten(_ meal: Meal) {
        if eatenMeals.contains(meal.id) {
            eatenMeals.remove(meal.id)
            totalCaloriesConsumed -= meal.calories
        } else {
            eatenMeals.insert(meal.id)
            totalCaloriesConsumed += meal.calories
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            meals: .constant([
                Meal(name: "Breakfast", details: "Oatmeal, toast, fruit", calories: 400),
                Meal(name: "Lunch", details: "Pasta, rice, quinoa", calories: 700),
                Meal(name: "Dinner", details: "Chicken, sweet potato, vegetables", calories: 800),
                Meal(name: "Snack", details: "Yogurt, nuts, fruit", calories: 300)
            ]),
            totalCaloriesConsumed: .constant(1100)
        )
    }
}
