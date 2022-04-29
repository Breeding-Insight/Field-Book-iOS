//
// SearchRequestParametersTrials.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct BrAPISearchRequestParametersTrials: Codable {

    /** The ID which uniquely identifies a trial to search for */
    public var trialDbIds: [String]?
    /** The human readable name of a trial to search for */
    public var trialNames: [String]?

    public init(trialDbIds: [String]? = nil, trialNames: [String]? = nil) {
        self.trialDbIds = trialDbIds
        self.trialNames = trialNames
    }


}