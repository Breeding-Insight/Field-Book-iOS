//
// ServerInfo.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct BrAPIServerInfo: Codable {

    /** Array of available calls on this server */
    public var calls: [BrAPIService]
    /** A contact email address for this server management */
    public var contactEmail: String?
    /** A URL to the human readable documentation of this object */
    public var documentationURL: String?
    /** Physical location of this server (ie. City, Country) */
    public var location: String?
    /** The name of the organization that manages this server and data */
    public var organizationName: String?
    /** The URL of the organization that manages this server and data */
    public var organizationURL: String?
    /** A description of this server */
    public var serverDescription: String?
    /** The name of this server */
    public var serverName: String?

    public init(calls: [BrAPIService], contactEmail: String? = nil, documentationURL: String? = nil, location: String? = nil, organizationName: String? = nil, organizationURL: String? = nil, serverDescription: String? = nil, serverName: String? = nil) {
        self.calls = calls
        self.contactEmail = contactEmail
        self.documentationURL = documentationURL
        self.location = location
        self.organizationName = organizationName
        self.organizationURL = organizationURL
        self.serverDescription = serverDescription
        self.serverName = serverName
    }


}