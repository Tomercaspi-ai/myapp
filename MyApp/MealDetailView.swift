import SwiftUI

struct MealDetailView: View {
    // ✅ Add `@Binding` so the meal details can be updated from MenuView
    @Binding var mealName: String
    @Binding var carbs: String
    @Binding var protein: String
    @Binding var vegetables: String
    @Binding var mealCalories: Double

    // ✅ State variable for marking the meal as eaten
    @State private var isMealEaten = false
    
    // ✅ State to control the display of the edit sheet
    @State private var showingEditSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header with meal name and eaten toggle button
            HStack {
                Text(mealName)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    isMealEaten.toggle()
                }) {
                    if isMealEaten {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title)
                    } else {
                        Image(systemName: "circle")
                            .foregroundColor(.gray)
                            .font(.title)
                    }
                }
                .accessibilityLabel("Mark meal as eaten")
            }

            // ✅ Calories input section
            VStack(alignment: .leading, spacing: 4) {
                Text("Calories")
                    .font(.headline)
                TextField("Enter calories", value: $mealCalories, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
            }

            // Carbs section
            VStack(alignment: .leading, spacing: 4) {
                Text("Carbs")
                    .font(.headline)
                Text(carbs)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            // Protein section
            VStack(alignment: .leading, spacing: 4) {
                Text("Protein")
                    .font(.headline)
                Text(protein)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            // Vegetables section
            VStack(alignment: .leading, spacing: 4) {
                Text("Vegetables")
                    .font(.headline)
                Text(vegetables)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Meal Details")
        // Add an Edit button in the navigation bar
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEditSheet = true
                }
            }
        }
        // Present the MealEditView in a sheet when editing
        .sheet(isPresented: $showingEditSheet) {
            NavigationView {
                MealEditView(mealName: $mealName,
                             carbs: $carbs,
                             protein: $protein,
                             vegetables: $vegetables,
                             mealCalories: $mealCalories) // ✅ FIXED: Now includes mealCalories!
                    .navigationTitle("Edit Meal")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingEditSheet = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                showingEditSheet = false
                            }
                        }
                    }
            }
        }
    }
}

// ✅ Update Preview for Testing
struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealDetailView(
                mealName: .constant("Lunch"),
                carbs: .constant("400g - Pasta, rice, quinoa"),
                protein: .constant("2X - Egg, tuna, white cheese"),
                vegetables: .constant("2-3 from all colors"),
                mealCalories: .constant(700)
            )
        }
    }
}
