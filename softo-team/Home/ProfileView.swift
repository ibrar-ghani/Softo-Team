import SwiftUI

struct ProfileView: View {
    //    @AppStorage("selectedOption1") private var selectedOption1: Bool = false
    //    @AppStorage("selectedOption2") private var selectedOption2: Bool = false
    //    @AppStorage("selectedOption3") private var selectedOption3: Bool = false
    //    @AppStorage("selectedOption4") private var selectedOption4: Bool = false
    //    @AppStorage("selectedOption5") private var selectedOption5: Bool = false
    //    @AppStorage("firstname") private var firstname: String = ""
    //    @AppStorage("lastname") private var lastname: String = ""
    //    @AppStorage("username") private var username: String = ""
    //    @AppStorage("email") private var email: String = ""
    //    @AppStorage("selectedGender") private var selectedGender: String = ""
    //    @AppStorage("SelectedCountryCode0") private var SelectedCountryCode0: String = "+1"
    //    @AppStorage("phoneNumber") private var phoneNumber: String = ""
    //    @AppStorage("state") private var state: String = ""
    //    @AppStorage("city") private var city: String = ""
    //    @AppStorage("postalcode") private var postalcode: String = ""
    //    @AppStorage("country") private var country: String = ""
    //    @AppStorage("state") private var state1: String = ""
    //    @AppStorage("city") private var city1: String = ""
    //    @AppStorage("postalcode") private var postalcode1: String = ""
    //    @AppStorage("country") private var country1: String = ""
    //    @AppStorage("selectedCountryCode") private var selectedCountryCode: String = "+1"
    //    @AppStorage("selectedCountryCode1") private var selectedCountryCode1: String = "+1"
    //    @AppStorage("emergencyContactName") private var emergencyContactName: String = ""
    //    @AppStorage("emergencyContactRelation") private var emergencyContactRelation: String = ""
    //    @AppStorage("emergencyContactName1") private var emergencyContactName1: String = ""
    //    @AppStorage("emergencyContactRelation1") private var emergencyContactRelation1: String = ""
    //    @AppStorage("emergencyContactNumber") private var emergencyContactNumber: String = ""
    //    @AppStorage("emergencyContactNumber1") private var emergencyContactNumber1: String = ""
    //    @State private var birthDate: Date = Date()
    //    @AppStorage("birthDate") private var birthDateRaw: TimeInterval = Date().timeIntervalSinceReferenceDate
    //    @AppStorage("selectedBloodGroup") private var selectedBloodGroup: String = ""
    //    let checkboxTexts = ["Figma Designer", "IOS Developer", "Flutter Developer", "Node.js Developer", "Android Developer"]
    @State private var isDataAvailable = false
    @EnvironmentObject private var authViewModel: AuthViewModel
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    HStack {
                        Text("First Name:")
                        Spacer()
                        Text(authViewModel.firstName )
                    }
                    
                    HStack {
                        Text("Last Name:")
                        Spacer()
                        Text(authViewModel.lastName)
                    }
                    
                    HStack {
                        Text("User Name:")
                        Spacer()
                        Text(authViewModel.userName)
                    }
                    HStack {
                        Text("Email:")
                        Spacer()
                        Text(authViewModel.Email)
                    }
                    HStack {
                        Text("Gender:")
                        Spacer()
                        Text(authViewModel.genderName)
                    }
                }
                
                Section(header: Text("Contact Information")) {
                    HStack {
                        Text("Phone Number:")
                        Spacer()
                        Text(authViewModel.phone)
                    }
                }
                
                Section(header: Text("Emergency Contacts")) {
                    HStack {
                        Text("Emergency Contact:\nName: \(authViewModel.emergencyContactName)\nRelation: \(authViewModel.emergencyContactRelationshipName)\nPhone: \(authViewModel.emergencyContactPhone)")
                    }
                }
                
                Section(header: Text("Addresses")) {
                    HStack {
                        Text("Present Address:\nState: \(authViewModel.currentAddressLine1)\n \(authViewModel.currentAddressLine2)\nCity: \(authViewModel.currentCity)\nPostal Code: \(authViewModel.currentPostalCode)\nCountry: \(authViewModel.currentCountry)")
                    }
                    
                    HStack {
                        Text("Permanent Address:\nState: \(authViewModel.permanentAddressLine1 )\n \(authViewModel.permanentAddressLine2 )\nCity: \(authViewModel.permanentCity )\nPostal Code: \(authViewModel.permanentPostalCode)\nCountry: \(authViewModel.permanentCountry)")
                    }
                }
                
                
                Section(header: Text("Date of Birth")) {
                    HStack {
                        Text("Birth Date:")
                        Spacer()
                        Text(authViewModel.dob)
                    }
                }
                
                Section(header: Text("Blood Group")) {
                    HStack {
                        Text("Blood Group:")
                        Spacer()
                        Text("\(authViewModel.bloodGroupName)")
                    }
                }
            }.onAppear {
                // When data is available, set isDataAvailable to true
                if authViewModel.personalInfo != nil {
                    isDataAvailable = true
                    print("Data is avaliable")
                }
            }
            .navigationTitle("Profile")
        }
    }
    
    // Helper function to format the date
    private func formattedDate(birthDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: birthDate)
    }
    
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
