//
// ObservationTableObservationVariables.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ObservationTableObservationVariables: Codable {

    /** Variable unique identifier */
    public var observationVariableDbId: String?
    /** Variable name (usually a short name) */
    public var observationVariableName: String?

    public init(observationVariableDbId: String? = nil, observationVariableName: String? = nil) {
        self.observationVariableDbId = observationVariableDbId
        self.observationVariableName = observationVariableName
    }


}
