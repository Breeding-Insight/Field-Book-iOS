//
// SearchRequestParametersPaging.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct SearchRequestParametersPaging: Codable {

    /** Which result page is requested. The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. */
    public var page: Int?
    /** The size of the pages to be returned. Default is &#x60;1000&#x60;. */
    public var pageSize: Int?

    public init(page: Int? = nil, pageSize: Int? = nil) {
        self.page = page
        self.pageSize = pageSize
    }


}
