//
//  Observation.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation

class Observation: ObservableObject {
    
    public var internalId: Int64?
    public var observationUnitId: Int64?
    public var studyId: Int64?
    public var observationVariableId: Int64?
    public var observationVariableName: String?
    public var observationVariableFieldBookFormat: String?
    @Published public var value: String?
    @Published public var observationTimeStamp: String?
    public var collector: String?
    @Published public var geoCoordinates: String?
    public var observationDbId: String?
    @Published public var lastSyncedTime: String?
    public var additionalInfo: String?
    @Published public var rep: String?
    @Published public var notes: String?
}
