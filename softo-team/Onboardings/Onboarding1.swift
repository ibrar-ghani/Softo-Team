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
    @AppStorage("isAnyOptionSelected") private var isAnyOptionSelected: Bool = false
        @State private var selectedOptions: [Bool] = Array(repeating: false, count: 5)
    //@State private var selectedOptions: [Bool] = Array(repeating: false, count: 5)
    @State private var isOnboarding2Active = false
    @State private var showAlert = false
    
    let checkboxTexts = ["Figma Designer", "IOS Developer", "Flutter Developer", "Node.js Developer", "Android Developer"]
    
    var body: some View {
        ScrollView {
            VStack {
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

                ForEach(0..<5) { index in
                    CheckboxRow(text: checkboxTexts[index], isSelected: Binding(
                                            get: { selectedOptions[index] },
                                            set: { newValue in
                                                selectedOptions[index] = newValue
                                                isAnyOptionSelected = selectedOptions.contains(true)
                                            }
                                        ))
                        .padding(.vertical, 15)
                }
                Spacer()

                NavigationLink(
                    destination: Onboarding2(),
                    isActive: $isOnboarding2Active,
                    label: { EmptyView() }
                )
                
               // .navigationBarBackButtonHidden(true)

                Button("Next") {
                    if selectedOptions.contains(true) {
                        isOnboarding2Active = true
                        UpdateUserDataInFirestore()
                    } else {
                        showAlert = true
                    }
                }
                .padding(.leading,200)
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
    func UpdateUserDataInFirestore() {
        if let userId = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()

            // Create a reference to the Firestore document for the user
            let userRef = db.collection("users").document(userId)
            let selectedOptionsTexts = checkboxTexts.enumerated().compactMap{
                index, text in return selectedOptions [index] ? text : nil
            }

            // Update user data with onboarding information
            let userData: [String: Any] = [
                "selectedOptions": selectedOptionsTexts
            ]

            // Set the document data in Firestore
            userRef.updateData(userData) { error in
                if let error = error {
                    print("Error updating user data: \(error.localizedDescription)")
                } else {
                    print("User data updated successfully")
                    isOnboarding2Active = true
                }
            }
        }
    }
}
struct CheckboxRow: View {
    let text: String
    @Binding var isSelected: Bool

    var body: some View {
        HStack(spacing:2){
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
        .padding(.vertical,4)
    }
}

struct Onbarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding1()
    }
}


