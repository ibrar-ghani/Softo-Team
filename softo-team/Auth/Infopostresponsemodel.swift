// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let personalInfoo = try? JSONDecoder().decode(PersonalInfoo.self, from: jsonData)

import Foundation

// MARK: - PersonalInfoo
struct UpdatepersonalInfoo: Codable {
    let firstName, lastName, dob, gender: String
    let bloodGroup: Int
    let phone, emergencyContactName, emergencyContactPhone: String
    let emergencyContactRelationshipID: Int
    let permanentAddress, currentAddress: EnAddress
    let profilePicture, cnicFront, cnicBack: String

    enum CodingKeys: String, CodingKey {
        case firstName, lastName, dob, gender, bloodGroup, phone, emergencyContactName, emergencyContactPhone
        case emergencyContactRelationshipID = "emergencyContactRelationshipId"
        case permanentAddress, currentAddress, profilePicture, cnicFront, cnicBack
    }
}

// MARK: - EntAddress
struct EnAddress: Codable {
    let addressLine1, addressLine2, city, country: String
    let postalCode: String
}
