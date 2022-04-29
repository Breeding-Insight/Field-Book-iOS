//
//  Dictionary+Extension.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/27/22.
//

import Foundation

extension Dictionary where Key: Codable, Value: Codable {
    func toJsonString() -> String {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(self) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        }
        
        return ""
    }
}

extension Array where Element: Codable {
    func toJsonString() -> String {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(self) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        }
        
        return ""
    }
}
