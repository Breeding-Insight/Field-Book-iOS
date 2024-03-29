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
    @Published public var observationTimeStamp: Date?
    public var collector: String?
    @Published public var geoCoordinates: String?
    public var observationDbId: String?
    @Published public var lastSyncedTime: Date?
    public var additionalInfo: String?
    @Published public var rep: String?
    @Published public var notes: String?
    
    init() {}
    
    init(observationUnitId: Int64, studyId: Int64, observationVariableId: Int64) {
        self.observationUnitId = observationUnitId
        self.studyId = studyId
        self.observationVariableId = observationVariableId
    }
}
