//
//  AuthViewModel.swift
//  softo-team
//
//  Created by user on 24/01/2024.
//

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
    @Published var Email: String = ""
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
    func setuserId(userId: Int) {
        self.userId = userId

        // Print tokens for debugging
        print("User Id: \(userId)")
    }
    // Check if user already loged in
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser != nil {
            self.isLoggedIn = true
        }
    }
    
    // Sign out user
    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch let error as NSError {
            print("Error signing out: %@", error)
        }
    }
    
    // Function to set personal details
       func setPersonalDetails(personalInfo: PersonalInfoo) {
           let receivedPersonalInfo = personalInfo.personalInfo
           
           // Set other properties based on the received personalInfo
           if receivedPersonalInfo != nil{
           self.firstName = receivedPersonalInfo.firstName
           self.lastName = receivedPersonalInfo.lastName
           self.userName = receivedPersonalInfo.username
           self.Email = receivedPersonalInfo.email
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
               } else {
                   print("PersonalInfoo.personalInfo is nil")
               }
}
    
}
