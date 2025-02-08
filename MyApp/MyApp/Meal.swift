import SwiftUI

struct Meal: Identifiable {
    let id = UUID()
    var name: String
    var details: String
    var calories: Double
}
