//
// Location.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct BrAPILocation: Codable {

    /** An abbreviation which represents this location */
    public var abbreviation: String?
    /** Additional arbitrary info */
    public var additionalInfo: [String:String]?
    /** Describes the precision and landmarks of the coordinate values used for this location. (ex. the site, the nearest town, a 10 kilometers radius circle, +/- 20 meters, etc) */
    public var coordinateDescription: String?
    /** Uncertainty associated with the coordinates in meters. Leave the value empty if the uncertainty is unknown. */
    public var coordinateUncertainty: String?
    public var coordinates: BrAPIGeoJSON?
    /**  [ISO_3166-1_alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) spec MIAPPE V1.1 (DM-17) Geographic location (country) - The country where the experiment took place, either as a full name or preferably as a 2-letter code. */
    public var countryCode: String?
    /** The full name of the country where this location is  MIAPPE V1.1 (DM-17) Geographic location (country) - The country where the experiment took place, either as a full name or preferably as a 2-letter code. */
    public var countryName: String?
    /** A URL to the human readable documentation of this object */
    public var documentationURL: String?
    /** Describes the general type of environment of the location. (ex. forest, field, nursery, etc) */
    public var environmentType: String?
    /** Describes the level of protection/exposure for things like sun light and wind. */
    public var exposure: String?
    /** An array of external reference ids. These are references to this piece of data in an external system. Could be a simple string or a URI. */
    public var externalReferences: [BrAPIExternalReferencesInner]?
    /** The street address of the institute representing this location  MIAPPE V1.1 (DM-16) Contact institution - Name and address of the institution responsible for the study. */
    public var instituteAddress: String?
    /** Each institute/laboratory can have several experimental field  MIAPPE V1.1 (DM-16) Contact institution - Name and address of the institution responsible for the study. */
    public var instituteName: String?
    /** The unique identifier for a Location */
    public var locationDbId: String?
    /** A human readable name for this location  MIAPPE V1.1 (DM-18) Experimental site name - The name of the natural site, experimental field, greenhouse, phenotyping facility, etc. where the experiment took place. */
    public var locationName: String?
    /** The type of location this represents (ex. Breeding Location, Storage Location, etc) */
    public var locationType: String?
    /** Description of the accessibility of the location (ex. Public, Private) */
    public var siteStatus: String?
    /** Describes the approximate slope (height/distance) of the location. */
    public var slope: String?
    /** Describes the topography of the land at the location. (ex. Plateau, Cirque, Hill, Valley, etc) */
    public var topography: String?

    public init(abbreviation: String? = nil, additionalInfo: [String:String]? = nil, coordinateDescription: String? = nil, coordinateUncertainty: String? = nil, coordinates: BrAPIGeoJSON? = nil, countryCode: String? = nil, countryName: String? = nil, documentationURL: String? = nil, environmentType: String? = nil, exposure: String? = nil, externalReferences: [BrAPIExternalReferencesInner]? = nil, instituteAddress: String? = nil, instituteName: String? = nil, locationDbId: String? = nil, locationName: String? = nil, locationType: String? = nil, siteStatus: String? = nil, slope: String? = nil, topography: String? = nil) {
        self.abbreviation = abbreviation
        self.additionalInfo = additionalInfo
        self.coordinateDescription = coordinateDescription
        self.coordinateUncertainty = coordinateUncertainty
        self.coordinates = coordinates
        self.countryCode = countryCode
        self.countryName = countryName
        self.documentationURL = documentationURL
        self.environmentType = environmentType
        self.exposure = exposure
        self.externalReferences = externalReferences
        self.instituteAddress = instituteAddress
        self.instituteName = instituteName
        self.locationDbId = locationDbId
        self.locationName = locationName
        self.locationType = locationType
        self.siteStatus = siteStatus
        self.slope = slope
        self.topography = topography
    }


}
