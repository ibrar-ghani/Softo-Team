//
//  InfoResponseModel.swift
//  softo-team
//
//  Created by user on 23/01/2024.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let infoResponseModel = try? JSONDecoder().decode(InfoResponseModel.self, from: jsonData)

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


struct FormattedGender: Decodable {
    let formattedGender: String

    init(gender: String) {
        self.formattedGender = {
            switch gender {
            case "m":
                return "Male"
            case "f":
                return "Female"
            default:
                return "N/A"
            }
        }()
    }
}

struct FormattedBloodGroup: Decodable {
    let formattedBloodGroup: String

    init(bloodGroup: Int) {
        self.formattedBloodGroup = {
            switch bloodGroup {
            case 1:
                return "A+"
            case 2:
                return "A-"
            case 3:
                return "B+"
            case 4:
                return "B-"
            case 5:
                return "AB+"
            case 6:
                return "AB-"
            case 7:
                return "O+"
            case 8:
                return "O-"
            default:
                return "N/A"
            }
        }()
    }
}

struct FormattedRelationship: Decodable {
    let formattedRelationship: String

    init(emergencyContactRelationshipId: Int) {
        self.formattedRelationship = {
            switch emergencyContactRelationshipId {
            case 1:
                return "Father"
            case 2:
                return "Mother"
            case 3:
                return "Brother"
            case 4:
                return "Cousin"
            case 5:
                return "Sister"
            case 6:
                return "Guardian"
            default:
                return "N/A"
            }
        }()
    }
}

struct Address: Decodable {
    let addressLine1: String
    let addressLine2: String
    let city: String
    let country: String
    let postalCode: String
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




