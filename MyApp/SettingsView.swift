import SwiftUI

struct SettingsView: View {
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear.professionalBackground()
                
                Form {
                    Section(header: Text("Enter Your Stats")
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .foregroundColor(.primary)
                    ) {
                        TextField("Age", text: $age)
                            .keyboardType(.numberPad)
                        TextField("Weight (kg)", text: $weight)
                            .keyboardType(.decimalPad)
                        TextField("Height (cm)", text: $height)
                            .keyboardType(.decimalPad)
                    }
                }
                .scrollContentBackground(.hidden)  // iOS 16+: hides the default white background of a Form
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
