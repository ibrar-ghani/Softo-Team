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
    
    @State private var editedFirstName: String = ""
    @State private var editedLastName: String = ""
    @State private var editeduserName: String = ""
    @State private var editedEmail: String = ""
    @State private var editedgenderName: String = ""
    @State private var editedGender: String = ""
    @State private var editedphone: String = ""
    @State private var editedemergencyContactName: String = ""
    @State private var editedemergencyContactRelationshipName: String = ""
    @State private var editedemergencyContactRelationshipId: Int = 0
    @State private var editedemergencyContactPhone: String = ""
    @State private var editedcurrentAddressLine1: String = ""
    @State private var editedcurrentAddressLine2: String = ""
    @State private var editedcurrentCity: String = ""
    @State private var editedcurrentPostelcode: String = ""
    @State private var editedcurrentCountry: String = ""
    @State private var editedpermanentAddressLine1: String = ""
    @State private var editedpermanentAddressLine2: String = ""
    @State private var editedpermanentCity: String = ""
    @State private var editedpermanentPostelcode: String = ""
    @State private var editedpermanentCountry: String = ""
    @State private var editeddob: String = ""
    @State private var editedbloodGroupName: String = ""
    @State private var editedbloodGroup: Int = 0
    @State private var isEditing = false
    @State private var isDataAvailable = false
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    let bloodGroupOptions = ["1", "2", "3", "4", "5", "6", "7", "8"]
    let genderOptions = ["Male", "Female", "Other"]
    let emergencyContactRelationOptions = ["Father", "Mother", "Brother", "Cousin", "Sister","Guardian"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    HStack {
                        Text("First Name:")
                        Spacer()
                        if isEditing {
                            TextField("Enter First Name", text: $editedFirstName)
                        } else {
                            Text(authViewModel.firstName)
                        }
                    }
                    
                    HStack {
                        Text("Last Name:")
                        Spacer()
                        if isEditing {
                            TextField("Enter Last Name", text: $editedLastName)
                        } else {
                            Text(authViewModel.lastName)
                        }
                    }
                    
                    HStack {
                        Text("User Name:")
                        Spacer()
                        if isEditing {
                            TextField("Enter User Name", text: $editeduserName)
                        } else {
                            Text(authViewModel.userName)
                        }
                    }
                    
                    HStack {
                        Text("Email:")
                        Spacer()
                        if isEditing {
                            TextField("Enter Email", text: $editedEmail)
                        } else {
                            Text(authViewModel.email)
                        }
                    }
                    
                    
                    HStack {
                        Text("Gender:")
                        Spacer()
                        if isEditing {
                            Picker("Select Gender", selection: $editedGender) {
                                ForEach(Gender.allCases, id: \.id) { gender in
                                    Text(gender.displayName) // Display "Male" or "Female" in the picker
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        } else {
                            Text(authViewModel.genderName)
                        }
                    }
                }
                
                Section(header: Text("Contact Information")) {
                    HStack {
                        Text("Phone:")
                        Spacer()
                        if isEditing {
                            TextField("Enter Phone Number", text: $editedphone)
                        } else {
                            Text(authViewModel.phone)
                        }
                    }
                }
                
                Section(header: Text("Emergency Contacts")) {
                    if isEditing {
                        HStack {
                            TextField("Enter Emergency Contact Name", text: $editedemergencyContactName)
                        }
                        
                        HStack {
                            Picker("Select Relationship", selection: $editedemergencyContactRelationshipName) {
                                ForEach(emergencyContactRelationOptions, id: \.self) { relation in
                                    Text(relation)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        
                        
                        HStack {
                            TextField("Enter Emergency Contact Phone", text: $editedemergencyContactPhone)
                        }
                    } else {
                        HStack {
                            Text("Emergency Contact:")
                                .font(.headline)
                            Spacer()
                        }
                        
                        HStack {
                            Text("Name:")
                            Spacer()
                            Text(authViewModel.emergencyContactName)
                        }
                        
                        HStack {
                            Text("Relation:")
                            Spacer()
                            Text(authViewModel.emergencyContactRelationshipName)
                        }
                        
                        HStack {
                            Text("Phone:")
                            Spacer()
                            Text(authViewModel.emergencyContactPhone)
                        }
                    }
                }
                
                
                Section(header: Text("Addresses")) {
                    if isEditing {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Present Address:")
                                    .font(.headline)
                                TextField("Enter State", text: $editedcurrentAddressLine1)
                                TextField("Enter State", text: $editedcurrentAddressLine2)
                                TextField("Enter City", text: $editedcurrentCity)
                                TextField("Enter Postal Code", text: $editedcurrentPostelcode)
                                TextField("Enter Country", text: $editedcurrentCountry)
                            }
                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Permanent Address:")
                                    .font(.headline)
                                TextField("Enter State", text: $editedpermanentAddressLine1)
                                TextField("Enter State", text: $editedpermanentAddressLine2)
                                TextField("Enter City", text: $editedpermanentCity)
                                TextField("Enter Postal Code", text: $editedpermanentPostelcode)
                                TextField("Enter Country", text: $editedpermanentCountry)
                            }
                        }
                    } else {
                        HStack {
                            Text("Present Address:")
                                .font(.headline)
                            Spacer()
                        }
                        
                        HStack {
                            Text("State:")
                            Spacer()
                            Text("\(authViewModel.currentAddressLine1)")
                        }
                        
                        HStack {
                            Text("City:")
                            Spacer()
                            Text("\(authViewModel.currentCity)")
                        }
                        
                        HStack {
                            Text("Postal Code:")
                            Spacer()
                            Text("\(authViewModel.currentPostalCode)")
                        }
                        
                        HStack {
                            Text("Country:")
                            Spacer()
                            Text("\(authViewModel.currentCountry)")
                        }
                        
                        HStack {
                            Text("Permanent Address:")
                                .font(.headline)
                            Spacer()
                        }
                        
                        HStack {
                            Text("State:")
                            Spacer()
                            Text("\(authViewModel.permanentAddressLine1)")
                        }
                        
                        HStack {
                            Text("City:")
                            Spacer()
                            Text("\(authViewModel.permanentCity)")
                        }
                        
                        HStack {
                            Text("Postal Code:")
                            Spacer()
                            Text("\(authViewModel.permanentPostalCode)")
                        }
                        
                        HStack {
                            Text("Country:")
                            Spacer()
                            Text("\(authViewModel.permanentCountry)")
                        }
                    }
                }
                
                
                Section(header: Text("Date of Birth")) {
                    HStack {
                        Text("Birth Date:")
                        Spacer()
                        if isEditing {
                            TextField("Enter Birth Date ", text: $editeddob)
                        } else {
                            Text(authViewModel.dob)
                        }
                    }
                }
                
                Section(header: Text("Blood Group")) {
                    HStack {
                        Text("Blood Group:")
                        Spacer()
                        if isEditing {
                            Picker("Select Blood Group", selection: $editedbloodGroup) {
                                ForEach(bloodGroupOptions, id: \.self) { bloodGroupId in
                                    Text(BloodGroup.nameFromId(Int(bloodGroupId) ?? 0) ?? "")
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        } else {
                            Text(authViewModel.bloodGroupName)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        if isEditing {
                        editedemergencyContactRelationshipId = Relationship.idFromName(editedemergencyContactRelationshipName) ?? 0

                            let updateRequest = UpdateProfileRequest(
                                firstName: editedFirstName,
                                lastName: editedLastName,
                                userName: editeduserName,
                                email: editedEmail,
                                genderName: editedgenderName,
                                phone: editedphone,
                                emergencyContactName: editedemergencyContactName,
                                emergencyContactRelationshipName: editedemergencyContactRelationshipName,
                                relationshipId: editedemergencyContactRelationshipId,
                                emergencyContactPhone: editedemergencyContactPhone,
                                currentAddressLine1: editedcurrentAddressLine1,
                                currentAddressLine2: editedcurrentAddressLine2,
                                currentCity: editedcurrentCity,
                                currentPostalCode: editedcurrentPostelcode,
                                currentCountry: editedcurrentCountry,
                                permanentAddressLine1: editedpermanentAddressLine1,
                                permanentAddressLine2: editedpermanentAddressLine2,
                                permanentCity: editedpermanentCity,
                                permanentPostalCode: editedpermanentPostelcode,
                                permanentCountry: editedpermanentCountry,
                                dob: editeddob,
                                bloodGroupName: editedbloodGroupName,
                                bloodGroupId: editedbloodGroup
                                // Add other properties as needed
                            )
                            authViewModel.updateProfile(request: updateRequest, accessToken: authViewModel.accessToken){ result in
                                switch result {
                                case .success:
                                    // Update was successful, you can perform any additional actions here if needed.
                                    print("Profile updated successfully")
                                case .failure(let error):
                                    // Handle the error, you can display an alert or perform any other error-handling logic.
                                    print("Error updating profile: \(error.localizedDescription)")
                                }
                            }
                            // Reset editing state
                            isEditing = false
                        } else {
                            // Start editing
                            editedFirstName = authViewModel.firstName
                            editedLastName = authViewModel.lastName
                            editeduserName = authViewModel.userName
                            editedEmail = authViewModel.email
                            editedphone = authViewModel.phone
                            editedgenderName = authViewModel.genderName
                            editedGender = authViewModel.gender
                            editedemergencyContactName = authViewModel.emergencyContactName
                            editedemergencyContactRelationshipName = authViewModel.emergencyContactRelationshipName
                            editedemergencyContactPhone = authViewModel.emergencyContactPhone
                            editedcurrentAddressLine1 = authViewModel.currentAddressLine1
                            editedcurrentAddressLine2 = authViewModel.currentAddressLine2
                            editedcurrentCity = authViewModel.currentCity
                            editedcurrentPostelcode = authViewModel.currentPostalCode
                            editedcurrentCountry = authViewModel.currentCountry
                            editedpermanentAddressLine1 = authViewModel.permanentAddressLine1
                            editedpermanentAddressLine2 = authViewModel.permanentAddressLine2
                            editedpermanentCity = authViewModel.permanentCity
                            editedpermanentPostelcode = authViewModel.permanentPostalCode
                            editedpermanentCountry = authViewModel.permanentCountry
                            editeddob = authViewModel.dob
                            editedbloodGroupName = authViewModel.bloodGroupName
                            // Initialize other edited fields
                            isEditing = true
                        }
                    }) {
                        Text(isEditing ? "Save Changes" : "Edit Profile")
                    }
                }
            }.onAppear {
                // Set initial values for editable fields
                editedFirstName = authViewModel.firstName
                editedLastName = authViewModel.lastName
                editeduserName = authViewModel.userName
                editedEmail = authViewModel.email
                editedgenderName = authViewModel.genderName
                editedphone = authViewModel.phone
                editedemergencyContactName = authViewModel.emergencyContactName
                editedemergencyContactRelationshipName = authViewModel.emergencyContactRelationshipName
                editedemergencyContactRelationshipId = authViewModel.emergencyContactRelationshipId
                editedemergencyContactPhone = authViewModel.emergencyContactPhone
                editeddob = authViewModel.dob
                editedcurrentAddressLine1 = authViewModel.currentAddressLine1
                editedcurrentAddressLine2 = authViewModel.currentAddressLine2
                editedcurrentCity = authViewModel.currentCity
                editedcurrentPostelcode = authViewModel.currentPostalCode
                editedcurrentCountry = authViewModel.currentCountry
                editedpermanentAddressLine1 = authViewModel.permanentAddressLine1
                editedpermanentAddressLine2 = authViewModel.permanentAddressLine2
                editedpermanentCity = authViewModel.permanentCity
                editedpermanentPostelcode = authViewModel.permanentPostalCode
                editedpermanentCountry = authViewModel.permanentCountry
                editedbloodGroupName = authViewModel.bloodGroupName
                editedbloodGroup = authViewModel.bloodGroup
                editedGender = authViewModel.gender
                // Initialize other editable fields as needed
            }
        }
        .navigationTitle("Profile")
    }
}
// Add the BloodGroup enum here
enum BloodGroup: String, CaseIterable {
    case aPositive = "A+"
    case aNegative = "A-"
    case bPositive = "B+"
    case bNegative = "B-"
    case abPositive = "AB+"
    case abNegative = "AB-"
    case oPositive = "O+"
    case oNegative = "O-"

    var id: Int {
        switch self {
        case .aPositive: return 1
        case .aNegative: return 2
        case .bPositive: return 3
        case .bNegative: return 4
        case .abPositive: return 5
        case .abNegative: return 6
        case .oPositive: return 7
        case .oNegative: return 8
        }
    }

    static func nameFromId(_ id: Int) -> String? {
            guard let bloodGroup = BloodGroup.allCases.first(where: { $0.id == id }) else {
                return nil
            }
            return bloodGroup.rawValue
        }
}

// Add the Relationship enum here
enum Relationship: String, CaseIterable {
    case father
    case mother
    case brother
    case cousin
    case sister
    case guardian

    var id: Int {
        switch self {
        case .father: return 1
        case .mother: return 2
        case .brother: return 3
        case .cousin: return 4
        case .sister: return 5
        case .guardian: return 6
        }
    }

    static func idFromName(_ name: String) -> Int? {
        guard let relationship = Relationship(rawValue: name.lowercased()) else {
            return nil
        }
        return relationship.id
    }
}

enum Gender: String, CaseIterable {
    case male = "m"
    case female = "f"
    case other = "o" // You can add another case for "Other" if needed

    var displayName: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .other:
            return "Other"
        }
    }

    var id: String {
        return rawValue
    }

    static func nameFromId(_ id: String) -> String? {
        guard let gender = Gender(rawValue: id.lowercased()) else {
            return nil
        }
        return gender.displayName
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
