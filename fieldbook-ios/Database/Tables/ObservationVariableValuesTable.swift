//
//  ObservationVariableValuesTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct ObservationVariableValuesTable {
    public static let TABLE = Table("observation_variable_values")
    
    public static let INTERNAL_ID_OBSERVATION_VARIABLE_VALUE = Expression<Int64>("internal_id_observation_variable_value")
    public static let OBSERVATION_VARIABLE_ATTRIBUTE_DB_ID = Expression<Int64>("observation_variable_attribute_db_id")
    public static let OBSERVATION_VARIABLE_ATTRIBUTE_VALUE = Expression<String>("observation_variable_attribute_value")
    public static let OBSERVATION_VARIABLE_DB_ID = Expression<Int64>("observation_variable_db_id")
}
