import SwiftUI

struct ProfileView: View {
    @AppStorage("selectedOption1") private var selectedOption1: Bool = false
    @AppStorage("selectedOption2") private var selectedOption2: Bool = false
    @AppStorage("selectedOption3") private var selectedOption3: Bool = false
    @AppStorage("selectedOption4") private var selectedOption4: Bool = false
    @AppStorage("selectedOption5") private var selectedOption5: Bool = false
    @AppStorage("firstname") private var firstname: String = ""
    @AppStorage("lastname") private var lastname: String = ""
    @AppStorage("username") private var username: String = ""
    @AppStorage("selectedGender") private var selectedGender: String = ""
    @AppStorage("SelectedCountryCode0") private var SelectedCountryCode0: String = "+1"
    @AppStorage("phoneNumber") private var phoneNumber: String = ""
    @AppStorage("permanentAddress") private var PermanentAddress: String = ""
    @AppStorage("currentAddress") private var CurrentAddress: String = ""
    @AppStorage("selectedCountryCode") private var selectedCountryCode: String = "+1"
    @AppStorage("selectedCountryCode1") private var selectedCountryCode1: String = "+1"
    @AppStorage("emergencyContactName") private var emergencyContactName: String = ""
    @AppStorage("emergencyContactName1") private var emergencyContactName1: String = ""
    @AppStorage("emergencyContactNumber") private var emergencyContactNumber: String = ""
    @AppStorage("emergencyContactNumber1") private var emergencyContactNumber1: String = ""
    @State private var birthDate: Date = Date()
    @AppStorage("birthDate") private var birthDateRaw: TimeInterval = Date().timeIntervalSinceReferenceDate
    @AppStorage("selectedBloodGroup") private var selectedBloodGroup: String = ""
    let checkboxTexts = ["Figma Designer", "IOS Developer", "Flutter Developer", "Node.js Developer", "Android Developer"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    HStack {
                        Text("First Name:")
                        Spacer()
                        Text(firstname)
                    }

                    HStack {
                        Text("Last Name:")
                        Spacer()
                        Text(lastname)
                    }

                    HStack {
                        Text("User Name:")
                        Spacer()
                        Text(username)
                    }
                    HStack {
                        Text("Gender:")
                        Spacer()
                        Text(selectedGender)
                    }
                }
                
                Section(header: Text("Career Preferences")) {
                    HStack {
                        Text("Career")
                        Spacer()
                        Text(selectedOptionsString)
                    }
                }

                Section(header: Text("Contact Information")) {
                    HStack {
                        Text("Phone Number:")
                        Spacer()
                        Text(" \(selectedCountryCode)  \(phoneNumber)")
                    }
                }

                Section(header: Text("Emergency Contacts")) {
                    HStack {
                        Text("Emergency Contact 1:")
                        Spacer()
                        Text("\(emergencyContactName) : \(selectedCountryCode)  \(emergencyContactNumber)")
                    }

                    HStack {
                        Text("Emergency Contact 2:")
                        Spacer()
                        Text("\(emergencyContactName1) : \(selectedCountryCode1)  \(emergencyContactNumber1)")
                    }
                }

                Section(header: Text("Addresses")) {
                    HStack {
                        Text("Permanent Address:")
                        Spacer()
                        Text(PermanentAddress)
                    }

                    HStack {
                        Text("Current Address:")
                        Spacer()
                        Text(CurrentAddress)
                    }
                }

                Section(header: Text("Date of Birth")) {
                    HStack {
                        Text("Birth Date:")
                        Spacer()
                        Text("\(formattedDate(birthDate: birthDate))")
                    }
                }

                Section(header: Text("Blood Group")) {
                    HStack {
                        Text("Blood Group:")
                        Spacer()
                        Text(selectedBloodGroup)
                    }
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

    // Helper function to convert selectedOptionsData to String
    private var selectedOptionsString: String {
            let selectedOptionsTexts = [
                selectedOption1 ? checkboxTexts[0] : "",
                selectedOption2 ? checkboxTexts[1] : "",
                selectedOption3 ? checkboxTexts[2] : "",
                selectedOption4 ? checkboxTexts[3] : "",
                selectedOption5 ? checkboxTexts[4] : "",
                // ... repeat for other options
            ].filter { !$0.isEmpty }

            return selectedOptionsTexts.isEmpty ? "No data" : selectedOptionsTexts.joined(separator: ", ")
        }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
