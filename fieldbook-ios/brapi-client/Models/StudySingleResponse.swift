//
// StudySingleResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct StudySingleResponse: Codable {

    public var context: Context?
    public var metadata: Metadata
    public var result: Study

    public init(context: Context? = nil, metadata: Metadata, result: Study) {
        self.context = context
        self.metadata = metadata
        self.result = result
    }

    public enum CodingKeys: String, CodingKey { 
        case context = "@context"
        case metadata
        case result
    }

}
