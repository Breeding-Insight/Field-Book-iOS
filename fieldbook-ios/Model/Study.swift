//
//  Study.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation

class Study: Hashable, Equatable, ObservableObject {
    
    @Published public var internalId: Int64?
    public var studyDbId: String?
    public var name: String
    public var alias: String?
    public var uniqueIdName: String?
    public var primaryIdName: String?
    public var secondaryIdName: String?
    public var experimentalDesign: String?
    public var commonCropName: String?
    public var sortName: String?
    public var dateImport: Date?
    public var dateEdit: Date?
    public var dateExport: Date?
    public var source: String?
    public var additionalInfo: String?
    public var locationDbId: String?
    public var locationName: String?
    public var observationLevels: String?
    public var seasons: String?
    public var startDate: Date?
    public var code: String?
    public var description: String?
    public var type: String?
    public var trialDbId: String?
    public var trialName: String?
    public var count: Int64?
    public var observationUnits: [ObservationUnit] = []
    public var observationVariables: [ObservationVariable] = []
    @Published public var observations: [Observation] = []
    public var attributes: Set<String> = []
    
    init(name: String) {
        self.name = name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Study, rhs: Study) -> Bool {
        return lhs.internalId == rhs.internalId
    }
}
