//
//  Api.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 17/07/2024.
//

import Foundation
import SwiftUI

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum MyError: Error {
    case badParsing
    case badRequest(String)
    case networkError(Error)
    case invalidHTTPStatusCode
    case UnAuthorized
}

struct GenericErrorResponse: Decodable {
    let message: String?
}

let baseUrl: String = {
    guard let url = ProcessInfo.processInfo.environment["BASE_URL"] else {
        fatalError("BASE_URL not set")
    }
    return url
}()

func makeApiCall<T : Decodable , P : Encodable>(endpoint: String, method: HTTPMethod, body: P? = nil) async throws -> T?  {
    @AppStorage("token") var token: String = ""
    if let url = URL(string:  endpoint) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let userData: SignUpResponseData = LocalStorage.decodeDataFromAppStorage(key: "userData", type: SignUpResponseData.self) {
            request.addValue("Bearer \(userData.token)", forHTTPHeaderField: "Authorization")
        }
        if(body != nil){
            request.httpBody = try JSONEncoder().encode(body) // Use JSONEncoder
            //  request.httpBody = try JSONSerialization.data(withJSONObject: body!)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse , response.statusCode != 401 else {
            throw MyError.UnAuthorized
        }
        
     
        
        if (400...499).contains(response.statusCode) {
            
            if let errorResponse = try? JSONDecoder().decode(GenericErrorResponse.self, from: data) {
                throw MyError.badRequest(errorResponse.message ?? "unknown")
            }
            
            throw MyError.badRequest("Please check your data")
        }
        do{
            let decodedData = try JSONDecoder().decode(T.self, from: data)
           // print(decodedData)
            return decodedData
        } catch {
            
            throw MyError.badParsing
            
        }
        
    }
    return nil
}
