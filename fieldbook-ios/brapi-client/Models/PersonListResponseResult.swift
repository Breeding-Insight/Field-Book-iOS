//
// PersonListResponseResult.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct PersonListResponseResult: Codable {

    /** Array of people */
    public var data: [Person]

    public init(data: [Person]) {
        self.data = data
    }


}
