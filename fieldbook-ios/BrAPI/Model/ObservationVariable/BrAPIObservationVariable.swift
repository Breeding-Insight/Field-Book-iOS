//
// ObservationVariable.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct BrAPIObservationVariable: Codable {

    /** Additional arbitrary info */
    public var additionalInfo: JSONObject?
    /** Crop name (examples: \&quot;Maize\&quot;, \&quot;Wheat\&quot;) */
    public var commonCropName: String?
    /** Indication of how trait is routinely used. (examples: [\&quot;Trial evaluation\&quot;, \&quot;Nursery evaluation\&quot;]) */
    public var contextOfUse: [String]?
    /** Variable default value. (examples: \&quot;red\&quot;, \&quot;2.3\&quot;, etc.) */
    public var defaultValue: String?
    /** A URL to the human readable documentation of this object */
    public var documentationURL: String?
    /** An array of external reference ids. These are references to this piece of data in an external system. Could be a simple string or a URI. */
    public var externalReferences: [BrAPIExternalReferencesInner]?
    /** Growth stage at which measurement is made (examples: \&quot;flowering\&quot;) */
    public var growthStage: String?
    /** Name of institution submitting the variable */
    public var institution: String?
    /** 2 letter ISO 639-1 code for the language of submission of the variable. */
    public var language: String?
    public var method: BrAPIMethod?
    /** Variable unique identifier  MIAPPE V1.1 (DM-83) Variable ID - Code used to identify the variable in the data file. We recommend using a variable definition from the Crop Ontology where possible. Otherwise, the Crop Ontology naming convention is recommended: &lt;trait abbreviation&gt;_&lt;method abbreviation&gt;_&lt;scale abbreviation&gt;). A variable ID must be unique within a given investigation. */
    public var observationVariableDbId: String?
    /** Variable name (usually a short name)  MIAPPE V1.1 (DM-84) Variable name - Name of the variable. */
    public var observationVariableName: String
    public var ontologyReference: BrAPIOntologyReference?
    public var scale: BrAPIScale?
    /** Name of scientist submitting the variable. */
    public var scientist: String?
    /** Variable status. (examples: \&quot;recommended\&quot;, \&quot;obsolete\&quot;, \&quot;legacy\&quot;, etc.) */
    public var status: String?
    /** Timestamp when the Variable was added (ISO 8601) */
    public var submissionTimestamp: Date?
    /** Other variable names */
    public var synonyms: [String]?
    public var trait: BrAPITrait?
    
    private enum CodingKeys: String, CodingKey {
        case additionalInfo
        case commonCropName
        case contextOfUse
        case defaultValue
        case documentationURL
        case externalReferences
        case growthStage
        case institution
        case language
        case method
        case observationVariableDbId
        case observationVariableName
        case ontologyReference
        case scale
        case scientist
        case status
        case submissionTimestamp
        case synonyms
        case trait
    }

    public init(additionalInfo: JSONObject? = nil, commonCropName: String? = nil, contextOfUse: [String]? = nil, defaultValue: String? = nil, documentationURL: String? = nil, externalReferences: [BrAPIExternalReferencesInner]? = nil, growthStage: String? = nil, institution: String? = nil, language: String? = nil, method: BrAPIMethod? = nil, observationVariableDbId: String? = nil, observationVariableName: String, ontologyReference: BrAPIOntologyReference? = nil, scale: BrAPIScale? = nil, scientist: String? = nil, status: String? = nil, submissionTimestamp: Date? = nil, synonyms: [String]? = nil, trait: BrAPITrait? = nil) {
        self.additionalInfo = additionalInfo
        self.commonCropName = commonCropName
        self.contextOfUse = contextOfUse
        self.defaultValue = defaultValue
        self.documentationURL = documentationURL
        self.externalReferences = externalReferences
        self.growthStage = growthStage
        self.institution = institution
        self.language = language
        self.method = method
        self.observationVariableDbId = observationVariableDbId
        self.observationVariableName = observationVariableName
        self.ontologyReference = ontologyReference
        self.scale = scale
        self.scientist = scientist
        self.status = status
        self.submissionTimestamp = submissionTimestamp
        self.synonyms = synonyms
        self.trait = trait
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            additionalInfo = try container.decode(JSONObject.self, forKey: .additionalInfo)
        } catch DecodingError.valueNotFound {
            additionalInfo = nil
        }
        do {
            commonCropName = try container.decode(String.self, forKey: .commonCropName)
        } catch DecodingError.valueNotFound {
            commonCropName = nil
        }
        do {
            contextOfUse = try container.decode([String].self, forKey: .contextOfUse)
        } catch DecodingError.valueNotFound {
            contextOfUse = nil
        }
        do {
            defaultValue = try container.decode(String.self, forKey: .defaultValue)
        } catch DecodingError.valueNotFound {
            defaultValue = nil
        }
        do {
            documentationURL = try container.decode(String.self, forKey: .documentationURL)
        } catch DecodingError.valueNotFound {
            documentationURL = nil
        }
        do {
            externalReferences = try container.decode([BrAPIExternalReferencesInner].self, forKey: .externalReferences)
        } catch DecodingError.valueNotFound {
            externalReferences = nil
        }
        do {
            growthStage = try container.decode(String.self, forKey: .growthStage)
        } catch DecodingError.valueNotFound {
            growthStage = nil
        }
        do {
            institution = try container.decode(String.self, forKey: .institution)
        } catch DecodingError.valueNotFound {
            institution = nil
        }
        do {
            language = try container.decode(String.self, forKey: .language)
        } catch DecodingError.valueNotFound {
            language = nil
        }
        do {
            method = try container.decode(BrAPIMethod.self, forKey: .method)
        } catch DecodingError.valueNotFound {
            method = nil
        }
        do {
            observationVariableDbId = try container.decode(String.self, forKey: .observationVariableDbId)
        } catch DecodingError.typeMismatch {
            observationVariableDbId = try String(container.decode(Int.self, forKey: .observationVariableDbId))
        } catch DecodingError.valueNotFound {
            observationVariableDbId = nil
        }
        do {
            observationVariableName = try container.decode(String.self, forKey: .observationVariableName)
        }
        do {
            ontologyReference = try container.decode(BrAPIOntologyReference.self, forKey: .ontologyReference)
        } catch DecodingError.valueNotFound {
            ontologyReference = nil
        }
        do {
            scale = try container.decode(BrAPIScale.self, forKey: .scale)
        } catch DecodingError.valueNotFound {
            scale = nil
        }
        do {
            scientist = try container.decode(String.self, forKey: .scientist)
        } catch DecodingError.valueNotFound {
            scientist = nil
        }
        do {
            status = try container.decode(String.self, forKey: .status)
        } catch DecodingError.valueNotFound {
            status = nil
        }
        do {
            submissionTimestamp = try container.decode(Date.self, forKey: .submissionTimestamp)
        } catch DecodingError.valueNotFound {
            submissionTimestamp = nil
        }
        do {
            synonyms = try container.decode([String].self, forKey: .synonyms)
        } catch DecodingError.valueNotFound {
            synonyms = nil
        }
        do {
            trait = try container.decode(BrAPITrait.self, forKey: .trait)
        } catch DecodingError.valueNotFound {
            trait = nil
        }
    }

}
