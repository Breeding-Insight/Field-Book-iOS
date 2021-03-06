//
// Metadata.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct BrAPIMetadata: Codable {

    /** The datafiles contains a list of file URLs and metadata.  These files contain additional information related to the returned object and can be retrieved by a subsequent call.  This could be a supplementary data file, an informational file, the uploaded file where the data originated from, a generated file representing the whole dataset in a particular format, or any other related file.  */
    public var datafiles: [BrAPIMetadataDatafiles]?
    public var pagination: BrAPIMetadataPagination?
    /** The status field contains a list of informational status messages from the server.  If no status is reported, an empty list should be returned. See Error Reporting for more information. */
    public var status: [BrAPIMetadataStatus]?

    public init(datafiles: [BrAPIMetadataDatafiles]? = nil, pagination: BrAPIMetadataPagination? = nil, status: [BrAPIMetadataStatus]? = nil) {
        self.datafiles = datafiles
        self.pagination = pagination
        self.status = status
    }


}
