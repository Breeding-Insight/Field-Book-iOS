//
//  ObservationVariable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation

class ObservationVariable {
    public var internalId: Int64?
    public var name: String
    public var dataType: String
    public var fieldBookFormat: String?
    public var defaultValue: String?
    public var visible: Bool = true
    public var position: Int64?
    public var externalDbId: String?
    public var traitDataSource: String?
    public var additionalInfo: String?
    public var commonCropName: String?
    public var language: String?
    public var observationVariableDbId: String?
    public var ontologyDbId: String?
    public var ontologyName: String?
    public var details: String?
    public var attributes: [ObservationVariableAttribute:ObservationVariableAttributeValue]?
    
    init(name: String, dataType: String) {
        self.name = name
        self.dataType = dataType
    }
}

class ObservationVariableAttribute: Hashable, Equatable {
    
    public var internalId: Int64?
    public var attributeName: String
    
    init(attributeName: String) {
        self.attributeName = attributeName
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(attributeName)
    }
    
    public static func == (lhs: ObservationVariableAttribute, rhs: ObservationVariableAttribute) -> Bool {
        return lhs.attributeName == rhs.attributeName
    }
    
}

class ObservationVariableAttributeValue {
    public var internalId: Int64?
    public var attributeId: Int64?
    public var value: String
    public var observationVariableId: Int64?
    
    init(value: String) {
        self.value = value
    }
}
