//
//  ObservationVariable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation

class ObservationVariable: Codable, Hashable {
    
    public var internalId: Int64?
    public var name: String
    public var dataType: String
    public var fieldBookFormat: TraitFormat?
    public var defaultValue: String?
    public var visible: Bool = true
    public var position: Int64?
    public var externalDbId: String?
    public var traitDataSource: String?
    public var additionalInfo: JSONObject? = JSONObject(value: [:])
    public var commonCropName: String?
    public var language: String?
    public var observationVariableDbId: String?
    public var ontologyDbId: String?
    public var ontologyName: String?
    public var details: String?
    public var attributes: [ObservationVariableAttribute:ObservationVariableAttributeValue]? = [:]
    
    init(name: String, dataType: String) {
        self.name = name
        self.dataType = dataType
    }
    
    static func == (lhs: ObservationVariable, rhs: ObservationVariable) -> Bool {
        return lhs.internalId == rhs.internalId || lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

enum TraitFormat: String, Codable, CaseIterable, Equatable {
    case categorical = "Categorical"
    case date = "Date"
    case numeric = "Numeric"
    case text = "Text"
    case percentage = "Percentage"
    case boolean = "Boolean"
    case audio = "Audio"
    case counter = "Counter"
    case diseaseRating = "Disease Rating"
    case multicat = "Multicat"
    case location = "Location"
    
    func get() -> String {
        switch self {
        default:
            return rawValue
        }
    }
    
    static func from(_ val: String?) -> TraitFormat {
        if val != nil {
            switch val {
            case TraitFormat.categorical.get():
                return TraitFormat.categorical
            case TraitFormat.date.get():
                return TraitFormat.date
            case TraitFormat.numeric.get():
                return TraitFormat.numeric
            case TraitFormat.percentage.get():
                return TraitFormat.percentage
            case TraitFormat.boolean.get():
                return TraitFormat.boolean
            case TraitFormat.audio.get():
                return TraitFormat.audio
            case TraitFormat.counter.get():
                return TraitFormat.counter
            case TraitFormat.diseaseRating.get():
                return TraitFormat.diseaseRating
            case TraitFormat.multicat.get():
                return TraitFormat.multicat
            case TraitFormat.location.get():
                return TraitFormat.location
            case TraitFormat.text.get():
                fallthrough
            default:
                return TraitFormat.text
            }
        }
        
        return TraitFormat.text
    }
}

class ObservationVariableAttribute: Codable, Hashable, Equatable {
    
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

class ObservationVariableAttributeValue: Codable {
    public var internalId: Int64?
    public var attributeId: Int64?
    public var value: String
    public var observationVariableId: Int64?
    
    init(value: String) {
        self.value = value
    }
}
