//
// Scale.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Scale metadata */

public struct Scale: Codable {

    public enum DataType: String, Codable { 
        case code = "Code"
        case date = "Date"
        case duration = "Duration"
        case nominal = "Nominal"
        case numerical = "Numerical"
        case ordinal = "Ordinal"
        case text = "Text"
    }
    /** Additional arbitrary info */
    public var additionalInfo: [String:String]?
    /** &lt;p&gt;Class of the scale, entries can be&lt;/p&gt; &lt;p&gt;\&quot;Code\&quot; -  This scale class is exceptionally used to express complex traits. Code is a nominal scale that combines the expressions of the different traits composing the complex trait. For example a severity trait might be expressed by a 2 digit and 2 character code. The first 2 digits are the percentage of the plant covered by a fungus and the 2 characters refer to the delay in development, e.g. \&quot;75VD\&quot; means \&quot;75 %\&quot; of the plant is infected and the plant is very delayed.&lt;/p&gt; &lt;p&gt;\&quot;Date\&quot; - The date class is for events expressed in a time format, See ISO 8601&lt;/p&gt; &lt;p&gt;\&quot;Duration\&quot; - The Duration class is for time elapsed between two events expressed in a time format, e.g. days, hours, months&lt;/p&gt; &lt;p&gt;\&quot;Nominal\&quot; - Categorical scale that can take one of a limited and fixed number of categories. There is no intrinsic ordering to the categories&lt;/p&gt; &lt;p&gt;\&quot;Numerical\&quot; - Numerical scales express the trait with real numbers. The numerical scale defines the unit e.g. centimeter, ton per hectare, branches&lt;/p&gt; &lt;p&gt;\&quot;Ordinal\&quot; - Ordinal scales are scales composed of ordered categories&lt;/p&gt; &lt;p&gt;\&quot;Text\&quot; - A free text is used to express the trait.&lt;/p&gt; */
    public var dataType: DataType?
    /** For numerical, number of decimal places to be reported */
    public var decimalPlaces: Int?
    /** An array of external reference ids. These are references to this piece of data in an external system. Could be a simple string or a URI. */
    public var externalReferences: [ExternalReferencesInner]?
    public var ontologyReference: MethodOntologyReference?
    /** Unique identifier of the scale. If left blank, the upload system will automatically generate a scale ID. */
    public var scaleDbId: String?
    /** Name of the scale  MIAPPE V1.1 (DM-92) Scale Name of the scale associated with the variable */
    public var scaleName: String?
    public var validValues: ObservationVariableScaleValidValues?

    public init(additionalInfo: [String:String]? = nil, dataType: DataType? = nil, decimalPlaces: Int? = nil, externalReferences: [ExternalReferencesInner]? = nil, ontologyReference: MethodOntologyReference? = nil, scaleDbId: String? = nil, scaleName: String? = nil, validValues: ObservationVariableScaleValidValues? = nil) {
        self.additionalInfo = additionalInfo
        self.dataType = dataType
        self.decimalPlaces = decimalPlaces
        self.externalReferences = externalReferences
        self.ontologyReference = ontologyReference
        self.scaleDbId = scaleDbId
        self.scaleName = scaleName
        self.validValues = validValues
    }


}
