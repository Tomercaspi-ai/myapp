import SwiftUI

struct HomeView: View {
    @Binding var meals: [Meal] // 🔥 Shared with MenuView
    @Binding var totalCaloriesConsumed: Double // ✅ Syncs with MenuView
    let caloriesTargetConsumed: Double = 2200  // Daily target calories
    let caloriesBurned: Double = 1800  // 🔥 Example burned calories
    
    @State private var selectedMeal: Meal? // ✅ Tracks the selected meal for detail view
    @State private var showMealDetail = false // ✅ Controls meal detail sheet
    @State private var eatenMeals: Set<UUID> = []  // ✅ Track eaten meals

    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.largeTitle)
                .padding(.top)

            // 🔥 Rings for calories (Consumed = Green, Burned = Red)
            ZStack {
                // ✅ Outer ring: Consumed Calories (Green)
                RingView(progress: totalCaloriesConsumed / caloriesTargetConsumed,
                         lineWidth: 22, color: .green)
                    .frame(width: 220, height: 220)

                // ✅ Inner ring: Burned Calories (Red, FULL ring)
                Circle()
                    .stroke(Color.red, lineWidth: 14) // 🔥 Full red circle
                    .frame(width: 160, height: 160)

                // ✅ Center text displaying numerical values
                VStack(spacing: 4) {
                    Text("Consumed")
                        .font(.footnote)
                        .foregroundColor(.green)
                    Text("\(Int(totalCaloriesConsumed)) / \(Int(caloriesTargetConsumed))")
                        .font(.title3) // 🔥 Smaller font
                        .foregroundColor(.green)

                    Divider().frame(width: 30)

                    Text("Burned")
                        .font(.footnote)
                        .foregroundColor(.red)
                    Text("\(Int(caloriesBurned)) cal")
                        .font(.title3) // 🔥 Smaller font
                        .foregroundColor(.red)
                }
            }
            .padding()

            // ✅ Meal Bubble with Mark as Eaten Button Inside
            if let meal = mealForCurrentTime() {
                MealBubbleView(meal: meal, isEaten: eatenMeals.contains(meal.id)) {
                    toggleMealEaten(meal)
                }
                .onTapGesture {
                    selectedMeal = meal
                    showMealDetail = true
                }
            }

            Spacer()
        }
        .padding()
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

    /// Determines the current meal based on time.
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

    /// Toggles a meal between eaten/uneaten state and updates the calorie ring
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

// MARK: - MealBubbleView (Button Inside Bubble)
struct MealBubbleView: View {
    var meal: Meal
    var isEaten: Bool
    var toggleEaten: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(meal.name)
                    .font(.headline)
                Spacer()
                Button(action: toggleEaten) {
                    Image(systemName: isEaten ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isEaten ? .green : .gray)
                        .font(.title2)
                }
            }
            Text(meal.details)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray6))
                .shadow(radius: 4)
        )
        .padding()
    }
}

// MARK: - RingView

struct RingView: View {
    var progress: Double  // A value between 0 and 1.
    var lineWidth: CGFloat
    var color: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.2), lineWidth: lineWidth)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(color,
                        style: StrokeStyle(lineWidth: lineWidth,
                                           lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
        }
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            meals: .constant([
                Meal(name: "Breakfast", details: "Oatmeal, toast, fruit", calories: 400),
                Meal(name: "Lunch", details: "Pasta, rice, quinoa", calories: 700),
                Meal(name: "Dinner", details: "Chicken, sweet potato, vegetables", calories: 800)
            ]),
            totalCaloriesConsumed: .constant(1100) // ✅ Test with a pre-filled value
        )
    }
}
