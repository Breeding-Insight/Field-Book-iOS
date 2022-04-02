//
// MethodBaseClassOntologyReferenceDocumentationLinks.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct OntologyReferenceDocumentationLinks: Codable {

    public enum ModelType: String, Codable { 
        case obo = "OBO"
        case rdf = "RDF"
        case webpage = "WEBPAGE"
    }
    public var URL: String?
    public var type: ModelType?

    public init(URL: String? = nil, type: ModelType? = nil) {
        self.URL = URL
        self.type = type
    }


}