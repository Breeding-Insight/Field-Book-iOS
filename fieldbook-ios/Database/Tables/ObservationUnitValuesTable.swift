//
//  ObservationUnitValuesTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct ObservationUnitValuesTable {
    public static let TABLE = Table("observation_units_values")
    
    public static let INTERNAL_ID_OBSERVATION_UNIT_VALUE = Expression<Int64>("internal_id_observation_unit_value")
    public static let OBSERVATION_UNIT_ATTRIBUTE_DB_ID = Expression<Int64>("observation_unit_attribute_db_id")
    public static let OBSERVATION_UNIT_VALUE_NAME = Expression<String>("observation_unit_value_name")
    public static let OBSERVATION_UNIT_ID = Expression<Int64>("observation_unit_id")
    public static let STUDY_ID = Expression<Int64>("study_id")
}
