//
//  Onboarding4.swift
//  softo-team
//
//  Created by user on 05/01/2024.
//

import SwiftUI
import Firebase

struct Onboarding4: View {
//    @State private var permanentAddress: String = ""
//    @State private var currentAddress: String = ""
    @AppStorage("permanentAddress") private var PermanentAddress: String = ""
    @AppStorage("currentAddress") private var CurrentAddress: String = ""
    @State private var isOnboardingComplete = false
    @State private var isHomeScreenActive = false
    @State private var showAlert = false
    @State private var onboardingProgress: CGFloat = 4.0 / 4.0 // Updated progress for Onboarding 4
    @Binding var selectedTab: Int
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Residence Information")
                .italic()
                .bold()
                .font(.title)
                .padding()

            // Progress Bar
            GeometryReader { geometry in
                VStack {
                    Capsule()
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * onboardingProgress, height: 10)
                }
            }
            .padding()

            // Permanent Address
            TextField("Permanent Address", text: $PermanentAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Current Address
            TextField("Current Address", text: $CurrentAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

//            NavigationLink(
//                destination: HomeScreen(),
//                isActive: $isHomeScreenActive,
//                label: {
//                EmptyView() // Use EmptyView to create a hidden navigation link label
//                                })
            // Button to complete onboarding
            Button("Complete Onboarding") {
                
                // Perform actions when the onboarding is complete
                if allFieldsAreFilled(){
                updateUserDataInFirestore()
                    selectedTab = 4
                }else {
                    showAlert = true
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .onAppear(){
                CurrentAddress=""
                PermanentAddress=""
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill all fields to move forward."),
                    dismissButton: .default(Text("OK"))
                )
            }

            Spacer()
        }
        .padding()
    }
    func updateUserDataInFirestore() {
        if let userId = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()

            // Create a reference to the Firestore document for the user
            let userRef = db.collection("users").document(userId)

            // Update user data with residence information
            let residenceData: [String: Any] = [
                "permanentAddress": PermanentAddress,
                "currentAddress": CurrentAddress
                // Add other fields specific to residence if needed
            ]

            // Set the document data in Firestore
            userRef.updateData(residenceData) { error in
                if let error = error {
                    print("Error updating residence data: \(error.localizedDescription)")
                } else {
                    print("Residence data updated successfully")
                    // You can perform additional actions here if needed
                }
            }
        }
    }

    
    // Function to check if all fields are filled
    private func allFieldsAreFilled() -> Bool {
        return !CurrentAddress.isEmpty && !PermanentAddress.isEmpty
        // Add additional checks for other fields if needed
    }
}

//struct Onboarding4_Previews: PreviewProvider {
//    static var previews: some View {
//        Onboarding4()
//    }
//}
