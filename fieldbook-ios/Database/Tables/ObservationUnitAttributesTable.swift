//
//  ObservationUnitAttributesTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct ObservationUnitAttributesTable {
    public static let TABLE = Table("observation_units_attributes")
    
    public static let INTERNAL_ID_OBSERVATION_UNIT_ATTRIBUTE = Expression<Int64>("internal_id_observation_unit_attribute")
    public static let OBSERVATION_UNIT_ATTRIBUTE_NAME = Expression<String>("observation_unit_attribute_name")
    public static let STUDY_ID = Expression<Int64>("study_id")
}
