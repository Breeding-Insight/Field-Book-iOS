//
//  ObservationVariablesTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct ObservationVariablesTable {
    
    public static let TABLE = Table("observation_variables")
    
    public static let INTERNAL_ID_OBSERVATION_VARIABLE = Expression<Int64?>("internal_id_observation_variable")
    public static let OBSERVATION_VARIABLE_NAME = Expression<String>("observation_variable_name")
    public static let OBSERVATION_VARIABLE_FIELD_BOOK_FORMAT = Expression<String?>("observation_variable_field_book_format")
    public static let DEFAULT_VALUE = Expression<String?>("default_value")
    public static let VISIBLE = Expression<Bool>("visible")
    public static let POSITION = Expression<Int64?>("position")
    public static let EXTERNAL_DB_ID = Expression<String?>("external_db_id")
    public static let TRAIT_DATA_SOURCE = Expression<String?>("trait_data_source")
    public static let ADDITIONAL_INFO = Expression<String?>("additional_info")
    public static let COMMON_CROP_NAME = Expression<String?>("common_crop_name")
    public static let LANGUAGE = Expression<String?>("language")
    public static let DATA_TYPE = Expression<String>("data_type")
    public static let OBSERVATION_VARIABLE_DB_ID = Expression<String?>("observation_variable_db_id")
    public static let ONTOLOGY_DB_ID = Expression<String?>("ontology_db_id")
    public static let ONTOLOGY_NAME = Expression<String?>("ontology_name")
    public static let OBSERVATION_VARIABLE_DETAILS = Expression<String?>("observation_variable_details")
}
