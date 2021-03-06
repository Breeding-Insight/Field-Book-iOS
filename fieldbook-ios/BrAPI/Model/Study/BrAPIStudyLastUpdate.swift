//
// StudyLastUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** The date and time when this study was last modified */

public struct BrAPIStudyLastUpdate: Codable {

    public var timestamp: Date?
    public var version: String?

    public init(timestamp: Date? = nil, version: String? = nil) {
        self.timestamp = timestamp
        self.version = version
    }


}
