//
//  Onboarding3.swift
//  softo-team
//
//  Created by user on 04/01/2024.
//

import SwiftUI
import Firebase

struct Onboarding3: View {
    @State private var progress: CGFloat = 3.0 / 4.0 // Update progress for Onboarding 3
    @State private var emergencyContactName: String = ""
    @State private var emergencyContactNumber: String = ""
    @State private var emergencyContactName1: String = ""
    @State private var emergencyContactNumber1: String = ""
    @State private var isOnboarding4Active = false
    @State private var showAlert = false

    var body: some View {
        VStack {

            // Title
            Text("Emergency Contact")
                .font(.title)
                .italic()
                .bold()
                .padding()

            // Progress Indicator
            GeometryReader { geometry in
                VStack {
                    Capsule()
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * progress, height: 10)
                }
            }
            .padding()
            
            
            // Form for Emergency Contact
            Form {
                Section(header: Text("Enter Emergency Contact Information")) {
                    TextField("Contact Name", text: $emergencyContactName)
                    TextField("Contact Number", text: $emergencyContactNumber)
                    TextField("Contect Name", text: $emergencyContactName1)
                    TextField("Contact Number", text: $emergencyContactNumber1)
                }
            }

            // Button
            Spacer().frame(height: 50)
            // NavigationLink (Next)
            NavigationLink(
                destination: Onboarding4(),
                isActive: $isOnboarding4Active,
                label: { EmptyView() }
            )
            Button("Next") {
                if allFieldsAreFilled() {
                    // Handle the completion or navigate to the next screen
                    // For now, it shows an alert
                    isOnboarding4Active = true
                    updateDataInFirestore()
                } else {
                    showAlert = true
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Please fill all fields to move forward."),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    // Function to check if all fields are filled
    private func allFieldsAreFilled() -> Bool {
        return !emergencyContactName.isEmpty && !emergencyContactNumber.isEmpty
        // Add additional checks for other fields if needed
    }
    
    func updateDataInFirestore() {
        if let userId = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()

            // Create a reference to the Firestore document for the user
            let userRef = db.collection("users").document(userId)

            // Update user data with emergency contact information
            let emergencyContactData: [String: Any] = [
                "emergencyContactName": emergencyContactName,
                "emergencyContactNumber": emergencyContactNumber,
                "emergencyContactName1": emergencyContactName1,
                "emergencyContactNumber1": emergencyContactNumber1
                // Add other fields specific to emergency contact if needed
            ]

            // Set the document data in Firestore
            userRef.updateData(emergencyContactData) { error in
                if let error = error {
                    print("Error updating emergency contact data: \(error.localizedDescription)")
                } else {
                    print("Emergency contact data updated successfully")
                    // You can perform additional actions here if needed
                }
            }
        }
    }

}

struct Onboarding3_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding3()
    }
}


