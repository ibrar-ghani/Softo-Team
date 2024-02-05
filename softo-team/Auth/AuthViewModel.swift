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
    
    // Function to update the user profile
    func updateProfile(request: UpdateProfileRequest, accessToken: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Update the properties in AuthViewModel
        self.firstName = request.firstName
        self.lastName = request.lastName
        self.userName = request.userName
        self.email = request.email
        self.genderName = request.genderName
        self.phone = request.phone
        self.emergencyContactName = request.emergencyContactName
        self.emergencyContactRelationshipName = request.emergencyContactRelationshipName
        self.emergencyContactRelationshipId = request.relationshipId
        self.emergencyContactPhone = request.emergencyContactPhone
        self.currentAddressLine1 = request.currentAddressLine1
        self.currentAddressLine2 = request.currentAddressLine2
        self.currentCity = request.currentCity
        self.currentPostalCode = request.currentPostalCode
        self.currentCountry = request.currentCountry
        self.permanentAddressLine1 = request.permanentAddressLine1
        self.permanentAddressLine2 = request.permanentAddressLine2
        self.permanentCity = request.permanentCity
        self.permanentPostalCode = request.permanentPostalCode
        self.permanentCountry = request.permanentCountry
        self.dob = request.dob
        self.bloodGroupName = request.bloodGroupName
        self.bloodGroup = request.bloodGroupId
        // Update other properties as needed
        
        // Create an instance of URLSession
        guard let url = URL(string: "https://api.staging.softoteam.com/api/v1/Users/PersonalInfo") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"  // Change to PUT
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Convert the request model to JSON data
        do {
            let jsonData = try JSONEncoder().encode(request)
            urlRequest.httpBody = jsonData
        } catch {
            print("Error encoding request model: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }

        // Perform the network request
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // Handle the response or error here
            if let error = error {
                print("Network request error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            // Print HTTP Status Code
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")

                // Handle non-successful status codes
                if !(200..<300).contains(httpResponse.statusCode) {
                    print("Non-successful HTTP status code: \(httpResponse.statusCode)")

                    // Print raw response data
                    if let responseData = data {
                        let responseString = String(data: responseData, encoding: .utf8)
                        print("Raw Response Data: \(responseString ?? "Unable to decode response data")")
                    }

                    // Handle validation errors
                    if let responseData = data {
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                            if let errors = errorResponse.errors {
                                for (field, messages) in errors {
                                    print("Validation error for field '\(field)': \(messages.joined(separator: ", "))")

                                    // Pass the validation error to the completion handler or present to the user
                                    let validationError = ValidationError(field: field, messages: messages)
                                    completion(.failure(validationError))
                                }
                            }
                        } catch {
                            print("Error decoding error response: \(error.localizedDescription)")

                            // Pass the decoding error to the completion handler or present to the user
                            completion(.failure(error))
                        }
                    }

                    // Add more specific error handling based on the status code
                    switch httpResponse.statusCode {
                    case 401:
                        print("Unauthorized: Check authentication or permissions.")
                        // Handle other status codes as needed
                    default:
                        print("Unhandled HTTP status code")
                    }

                    // completion(.failure(YourError.unauthorized)) // Change to your specific error type
                    return
                }


            }

            // Print raw response data
            if let responseData = data {
                let responseString = String(data: responseData, encoding: .utf8)
                print("Raw Response Data: \(responseString ?? "Unable to decode response data")")
            }

            // Add the provided code to handle empty or nil response data
            if let data = data, !data.isEmpty {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response from server: \(jsonResponse)")
                    completion(.success(()))
                } catch {
                    print("Error decoding JSON response: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            } else {
                print("Empty or nil response data")
                // Handle this case as needed
               // completion(.failure(YourError.emptyResponse)) // Change to your specific error type
            }
        }


        // Resume the task
        task.resume()

    }
}

struct UpdateProfileRequest: Codable {
    var firstName: String
    var lastName: String
    var userName: String
    var email: String
    var genderName: String
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


