//
// ListSearchRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ListSearchRequest: Codable {

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
    public var dateCreatedRangeEnd: Date?
    public var dateCreatedRangeStart: Date?
    public var dateModifiedRangeEnd: Date?
    public var dateModifiedRangeStart: Date?
    /** List of external reference IDs. Could be a simple strings or a URIs. (use with &#x60;externalReferenceSources&#x60; parameter) */
    public var externalReferenceIDs: [String]?
    /** List of identifiers for the source system or database of an external reference (use with &#x60;externalReferenceIDs&#x60; parameter) */
    public var externalReferenceSources: [String]?
    public var listDbIds: [String]?
    public var listNames: [String]?
    public var listOwnerNames: [String]?
    public var listOwnerPersonDbIds: [String]?
    public var listSources: [String]?
    public var listType: ListType?
    /** Which result page is requested. The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. */
    public var page: Int?
    /** The size of the pages to be returned. Default is &#x60;1000&#x60;. */
    public var pageSize: Int?

    public init(dateCreatedRangeEnd: Date? = nil, dateCreatedRangeStart: Date? = nil, dateModifiedRangeEnd: Date? = nil, dateModifiedRangeStart: Date? = nil, externalReferenceIDs: [String]? = nil, externalReferenceSources: [String]? = nil, listDbIds: [String]? = nil, listNames: [String]? = nil, listOwnerNames: [String]? = nil, listOwnerPersonDbIds: [String]? = nil, listSources: [String]? = nil, listType: ListType? = nil, page: Int? = nil, pageSize: Int? = nil) {
        self.dateCreatedRangeEnd = dateCreatedRangeEnd
        self.dateCreatedRangeStart = dateCreatedRangeStart
        self.dateModifiedRangeEnd = dateModifiedRangeEnd
        self.dateModifiedRangeStart = dateModifiedRangeStart
        self.externalReferenceIDs = externalReferenceIDs
        self.externalReferenceSources = externalReferenceSources
        self.listDbIds = listDbIds
        self.listNames = listNames
        self.listOwnerNames = listOwnerNames
        self.listOwnerPersonDbIds = listOwnerPersonDbIds
        self.listSources = listSources
        self.listType = listType
        self.page = page
        self.pageSize = pageSize
    }


}