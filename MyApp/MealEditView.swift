import SwiftUI

struct MealEditView: View {
    @Binding var mealName: String
    @Binding var carbs: String
    @Binding var protein: String
    @Binding var vegetables: String
    @Binding var mealCalories: Double // 🔥 Ensure this exists!

    var body: some View {
        Form {
            Section(header: Text("Meal Name")) {
                TextField("Enter meal name", text: $mealName)
            }
            
            Section(header: Text("Carbs")) {
                TextField("Carbs details", text: $carbs)
            }
            
            Section(header: Text("Protein")) {
                TextField("Protein details", text: $protein)
            }
            
            Section(header: Text("Vegetables")) {
                TextField("Vegetables details", text: $vegetables)
            }

            Section(header: Text("Calories")) {
                TextField("Enter calories", value: $mealCalories, format: .number)
                    .keyboardType(.numberPad)
            }
        }
        .navigationTitle("Edit Meal")
    }
}
