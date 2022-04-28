//
//  ObservationUnitsTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct ObservationUnitsTable {
    public static let TABLE = Table("observation_units")
    
    public static let INTERNAL_ID_OBSERVATION_UNIT = Expression<Int64?>("internal_id_observation_unit")
    public static let STUDY_ID = Expression<Int64?>("study_id")
    public static let OBSERVATION_UNIT_DB_ID = Expression<String?>("observation_unit_db_id")
    public static let PRIMARY_ID = Expression<String?>("primary_id")
    public static let SECONDARY_ID = Expression<String?>("secondary_id")
    public static let GEO_COORDINATES = Expression<String?>("geo_coordinates")
    public static let ADDITIONAL_INFO = Expression<String?>("additional_info")
    public static let GERMPLASM_DB_ID = Expression<String?>("germplasm_db_id")
    public static let GERMPLASM_NAME = Expression<String?>("germplasm_name")
    public static let OBSERVATION_LEVEL = Expression<String?>("observation_level")
    public static let POSITION_COORDINATE_X = Expression<String?>("position_coordinate_x")
    public static let POSITION_COORDINATE_X_TYPE = Expression<String?>("position_coordinate_x_type")
    public static let POSITION_COORDINATE_Y = Expression<String?>("position_coordinate_y")
    public static let POSITION_COORDINATE_Y_TYPE = Expression<String?>("position_coordinate_y_type")
}
