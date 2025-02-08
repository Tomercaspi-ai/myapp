import Foundation

struct Meal: Identifiable {
    let id = UUID()
    var name: String       // Changed from let to var
    var details: String    // Changed from let to var
    var calories: Double   // Changed from let to var
}
