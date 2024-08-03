//
//  Auth.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 17/07/2024.
//

import Foundation

struct User: Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let isEmailVerified: Bool
    let isAdmin: Bool
}

struct SignUpResponseData : Codable {
    let token: String
    let expiresAt: String
    let user : User
}

struct SignUpResponse : Codable {
    let data : SignUpResponseData
}

struct SignUpPayload : Codable {
    let email: String
    let password: String
    let firstName : String
    let lastName : String
}

struct LoginPayload : Codable {
    let email: String
    let password: String
}

struct LoginResponse : Codable {
    let data : SignUpResponseData
}
