//
// ListNewRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ListNewRequest: Codable {

    public enum ListType: String, Codable { 
        case germplasm = "germplasm"
        case markers = "markers"
        case programs = "programs"
        case trials = "trials"
        case studies = "studies"
        case observationunits = "observationUnits"
        case observations = "observations"
        case observationvariables = "observationVariables"
        case samples = "samples"
    }
    /** Additional arbitrary info */
    public var additionalInfo: [String:String]?
    /** The list of DbIds contained in this list */
    public var data: [String]?
    /** Timestamp when the entity was first created */
    public var dateCreated: Date?
    /** Timestamp when the entity was last updated */
    public var dateModified: Date?
    /** An array of external reference ids. These are references to this piece of data in an external system. Could be a simple string or a URI. */
    public var externalReferences: [ExternalReferencesInner]?
    /** Description of a List */
    public var listDescription: String?
    /** Human readable name of a List */
    public var listName: String?
    /** Human readable name of a List Owner. (usually a user or person) */
    public var listOwnerName: String?
    /** The unique identifier for a List Owner. (usually a user or person) */
    public var listOwnerPersonDbId: String?
    /** The number of elements in a List */
    public var listSize: Int?
    /** The description of where a List originated from */
    public var listSource: String?
    public var listType: ListType?

    public init(additionalInfo: [String:String]? = nil, data: [String]? = nil, dateCreated: Date? = nil, dateModified: Date? = nil, externalReferences: [ExternalReferencesInner]? = nil, listDescription: String? = nil, listName: String? = nil, listOwnerName: String? = nil, listOwnerPersonDbId: String? = nil, listSize: Int? = nil, listSource: String? = nil, listType: ListType? = nil) {
        self.additionalInfo = additionalInfo
        self.data = data
        self.dateCreated = dateCreated
        self.dateModified = dateModified
        self.externalReferences = externalReferences
        self.listDescription = listDescription
        self.listName = listName
        self.listOwnerName = listOwnerName
        self.listOwnerPersonDbId = listOwnerPersonDbId
        self.listSize = listSize
        self.listSource = listSource
        self.listType = listType
    }


}
