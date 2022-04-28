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
    public var additionalInfo: String?
    public var germplasmDbId: String?
    public var germplasmName: String?
    public var observationLevel: String?
    public var positionCoordinateX: String?
    public var positionCoordinateXType: String?
    public var positionCoordinateY: String?
    public var positionCoordinateYType: String?
    public var attributes: [ObservationUnitAttribute:ObservationUnitAttributeValue]?
}

class ObservationUnitAttribute: Hashable, Equatable {
    
    public var internalId: Int64?
    public var attributeName: String
    public var studyId: Int64
    
    init(attributeName: String, studyId: Int64) {
        self.attributeName = attributeName
        self.studyId = studyId
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(attributeName)
    }
    
    public static func == (lhs: ObservationUnitAttribute, rhs: ObservationUnitAttribute) -> Bool {
        return lhs.attributeName == rhs.attributeName
    }
}

class ObservationUnitAttributeValue {
    public var internalId: Int64?
    public var attributeId: Int64?
    public var value: String
    public var observationUnitId: Int64?
    public var studyId: Int64
    
    init(value: String, studyId: Int64) {
        self.value = value
        self.studyId = studyId
    }
}
