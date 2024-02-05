//
//  InfoResponseModel.swift
//  softo-team
//
//  Created by user on 23/01/2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let personalInfoo = try? JSONDecoder().decode(PersonalInfoo.self, from: jsonData)

import Foundation

// MARK: - PersonalInfoo
struct PersonalInfoo: Codable {
    let firstName, lastName, email, username: String
    let roleName: String
    let roleID: Int
    let personalInfo: PersonalInfo
    let employmentInfo: EmploymentInfo
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName, email, username, roleName
        case roleID = "roleId"
        case personalInfo, employmentInfo, id
    }
}

// MARK: - EmploymentInfo
struct EmploymentInfo: Codable {
    let shiftStart, shiftEnd, joiningDate: String
    let designation: JSONNull?
    let designationID, employmentType: Int
    let employmentTypeName: String
    let employmentStatus: Int
    let employmentStatusName: String
    let level1ManagerID, level1ManagerName, level2ManagerID, level2ManagerName: JSONNull?
    let employmentConfirmationDate: String
    let pastExperience: Int
    
    enum CodingKeys: String, CodingKey {
        case shiftStart, shiftEnd, joiningDate, designation
        case designationID = "designationId"
        case employmentType, employmentTypeName, employmentStatus, employmentStatusName
        case level1ManagerID = "level1ManagerId"
        case level1ManagerName
        case level2ManagerID = "level2ManagerId"
        case level2ManagerName, employmentConfirmationDate, pastExperience
    }
}

// MARK: - PersonalInfo
struct PersonalInfo: Codable {
    let firstName, lastName, username, email: String
    let gender, genderName, dob: String
    let bloodGroup: Int
    let phone, emergencyContactName, emergencyContactPhone, emergencyContactRelationshipName: String
    let emergencyContactRelationshipID: Int
    let permanentAddress, currentAddress: EntAddress
    let cnicFront, cnicBack, profilePicture, bloodGroupName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName, username, email, gender, genderName, dob, bloodGroup, phone, emergencyContactName, emergencyContactPhone, emergencyContactRelationshipName
        case emergencyContactRelationshipID = "emergencyContactRelationshipId"
        case permanentAddress, currentAddress, cnicFront, cnicBack, profilePicture, bloodGroupName
    }
}

// MARK: - EntAddress
struct EntAddress: Codable {
    let addressLine1, addressLine2, city, country: String
    let postalCode: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}




struct LogInResponseModel: Decodable {
    // Define properties matching the structure of the API response
    // For example:
    let token: String
    let refreshToken: String
    // ... other properties
}


struct AuthInfoResponseModel: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let role: String
    let profilePicture: String
    let hasDefaultPassword: Bool
    let shiftStart: String
    let shiftEnd: String
}




