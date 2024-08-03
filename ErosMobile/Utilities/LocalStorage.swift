//
//  AppStorageManager.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 28/07/2024.
//

import Foundation

class LocalStorage{
    
static func saveDataToAppStorage<T: Codable>(_ data: T, key: String) {
        if let encodedData = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }

static func decodeDataFromAppStorage<T: Codable>(key: String, type: T.Type) -> T? {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decodedData = try? JSONDecoder().decode(T.self, from: savedData) {
            return decodedData
        }
        return nil
    }
    
}
