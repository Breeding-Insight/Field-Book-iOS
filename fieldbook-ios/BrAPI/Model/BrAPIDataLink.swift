//
// DataLink.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct BrAPIDataLink: Codable {

    /** The structure of the data within a file. For example - VCF, table, image archive, multispectral image archives in EDAM ontology (used in Galaxy)  MIAPPE V1.1 (DM-38) Data file description - Description of the format of the data file. May be a standard file format name, or a description of organization of the data in a tabular file. */
    public var dataFormat: String?
    /** The general description of this data link  MIAPPE V1.1 (DM-38) Data file description - Description of the format of the data file. May be a standard file format name, or a description of organization of the data in a tabular file. */
    public var _description: String?
    /** The MIME type of the file (ie text/csv, application/excel, application/zip).  MIAPPE V1.1 (DM-38) Data file description - Description of the format of the data file. May be a standard file format name, or a description of organization of the data in a tabular file. */
    public var fileFormat: String?
    /** The name of the external data link  MIAPPE V1.1 (DM-38) Data file description - Description of the format of the data file. May be a standard file format name, or a description of organization of the data in a tabular file. */
    public var name: String?
    /** The description of the origin or ownership of this linked data. Could be a formal reference to software, method, or workflow. */
    public var provenance: String?
    /** The general type of data. For example- Genotyping, Phenotyping raw data, Phenotyping reduced data, Environmental, etc */
    public var scientificType: String?
    /** URL describing the location of this data file to view or download  MIAPPE V1.1 (DM-37) Data file link - Link to the data file (or digital object) in a public database or in a persistent institutional repository; or identifier of the data file when submitted together with the MIAPPE submission. */
    public var url: String?
    /** The version number for this data   MIAPPE V1.1 (DM-39) Data file version - The version of the dataset (the actual data). */
    public var version: String?

    public init(dataFormat: String? = nil, _description: String? = nil, fileFormat: String? = nil, name: String? = nil, provenance: String? = nil, scientificType: String? = nil, url: String? = nil, version: String? = nil) {
        self.dataFormat = dataFormat
        self._description = _description
        self.fileFormat = fileFormat
        self.name = name
        self.provenance = provenance
        self.scientificType = scientificType
        self.url = url
        self.version = version
    }

    public enum CodingKeys: String, CodingKey { 
        case dataFormat
        case _description = "description"
        case fileFormat
        case name
        case provenance
        case scientificType
        case url
        case version
    }

}
