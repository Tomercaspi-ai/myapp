import SwiftUI

struct MealBubbleView: View {
    var meal: Meal

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(meal.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "clock")
                    .foregroundColor(Color.white.opacity(0.7))
                    .font(.title2)
            }
            Text(meal.details)
                .font(.subheadline)
                .foregroundColor(Color.white.opacity(0.8))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(
            // A rounded rectangle with a blur and subtle shadow.
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray4).opacity(0.2))
                .background(BlurView(style: .systemUltraThinMaterialDark).clipShape(RoundedRectangle(cornerRadius: 25)))
                .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 3)
        )
        .padding(.horizontal)
    }
}
