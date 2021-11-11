//
// PersonSearchRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct PersonSearchRequest: Codable {

    /** email address for this person */
    public var emailAddresses: [String]?
    /** List of external reference IDs. Could be a simple strings or a URIs. (use with &#x60;externalReferenceSources&#x60; parameter) */
    public var externalReferenceIDs: [String]?
    /** List of identifiers for the source system or database of an external reference (use with &#x60;externalReferenceIDs&#x60; parameter) */
    public var externalReferenceSources: [String]?
    /** Persons first name */
    public var firstNames: [String]?
    /** Persons last name */
    public var lastNames: [String]?
    /** physical address of this person */
    public var mailingAddresses: [String]?
    /** Persons middle name */
    public var middleNames: [String]?
    /** Which result page is requested. The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. */
    public var page: Int?
    /** The size of the pages to be returned. Default is &#x60;1000&#x60;. */
    public var pageSize: Int?
    /** Unique ID for this person */
    public var personDbIds: [String]?
    /** phone number of this person */
    public var phoneNumbers: [String]?
    /** A systems user ID associated with this person. Different from personDbId because you could have a person who is not a user of the system. */
    public var userIDs: [String]?

    public init(emailAddresses: [String]? = nil, externalReferenceIDs: [String]? = nil, externalReferenceSources: [String]? = nil, firstNames: [String]? = nil, lastNames: [String]? = nil, mailingAddresses: [String]? = nil, middleNames: [String]? = nil, page: Int? = nil, pageSize: Int? = nil, personDbIds: [String]? = nil, phoneNumbers: [String]? = nil, userIDs: [String]? = nil) {
        self.emailAddresses = emailAddresses
        self.externalReferenceIDs = externalReferenceIDs
        self.externalReferenceSources = externalReferenceSources
        self.firstNames = firstNames
        self.lastNames = lastNames
        self.mailingAddresses = mailingAddresses
        self.middleNames = middleNames
        self.page = page
        self.pageSize = pageSize
        self.personDbIds = personDbIds
        self.phoneNumbers = phoneNumbers
        self.userIDs = userIDs
    }


}