//
//  ObservationsTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct ObservationsTable {
    public static let TABLE = Table("observations")
    
    public static let INTERNAL_ID_OBSERVATION = Expression<Int>("internal_id_observation")
    public static let OBSERVATION_UNIT_ID = Expression<String>("observation_unit_id")
    public static let STUDY_ID = Expression<Int>("study_id")
    public static let OBSERVATION_VARIABLE_DB_ID = Expression<String>("observation_variable_db_id")
    public static let OBSERVATION_VARIABLE_NAME = Expression<String>("observation_variable_name")
    public static let OBSERVATION_VARIABLE_FIELD_BOOK_FORMAT = Expression<String>("observation_variable_field_book_format")
    public static let VALUE = Expression<String>("value")
    public static let OBSERVATION_TIME_STAMP = Expression<String>("observation_time_stamp")
    public static let COLLECTOR = Expression<String>("collector")
    public static let GEOCOORDINATES = Expression<String>("geoCoordinates")
    public static let OBSERVATION_DB_ID = Expression<String>("observation_db_id")
    public static let LAST_SYNCED_TIME = Expression<String>("last_synced_time")
    public static let ADDITIONAL_INFO = Expression<String>("additional_info")
    public static let REP = Expression<String>("rep")
    public static let NOTES = Expression<String>("notes")
}
