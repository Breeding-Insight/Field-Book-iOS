//
// DataFile.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** A dataFile contains a URL and the relevant file metadata to represent a file */

public struct DataFile: Codable {

    /** A human readable description of the file contents */
    public var fileDescription: String?
    /** The MD5 Hash of the file contents to be used as a check sum */
    public var fileMD5Hash: String?
    /** The name of the file */
    public var fileName: String?
    /** The size of the file in bytes */
    public var fileSize: Int?
    /** The type or format of the file. Preferably MIME Type. */
    public var fileType: String?
    /** The absolute URL where the file is located */
    public var fileURL: String

    public init(fileDescription: String? = nil, fileMD5Hash: String? = nil, fileName: String? = nil, fileSize: Int? = nil, fileType: String? = nil, fileURL: String) {
        self.fileDescription = fileDescription
        self.fileMD5Hash = fileMD5Hash
        self.fileName = fileName
        self.fileSize = fileSize
        self.fileType = fileType
        self.fileURL = fileURL
    }


}
