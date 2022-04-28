//
//  StudiesTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct StudiesTable {
    public static let TABLE = Table("studies")
    
    public static let INTERNAL_ID_STUDY = Expression<Int64?>("internal_id_study")
    public static let STUDY_DB_ID = Expression<String?>("study_db_id")
    public static let STUDY_NAME = Expression<String>("study_name")
    public static let STUDY_ALIAS = Expression<String?>("study_alias")
    public static let STUDY_UNIQUE_ID_NAME = Expression<String?>("study_unique_id_name")
    public static let STUDY_PRIMARY_ID_NAME = Expression<String?>("study_primary_id_name")
    public static let STUDY_SECONDARY_ID_NAME = Expression<String?>("study_secondary_id_name")
    public static let EXPERIMENTAL_DESIGN = Expression<String?>("experimental_design")
    public static let COMMON_CROP_NAME = Expression<String?>("common_crop_name")
    public static let STUDY_SORT_NAME = Expression<String?>("study_sort_name")
    public static let DATE_IMPORT = Expression<Date?>("date_import")
    public static let DATE_EDIT = Expression<Date?>("date_edit")
    public static let DATE_EXPORT = Expression<Date?>("date_export")
    public static let STUDY_SOURCE = Expression<String?>("study_source")
    public static let ADDITIONAL_INFO = Expression<String?>("additional_info")
    public static let LOCATION_DB_ID = Expression<String?>("location_db_id")
    public static let LOCATION_NAME = Expression<String?>("location_name")
    public static let OBSERVATION_LEVELS = Expression<String?>("observation_levels")
    public static let SEASONS = Expression<String?>("seasons")
    public static let START_DATE = Expression<Date?>("start_date")
    public static let STUDY_CODE = Expression<String?>("study_code")
    public static let STUDY_DESCRIPTION = Expression<String?>("study_description")
    public static let STUDY_TYPE = Expression<String?>("study_type")
    public static let TRIAL_DB_ID = Expression<String?>("trial_db_id")
    public static let TRIAL_NAME = Expression<String?>("trial_name")
    public static let COUNT = Expression<Int64?>("count")
}
