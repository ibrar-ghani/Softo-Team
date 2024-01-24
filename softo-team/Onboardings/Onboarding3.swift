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
    @AppStorage("emergencyContactName") private var emergencyContactName: String = ""
    @AppStorage("emergencyContactNumber") private var emergencyContactNumber: String = ""
    @AppStorage("emergencyContactName1") private var emergencyContactName1: String = ""
    @AppStorage("emergencyContactNumber1") private var emergencyContactNumber1: String = ""
    @AppStorage("selectedCountryCode") private var selectedCountryCode: String = "+1"
    @AppStorage("selectedCountryCode1") private var selectedCountryCode1: String = "+1"
    @State private var isOnboarding4Active = false
    @State private var showAlert = false
    @Binding var selectedTab: Int
    @State private var countryCodes: [String] = [
        "+1", "+7", "+20", "+27", "+30", "+31", "+32", "+33", "+34", "+36", "+39", "+40", "+41", "+43", "+44", "+45", "+46", "+47", "+48", "+49", "+51", "+52", "+53", "+54", "+55", "+56", "+57", "+58", "+60", "+61", "+62", "+63", "+64", "+65", "+66", "+81", "+82", "+84", "+86", "+90", "+91", "+92", "+93", "+94", "+95", "+98", "+212", "+213", "+216", "+218", "+220", "+221", "+222", "+223", "+224", "+225", "+226", "+227", "+228", "+229", "+230", "+231", "+232", "+233", "+234", "+235", "+236", "+237", "+238", "+239", "+240", "+241", "+242", "+243", "+244", "+245", "+246", "+248", "+249", "+250", "+251", "+252", "+253", "+254", "+255", "+256", "+257", "+258", "+260", "+261", "+262", "+263", "+264", "+265", "+266", "+267", "+268", "+269", "+290", "+291", "+297", "+298", "+299", "+350", "+351", "+352", "+353", "+354", "+355", "+356", "+357", "+358", "+359", "+370", "+371", "+372", "+373", "+374", "+375", "+376", "+377", "+378", "+379", "+380", "+381", "+382", "+383", "+385", "+386", "+387", "+389", "+420", "+421", "+423", "+500", "+501", "+502", "+503", "+504", "+505", "+506", "+507", "+508", "+509", "+590", "+591", "+592", "+593", "+594", "+595", "+596", "+597", "+598", "+599", "+670", "+672", "+673", "+674", "+675", "+676", "+677", "+678", "+679", "+680", "+681", "+682", "+683", "+685", "+686", "+687", "+688", "+689", "+690", "+691", "+692", "+850", "+852", "+853", "+855", "+856", "+880", "+886", "+960", "+961", "+962", "+963", "+964", "+965", "+966", "+967", "+968", "+970", "+971", "+972", "+973", "+974", "+975", "+976", "+977", "+992", "+993", "+994", "+995", "+996", "+998", "+1242", "+1246", "+1264", "+1268", "+1284", "+1340", "+1345", "+1441", "+1473", "+1649", "+1664", "+1670", "+1671", "+1684", "+1721", "+1758", "+1767", "+1784", "+1787", "+1809", "+1829", "+1849", "+1868", "+1869", "+1876", "+1939"] //  country codes
    
    var body: some View {
        ScrollView{
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
                
                
                VStack(alignment: .leading, spacing: 20) {
                    // Emergency Contact 1
                    VStack(alignment: .leading) {
                        Text("Emergency Contact 1")
                            .font(.headline)
                            .padding()
                        
                        TextField("Contact Name", text: $emergencyContactName)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                        
                        HStack {
                            Picker("Country Code", selection: $selectedCountryCode) {
                                ForEach(countryCodes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(width: 20)
                            
                            TextField("eg:3000000000", text: $emergencyContactNumber)
                                .padding()
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.phonePad)
                                .onChange(of: emergencyContactNumber) { newValue in
                                    let filtered = newValue.filter { $0.isNumber }
                                    if filtered.count > 10 {
                                        emergencyContactNumber = String(filtered.prefix(10))
                                    } else {
                                        emergencyContactNumber = filtered
                                    }
                                }
                        }
                    }
                }
                
                .padding()
                
                // Emergency Contact 2
                VStack(alignment: .leading) {
                    Text("Emergency Contact 2")
                        .font(.headline)
                        .padding()
                    
                    TextField("Contact Name", text: $emergencyContactName1)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    HStack{
                        Picker("Country Code", selection: $selectedCountryCode1) {
                            ForEach(countryCodes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 20)
                        
                        TextField("eg:3000000000", text: $emergencyContactNumber1)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.phonePad)
                            .onChange(of: emergencyContactNumber1) { newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                if filtered.count > 10 {
                                    emergencyContactNumber1 = String(filtered.prefix(10))
                                } else {
                                    emergencyContactNumber1 = filtered
                                }
                            }
                        
                    }
                    .padding()
                }
            }
            
            // Button
            Spacer().frame(height: 50)
            // NavigationLink (Next)
            //            NavigationLink(
            //                destination: Onboarding4(),
            //                isActive: $isOnboarding4Active,
            //                label: { EmptyView() }
            //            )
            Button("Next") {
                if allFieldsAreFilled() {
                    // Handle the completion or navigate to the next screen
                    // For now, it shows an alert
                    //isOnboarding4Active = true
                    updateDataInFirestore()
                    selectedTab = 3
                } else {
                    showAlert = true
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .onAppear(){
                emergencyContactName=""
                emergencyContactNumber=""
                emergencyContactName1=""
                emergencyContactNumber1=""
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
                "emergencyContactNumber": "\(selectedCountryCode) \(emergencyContactNumber)",
                "emergencyContactName1": emergencyContactName1,
                "emergencyContactNumber1": "\(selectedCountryCode1) \(emergencyContactNumber)",
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
//struct Onboarding3_Previews: PreviewProvider {
//    static var previews: some View {
//        Onboarding3()
//    }
//}


