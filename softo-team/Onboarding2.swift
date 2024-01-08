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
    @State private var selectedCountryCode = "+1"
    @State private var isOnboarding3Active = false
    @State private var showAlert = false
    @State private var countryCodes: [String] = [
        "+1", "+7", "+20", "+27", "+30", "+31", "+32", "+33", "+34", "+36", "+39", "+40", "+41", "+43", "+44", "+45", "+46", "+47", "+48", "+49", "+51", "+52", "+53", "+54", "+55", "+56", "+57", "+58", "+60", "+61", "+62", "+63", "+64", "+65", "+66", "+81", "+82", "+84", "+86", "+90", "+91", "+92", "+93", "+94", "+95", "+98", "+212", "+213", "+216", "+218", "+220", "+221", "+222", "+223", "+224", "+225", "+226", "+227", "+228", "+229", "+230", "+231", "+232", "+233", "+234", "+235", "+236", "+237", "+238", "+239", "+240", "+241", "+242", "+243", "+244", "+245", "+246", "+248", "+249", "+250", "+251", "+252", "+253", "+254", "+255", "+256", "+257", "+258", "+260", "+261", "+262", "+263", "+264", "+265", "+266", "+267", "+268", "+269", "+290", "+291", "+297", "+298", "+299", "+350", "+351", "+352", "+353", "+354", "+355", "+356", "+357", "+358", "+359", "+370", "+371", "+372", "+373", "+374", "+375", "+376", "+377", "+378", "+379", "+380", "+381", "+382", "+383", "+385", "+386", "+387", "+389", "+420", "+421", "+423", "+500", "+501", "+502", "+503", "+504", "+505", "+506", "+507", "+508", "+509", "+590", "+591", "+592", "+593", "+594", "+595", "+596", "+597", "+598", "+599", "+670", "+672", "+673", "+674", "+675", "+676", "+677", "+678", "+679", "+680", "+681", "+682", "+683", "+685", "+686", "+687", "+688", "+689", "+690", "+691", "+692", "+850", "+852", "+853", "+855", "+856", "+880", "+886", "+960", "+961", "+962", "+963", "+964", "+965", "+966", "+967", "+968", "+970", "+971", "+972", "+973", "+974", "+975", "+976", "+977", "+992", "+993", "+994", "+995", "+996", "+998", "+1242", "+1246", "+1264", "+1268", "+1284", "+1340", "+1345", "+1441", "+1473", "+1649", "+1664", "+1670", "+1671", "+1684", "+1721", "+1758", "+1767", "+1784", "+1787", "+1809", "+1829", "+1849", "+1868", "+1869", "+1876", "+1939"] //  country codes
    
    let genders = ["Select", "Male", "Female"]
    let bloodGroups = ["Select", "A+", "B+", "O+", "AB+", "A-", "B-", "O-", "AB-"]
    
    var body: some View {
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
                HStack(alignment: .firstTextBaseline, spacing: 150) {
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
                
                // Date of Birth
                DatePicker("Date of Birth", selection: $birthDate, displayedComponents: .date)
                    .font(.headline)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding()
                
                // Phone Number with Country Code
                VStack(alignment: .leading) {
                    Text("Phone Number")
                        .font(.headline)
                        .padding()
                    
                    HStack {
                        // Country Code Picker
                        Picker("Country Code", selection: $selectedCountryCode) {
                            ForEach(countryCodes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100)
                        
                        // Phone Number Text Field
                        TextField("eg:3000000000", text: $phoneNumber)
                            .foregroundColor(.black)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.phonePad)
                            .onChange(of: phoneNumber) { newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                if filtered.count > 10 {
                                    phoneNumber = String(filtered.prefix(10))
                                } else {
                                    phoneNumber = filtered
                                }
                            }
                    }
                    .padding()
                }
                
                // Blood Group Dropdown
                HStack(alignment: .firstTextBaseline, spacing: 150) {
                    Text("Blood Group")
                        .font(.headline)
                    
                    Picker("Blood Group", selection: $selectedGender) {
                        ForEach(bloodGroups, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                }
                
                // Button
                Spacer().frame(height: 100)
                    Spacer()
                    
                    // NavigationLink (Next)
                    NavigationLink(
                        destination: Onboarding3(),
                        isActive: $isOnboarding3Active,
                        label: { EmptyView() }
                    )
                    Button("Next") {
                        if allFieldsAreFilled() {
                            isOnboarding3Active = true
                            updateUserDataInFirestore()
                            print("Next button pressed - Navigating to Onboarding3")
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
    }
    
    // Function to check if all fields are filled
    private func allFieldsAreFilled() -> Bool {
        return !selectedGender.isEmpty
            && !phoneNumber.isEmpty
            && !selectedCountryCode.isEmpty
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
                "phoneNumber": "\(selectedCountryCode) \(phoneNumber)",
                // "bloodGroup": selectedBloodGroup // You might want to add this field if needed
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

struct Onboarding2_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding2()
    }
}

