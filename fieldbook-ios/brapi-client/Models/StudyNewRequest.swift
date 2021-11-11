//
// StudyNewRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct StudyNewRequest: Codable {

    /** Is this study currently active */
    public var active: Bool?
    /** Additional arbitrary info */
    public var additionalInfo: [String:String]?
    /** Common name for the crop associated with this study */
    public var commonCropName: String?
    /** List of contact entities associated with this study */
    public var contacts: [StudyContacts]?
    /** MIAPPE V1.1 (DM-28) Cultural practices - General description of the cultural practices of the study. */
    public var culturalPractices: String?
    /** List of links to extra data files associated with this study. Extra data could include notes, images, and reference data. */
    public var dataLinks: [StudyDataLinks]?
    /** A URL to the human readable documentation of this object */
    public var documentationURL: String?
    /** The date the study ends  MIAPPE V1.1 (DM-15) End date of study - Date and, if relevant, time when the experiment ended */
    public var endDate: Date?
    /** Environmental parameters that were kept constant throughout the study and did not change between observation units.  MIAPPE V1.1 (DM-57) Environment - Environmental parameters that were kept constant throughout the study and did not change between observation units or assays. Environment characteristics that vary over time, i.e. environmental variables, should be recorded as Observed Variables (see below). */
    public var environmentParameters: [StudyEnvironmentParameters]?
    public var experimentalDesign: StudyExperimentalDesign?
    /** An array of external reference ids. These are references to this piece of data in an external system. Could be a simple string or a URI. */
    public var externalReferences: [ExternalReferencesInner]?
    public var growthFacility: StudyGrowthFacility?
    public var lastUpdate: StudyLastUpdate?
    /** The usage license associated with the study data */
    public var license: String?
    /** The unique identifier for a Location */
    public var locationDbId: String?
    /** A human readable name for this location  MIAPPE V1.1 (DM-18) Experimental site name - The name of the natural site, experimental field, greenhouse, phenotyping facility, etc. where the experiment took place. */
    public var locationName: String?
    /** Observation levels indicate the granularity level at which the measurements are taken. &#x60;levelName&#x60; defines the level, &#x60;levelOrder&#x60; defines where that level exists in the hierarchy of levels. &#x60;levelOrder&#x60;s lower numbers are at the top of the hierarchy (ie field &gt; 0) and higher numbers are at the bottom of the hierarchy (ie plant &gt; 6).  */
    public var observationLevels: [ObservationUnitHierarchyLevel1]?
    /** MIAPPE V1.1 (DM-25) Observation unit description - General description of the observation units in the study. */
    public var observationUnitsDescription: String?
    /** List of seasons over which this study was performed. */
    public var seasons: [String]?
    /** The date this study started  MIAPPE V1.1 (DM-14) Start date of study - Date and, if relevant, time when the experiment started */
    public var startDate: Date?
    /** A short human readable code for a study */
    public var studyCode: String?
    /** The description of this study  MIAPPE V1.1 (DM-13) Study description - Human-readable text describing the study */
    public var studyDescription: String?
    /** The human readable name for a study  MIAPPE V1.1 (DM-12) Study title - Human-readable text summarising the study */
    public var studyName: String?
    /** A permanent unique identifier associated with this study data. For example, a URI or DOI */
    public var studyPUI: String?
    /** The type of study being performed. ex. \&quot;Yield Trial\&quot;, etc */
    public var studyType: String?
    /** The ID which uniquely identifies a trial */
    public var trialDbId: String?
    /** The human readable name of a trial */
    public var trialName: String?

    public init(active: Bool? = nil, additionalInfo: [String:String]? = nil, commonCropName: String? = nil, contacts: [StudyContacts]? = nil, culturalPractices: String? = nil, dataLinks: [StudyDataLinks]? = nil, documentationURL: String? = nil, endDate: Date? = nil, environmentParameters: [StudyEnvironmentParameters]? = nil, experimentalDesign: StudyExperimentalDesign? = nil, externalReferences: [ExternalReferencesInner]? = nil, growthFacility: StudyGrowthFacility? = nil, lastUpdate: StudyLastUpdate? = nil, license: String? = nil, locationDbId: String? = nil, locationName: String? = nil, observationLevels: [ObservationUnitHierarchyLevel1]? = nil, observationUnitsDescription: String? = nil, seasons: [String]? = nil, startDate: Date? = nil, studyCode: String? = nil, studyDescription: String? = nil, studyName: String? = nil, studyPUI: String? = nil, studyType: String? = nil, trialDbId: String? = nil, trialName: String? = nil) {
        self.active = active
        self.additionalInfo = additionalInfo
        self.commonCropName = commonCropName
        self.contacts = contacts
        self.culturalPractices = culturalPractices
        self.dataLinks = dataLinks
        self.documentationURL = documentationURL
        self.endDate = endDate
        self.environmentParameters = environmentParameters
        self.experimentalDesign = experimentalDesign
        self.externalReferences = externalReferences
        self.growthFacility = growthFacility
        self.lastUpdate = lastUpdate
        self.license = license
        self.locationDbId = locationDbId
        self.locationName = locationName
        self.observationLevels = observationLevels
        self.observationUnitsDescription = observationUnitsDescription
        self.seasons = seasons
        self.startDate = startDate
        self.studyCode = studyCode
        self.studyDescription = studyDescription
        self.studyName = studyName
        self.studyPUI = studyPUI
        self.studyType = studyType
        self.trialDbId = trialDbId
        self.trialName = trialName
    }


}
