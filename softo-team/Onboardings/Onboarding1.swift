//
//  Onboarding1.swift
//  SoftoFamily
//
//  Created by user on 21/12/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct Onboarding1: View {
    @State private var onboardingProgress: CGFloat = 1.0 / 4.0 // Initial progress
    @AppStorage("selectedOption1") private var selectedOption1: Bool = false
    @AppStorage("selectedOption2") private var selectedOption2: Bool = false
    @AppStorage("selectedOption3") private var selectedOption3: Bool = false
    @AppStorage("selectedOption4") private var selectedOption4: Bool = false
    @AppStorage("selectedOption5") private var selectedOption5: Bool = false
    @State private var selectedOptions: [Bool] = Array(repeating: false, count: 5)
    @Binding var selectedTab: Int
    @State private var showAlert = false
    let checkboxTexts = ["Figma Designer", "IOS Developer", "Flutter Developer", "Node.js Developer", "Android Developer"]
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Career Preferences")
                    .font(.title)
                    .italic()
                    .bold()
                    .padding()
                
                // Horizontal Progress Bar
                GeometryReader { geometry in
                    VStack {
                        Capsule()
                            .foregroundColor(.blue)
                            .frame(width: geometry.size.width * onboardingProgress, height: 10)
                    }
                }
                .padding()
                
                Text("What best describes you?")
                    .font(.headline)
                    .padding()
                
                ForEach(0..<checkboxTexts.count) { optionIndex in
                    CheckboxRow(text: checkboxTexts[optionIndex], isSelected: selectedState(for: optionIndex))
                        .padding(.vertical, 15)
                }
                Spacer()
                
                Button("Next") {
                    if selectedOption1 || selectedOption2 || selectedOption3 || selectedOption4 || selectedOption5 {
                        let selectedOptionsTexts = getSelectedOptionsTexts()
                        UpdateUserDataInFirestore(selectedOptionsTexts: selectedOptionsTexts)
                        selectedTab = 1
                    } else {
                        showAlert = true
                    }
                }
                .padding(.leading, 200)
                .buttonStyle(.borderedProminent)
                .navigationBarBackButtonHidden(true)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("Please select at least one checkbox to move forward."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
    
    // Function to update user data and onboarding data in Firestore
    func UpdateUserDataInFirestore(selectedOptionsTexts: [String]) {
        if let userId = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(userId)
            
            let userData: [String: Any] = [
                "selectedOptions": selectedOptionsTexts
            ]
            
            userRef.updateData(userData) { error in
                if let error = error {
                    print("Error updating user data: \(error.localizedDescription)")
                } else {
                    print("User data updated successfully")
                }
            }
        }
    }
    
    // Function to get the selected options' texts
    func getSelectedOptionsTexts() -> [String] {
        var selectedOptionsTexts: [String] = []
        for index in 0..<checkboxTexts.count {
            if selectedState(for: index).wrappedValue {
                selectedOptionsTexts.append(checkboxTexts[index])
            }
        }
        return selectedOptionsTexts
    }
    
    // Function to determine the selected state for an option
    func selectedState(for index: Int) -> Binding<Bool> {
        return Binding(
            get: {
                switch index {
                case 0:
                    return selectedOption1
                case 1:
                    return selectedOption2
                case 2:
                    return selectedOption3
                case 3:
                    return selectedOption4
                case 4:
                    return selectedOption5
                default:
                    return false
                }
            },
            set: { newValue in
                switch index {
                case 0:
                    selectedOption1 = newValue
                case 1:
                    selectedOption2 = newValue
                case 2:
                    selectedOption3 = newValue
                case 3:
                    selectedOption4 = newValue
                case 4:
                    selectedOption5 = newValue
                default:
                    break
                }
            }
        )
    }
}

struct CheckboxRow: View {
    let text: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack(spacing: 2) {
            Button(action: {
                isSelected.toggle()
            }) {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding()
            }
            .foregroundColor(isSelected ? .blue : .gray)
            
            Text(text)
                .foregroundColor(.black)
                .padding(.leading, 8)
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

//struct Onboarding1_Previews: PreviewProvider {
//    @State var selectedTab: Int = 0
//
//    static var previews: some View {
//        Onboarding1(selectedTab: $selectedTab)
//    }
//}
