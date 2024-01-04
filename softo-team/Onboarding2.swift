//
//  Onboarding2.swift
//  softo-team
//
//  Created by user on 03/01/2024.
//

import SwiftUI
import Firebase

struct Onboarding2: View {
    @State private var onboardingProgress: CGFloat = 2.0 / 4.0 // Updated progress for Onboarding 2
    @State private var selectedGender: String = ""
    @State private var birthDate = Date()
    @State private var phoneNumber: String = ""
    @State private var selectedBloodGroup: String = ""
    @State private var isOnboarding1Active = false
    @State private var isOnboarding3Active = false
    @State private var showAlert = false

    let genders = ["Select", "Male", "Female"]
    let bloodGroups = ["Select", "A+", "B+", "O+", "AB+", "A-", "B-", "O-", "AB-"]

    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    Text("Personal Information")
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

                    // Gender Dropdown
                    HStack(alignment: .firstTextBaseline, spacing: 260) {
                        Text("Gender")
                            .font(.headline)

                        Picker("Select Gender", selection: $selectedGender) {
                            ForEach(genders, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }
                    Spacer().frame(height: 50)

                    // Date of Birth
                    DatePicker("Date of Birth", selection: $birthDate, displayedComponents: .date)
                        .font(.headline)
                        .datePickerStyle(CompactDatePickerStyle())
                        .padding()

                    // Phone Number
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 50)
                        Text("Phone Number")
                            .font(.headline)
                            .padding(.leading, 15)
                        HStack {
                            TextField("Enter Phone Number", text: $phoneNumber)
                                .foregroundColor(.black)
                                .padding(.leading)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    Spacer().frame(height: 50)

                    // Blood Group Dropdown
                    HStack(alignment: .firstTextBaseline, spacing: 190) {
                        Text("Blood Group")
                            .font(.headline)

                        Picker("Blood Group", selection: $selectedBloodGroup) {
                            ForEach(bloodGroups, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }

                    // Buttons
                    Spacer().frame(height: 100)
                    HStack {
                        NavigationLink(
                            destination: Onboarding1(),
                            isActive: $isOnboarding1Active,
                            label: {
                                EmptyView()
                            }
                        )
                        .navigationBarBackButtonHidden(true)

                        Button("Back") {
                            isOnboarding1Active = true
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()

                        Spacer()

                        NavigationLink(
                            destination: Onboarding3(),
                            isActive: $isOnboarding3Active,
                            label: {
                                EmptyView()
                            }
                        )
                        .navigationBarBackButtonHidden(true)

                        Button("Next") {
                            if allFieldsAreFilled() {
                                updateUserDataInFirestore()
                                isOnboarding3Active = true
                            } else {
                                showAlert = true
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                    .padding(.bottom, 300)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Please fill all fields to move forward."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
                    print("isOnboarding3Active:", isOnboarding3Active)
                }
    }
    // Function to check if all fields are filled
    private func allFieldsAreFilled() -> Bool {
        return !selectedGender.isEmpty
            && !phoneNumber.isEmpty
            && !selectedBloodGroup.isEmpty
            // Add additional checks for other fields if needed
    }
    

    // Function to update user data in Firestore
    func updateUserDataInFirestore() {
        if let userId = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()

            // Create a reference to the Firestore document for the user
            let userRef = db.collection("users").document(userId)

            // Update user data with onboarding information
            let userData: [String: Any] = [
                "gender": selectedGender,
                "birthDate": birthDate,
                "phoneNumber": phoneNumber,
                "bloodGroup": selectedBloodGroup
                // Add other fields specific to Onboarding2 if needed
            ]

            // Set the document data in Firestore
            userRef.updateData(userData) { error in
                if let error = error {
                    print("Error updating user data: \(error.localizedDescription)")
                } else {
                    print("User data updated successfully")
                    // Navigate to the next screen or perform other actions
                    isOnboarding3Active = true
                }
            }
        }
    }
}

struct Onbarding2_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding2()
    }
}

