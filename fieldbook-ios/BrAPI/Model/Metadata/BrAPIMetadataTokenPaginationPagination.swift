//
// MetadataTokenPaginationPagination.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** The pagination object is applicable only when the payload contains a \&quot;data\&quot; key. It describes the pagination of the data contained in the \&quot;data\&quot; array, as a way to identify which subset of data is being returned.   Tokenized pages are for large data sets which can not be efficiently broken into indexed pages. Use the nextPageToken and prevPageToken to construct an additional query and move to the next or previous page respectively.   */

public struct BrAPIMetadataTokenPaginationPagination: Codable {

    /** The string token used to query the current page of data. */
    public var currentPageToken: String?
    /** The string token used to query the next page of data. */
    public var nextPageToken: String?
    /** The number of data elements returned, aka the size of the current page. If the requested page does not have enough elements to fill a page at the requested page size, this field should indicate the actual number of elements returned. */
    public var pageSize: Int?
    /** The string token used to query the previous page of data. */
    public var prevPageToken: String?
    /** The total number of elements that are available on the server and match the requested query parameters. */
    public var totalCount: Int?
    /** The total number of pages of elements available on the server. This should be calculated with the following formula.   totalPages &#x3D; CEILING( totalCount / requested_page_size) */
    public var totalPages: Int?

    public init(currentPageToken: String? = nil, nextPageToken: String? = nil, pageSize: Int? = nil, prevPageToken: String? = nil, totalCount: Int? = nil, totalPages: Int? = nil) {
        self.currentPageToken = currentPageToken
        self.nextPageToken = nextPageToken
        self.pageSize = pageSize
        self.prevPageToken = prevPageToken
        self.totalCount = totalCount
        self.totalPages = totalPages
    }


}
