// AuthViewModel.swift

import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    static let shared = AuthViewModel()
    
    @Published var isLoggedIn: Bool = false
    @Published var accessToken: String = ""
    @Published var refreshToken: String = ""
    @Published var userId: Int = 0
    @Published var personalInfo: PersonalInfoo?
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var userName: String = ""
    @Published var email: String = "" // Changed from Email to email for naming convention
    @Published var dob: String = ""
    @Published var gender: String = ""
    @Published var genderName: String = ""
    @Published var bloodGroup: Int = 0
    @Published var bloodGroupName: String = ""
    @Published var phone: String = ""
    @Published var emergencyContactName: String = ""
    @Published var emergencyContactPhone: String = ""
    @Published var emergencyContactRelationshipId: Int = 0
    @Published var emergencyContactRelationshipName: String = ""
    @Published var permanentAddressLine1: String = ""
    @Published var permanentAddressLine2: String = ""
    @Published var permanentCity: String = ""
    @Published var permanentCountry: String = ""
    @Published var permanentPostalCode: String = ""
    @Published var currentAddressLine1: String = ""
    @Published var currentAddressLine2: String = ""
    @Published var currentCity: String = ""
    @Published var currentCountry: String = ""
    @Published var currentPostalCode: String = ""
    
    // Function to set tokens when logged in
    func setTokens(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.isLoggedIn = true
        
        // Print tokens for debugging
        print("Access Token: \(accessToken)")
        print("Refresh Token: \(refreshToken)")
    }
    
    // Function to clear tokens when logged out
    func clearTokens() {
        self.accessToken = ""
        self.refreshToken = ""
        self.isLoggedIn = false
    }
    
    // Function to set userId
    func setUserId(userId: Int) {
        self.userId = userId
        
        // Print user ID for debugging
        print("User ID: \(userId)")
    }
    
    // Check if the user is already logged in
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser != nil {
            self.isLoggedIn = true
        }
    }
    
    // Sign out user
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            completion(nil)
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
            completion(error)
        }
    }
    
    // Function to set personal details
    func setPersonalDetails(personalInfo: PersonalInfoo) {
        // Assuming personalInfo.personalInfo is not an optional
        let receivedPersonalInfo = personalInfo.personalInfo
        
        // Check if receivedPersonalInfo is not nil
        if receivedPersonalInfo != nil {
            
            // Set other properties based on the received personalInfo
            self.firstName = receivedPersonalInfo.firstName
            self.lastName = receivedPersonalInfo.lastName
            self.userName = receivedPersonalInfo.username
            self.email = receivedPersonalInfo.email
            self.dob = receivedPersonalInfo.dob
            self.gender = receivedPersonalInfo.gender
            self.genderName = receivedPersonalInfo.genderName
            self.bloodGroup = receivedPersonalInfo.bloodGroup
            self.bloodGroupName = receivedPersonalInfo.bloodGroupName
            self.phone = receivedPersonalInfo.phone
            self.emergencyContactName = receivedPersonalInfo.emergencyContactName
            self.emergencyContactPhone = receivedPersonalInfo.emergencyContactPhone
            self.emergencyContactRelationshipId = receivedPersonalInfo.emergencyContactRelationshipID
            self.emergencyContactRelationshipName = receivedPersonalInfo.emergencyContactRelationshipName
            
            // Assuming these properties are String
            self.permanentAddressLine1 = receivedPersonalInfo.permanentAddress.addressLine1
            self.permanentAddressLine2 = receivedPersonalInfo.permanentAddress.addressLine2
            self.permanentCity = receivedPersonalInfo.permanentAddress.city
            self.permanentCountry = receivedPersonalInfo.permanentAddress.country
            self.permanentPostalCode = receivedPersonalInfo.permanentAddress.postalCode
            
            // Similar assignments for current address
            self.currentAddressLine1 = receivedPersonalInfo.currentAddress.addressLine1
            self.currentAddressLine2 = receivedPersonalInfo.currentAddress.addressLine2
            self.currentCity = receivedPersonalInfo.currentAddress.city
            self.currentCountry = receivedPersonalInfo.currentAddress.country
            self.currentPostalCode = receivedPersonalInfo.currentAddress.postalCode
            
            // You can also update other properties or perform additional actions here
            print("Personal details set successfully")
        }else {
            print("PersonalInfoo.personalInfo is nil")
        }
    }
    
    // Function to convert personal details to UpdateProfileRequest
    func toUpdateProfileRequest() -> UpdateProfileRequest {
        return UpdateProfileRequest(
            firstName: firstName,
            lastName: lastName,
            userName: userName,
            email: email,
            genderName: genderName,
            gender: gender,
            phone: phone,
            emergencyContactName: emergencyContactName,
            emergencyContactRelationshipName: emergencyContactRelationshipName,
            relationshipId: emergencyContactRelationshipId,
            emergencyContactPhone: emergencyContactPhone,
            currentAddressLine1: currentAddressLine1,
            currentAddressLine2: currentAddressLine2,
            currentCity: currentCity,
            currentPostalCode: currentPostalCode,
            currentCountry: currentCountry,
            permanentAddressLine1: permanentAddressLine1,
            permanentAddressLine2: permanentAddressLine2,
            permanentCity: permanentCity,
            permanentPostalCode: permanentPostalCode,
            permanentCountry: permanentCountry,
            dob: dob,
            bloodGroupName: bloodGroupName,
            bloodGroupId: bloodGroup
            // Include other properties as needed
        )
    }
    
    // Function to set user profile data
    private func setUserProfileData(request: UpdateProfileRequest) -> UpdatepersonalInfoo {
        let updatedInfo = UpdatepersonalInfoo(
            firstName: request.firstName,
            lastName: request.lastName,
            dob: request.dob,
            gender: request.gender,
            bloodGroup: request.bloodGroupId,
            phone: request.phone,
            emergencyContactName: request.emergencyContactName,
            emergencyContactPhone: request.emergencyContactPhone,
            emergencyContactRelationshipID: request.relationshipId,
            permanentAddress: EnAddress(
                addressLine1: request.permanentAddressLine1,
                addressLine2: request.permanentAddressLine2,
                city: request.permanentCity,
                country: request.permanentCountry,
                postalCode: request.permanentPostalCode
            ),
            currentAddress: EnAddress(
                addressLine1: request.currentAddressLine1,
                addressLine2: request.currentAddressLine2,
                city: request.currentCity,
                country: request.currentCountry,
                postalCode: request.currentPostalCode
            ),
            profilePicture: "", // You need to provide a default value or update this based on your logic
            cnicFront: "", // You need to provide a default value or update this based on your logic
            cnicBack: "" // You need to provide a default value or update this based on your logic
        )
        
        // You can update other properties as needed
        
        return updatedInfo
        
    }
    
    // Function to update the user profile
    func updateProfile(request: UpdateProfileRequest, accessToken: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        // Set user profile data
        guard let url = URL(string: "https://api.staging.softoteam.com/api/v1/Users/\(userId)/PersonalInfo") else {
            print("Error: cannot create URL")
            return
        }
        
        // Get updated personal info from the request
        let updatedPersonalInfo = setUserProfileData(request: request)
        print("personal info : \(updatedPersonalInfo)")
        // Convert model to JSON data
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(updatedPersonalInfo) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        let authToken = accessToken
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")

        request.httpBody = jsonData
        print("Request jsonBody: \(jsonData) ")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling PUT")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
//            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
//                print("Error: HTTP request failed")
//                return
//            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
}

struct UpdateProfileRequest: Codable {
    var firstName: String
    var lastName: String
    var userName: String
    var email: String
    var genderName: String
    var gender: String
    var phone: String
    var emergencyContactName: String
    var emergencyContactRelationshipName: String
    var relationshipId: Int
    var emergencyContactPhone: String
    var currentAddressLine1: String
    var currentAddressLine2: String
    var currentCity: String
    var currentPostalCode: String
    var currentCountry: String
    var permanentAddressLine1: String
    var permanentAddressLine2: String
    var permanentCity: String
    var permanentPostalCode: String
    var permanentCountry: String
    var dob: String
    var bloodGroupName: String
    var bloodGroupId: Int
    // Add other properties as needed
}

enum NetworkError: Error {
    case invalidURL
}

struct ErrorResponse: Codable {
    let type: String
    let title: String
    let status: Int
    let traceId: String
    let errors: [String: [String]]?
}

struct ValidationError: Error {
    let field: String
    let messages: [String]
}


