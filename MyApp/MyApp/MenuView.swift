import SwiftUI

struct MenuView: View {
    @Binding var meals: [Meal] // 🔥 Shared with HomeView
    @Binding var totalCaloriesConsumed: Double // ✅ Tracks calories in HomeView
    @State private var selectedMealIndex: Int? = nil
    @State private var showMealEdit = false
    @State private var eatenMeals: Set<UUID> = []  // 🔥 Track eaten meals

    var body: some View {
        NavigationView {
            List {
                ForEach(meals.indices, id: \.self) { index in
                    HStack {
                        // ✅ Mark as Eaten Button (Works Separately)
                        Button(action: {
                            toggleMealEaten(meals[index])
                        }) {
                            Image(systemName: eatenMeals.contains(meals[index].id) ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(eatenMeals.contains(meals[index].id) ? .green : .gray)
                                .font(.title2)
                                .padding(.trailing, 8) // ✅ Spacing from text
                        }
                        .buttonStyle(BorderlessButtonStyle()) // ✅ Prevents triggering row tap

                        VStack(alignment: .leading) {
                            Text(meals[index].name)
                                .font(.headline)
                            Text(meals[index].details)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("\(meals[index].calories, specifier: "%.0f") cal")
                            .foregroundColor(.blue)
                    }
                    .contentShape(Rectangle()) // ✅ Makes row tappable
                    .onTapGesture {
                        selectedMealIndex = index
                        showMealEdit = true
                    }
                }
                .onDelete { indexSet in
                    meals.remove(atOffsets: indexSet) // 🔥 Allow deleting meals
                }
            }
            .navigationTitle("Meals")
            .sheet(isPresented: $showMealEdit) {
                if let index = selectedMealIndex {
                    MealEditView(
                        mealName: $meals[index].name,
                        carbs: $meals[index].details,
                        protein: .constant("Example Protein"),
                        vegetables: .constant("Example Vegetables"),
                        mealCalories: $meals[index].calories
                    )
                }
            }
        }
    }

    // ✅ Toggle meal as eaten and update calorie count in HomeView
    private func toggleMealEaten(_ meal: Meal) {
        if eatenMeals.contains(meal.id) {
            eatenMeals.remove(meal.id)  // ✅ Unmark meal
            totalCaloriesConsumed -= meal.calories // 🔥 Subtract calories
        } else {
            eatenMeals.insert(meal.id)  // ✅ Mark meal as eaten
            totalCaloriesConsumed += meal.calories // 🔥 Add calories
        }
    }
}
