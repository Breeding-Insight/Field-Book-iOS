//
//  ObservationVariable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation

class ObservationUnit {
    
    public var internalId: Int64?
    public var studyId: Int64?
    public var observationunitDbId: String?
    public var primaryId: String?
    public var secondaryId: String?
    public var geoCoordinates: String?
    public var additionalInfo: [String:String]? = [:]
    public var germplasmDbId: String?
    public var germplasmName: String?
    public var observationLevel: String?
    public var positionCoordinateX: String?
    public var positionCoordinateXType: String?
    public var positionCoordinateY: String?
    public var positionCoordinateYType: String?
    public var attributes: [ObservationUnitAttribute:ObservationUnitAttributeValue]? = [:]
    public var observations: [Observation]? = []
}

class ObservationUnitAttribute: Codable, Hashable, Equatable {
    
    public var internalId: Int64?
    public var attributeName: String
    public var studyId: Int64?
    
    init(attributeName: String) {
        self.attributeName = attributeName
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(attributeName)
    }
    
    public static func == (lhs: ObservationUnitAttribute, rhs: ObservationUnitAttribute) -> Bool {
        return lhs.attributeName == rhs.attributeName
    }
}

class ObservationUnitAttributeValue: Codable {
    public var internalId: Int64?
    public var attributeId: Int64?
    public var value: String
    public var observationUnitId: Int64?
    public var studyId: Int64?
    
    init(value: String) {
        self.value = value
    }
}
