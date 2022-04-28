//
//  ObservationVariableAttributesTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct ObservationVariableAttributesTable {
    public static let TABLE = Table("observation_variable_attributes")
    
    public static let INTERNAL_ID_OBSERVATION_VARIABLE_ATTRIBUTE = Expression<Int64>("internal_id_observation_variable_attribute")
    public static let OBSERVATION_VARIABLE_ATTRIBUTE_NAME = Expression<String>("observation_variable_attribute_name")
}
