//
//  ExpId.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct ExpIdTable {
    public static let TABLE = Table("exp_id")
    
    public static let EXP_ID = Expression<Int>("exp_id")
    public static let EXP_NAME = Expression<String>("exp_name")
    public static let EXP_ALIAS = Expression<String>("exp_alias")
    public static let UNIQUE_ID = Expression<String>("unique_id")
    public static let PRIMARY_ID = Expression<String>("primary_id")
    public static let SECONDARY_ID = Expression<String>("secondary_id")
    public static let EXP_LAYOUT = Expression<String>("exp_layout")
    public static let EXP_SPECIES = Expression<String>("exp_species")
    public static let EXP_SORT = Expression<String>("exp_sort")
    public static let DATE_IMPORT = Expression<String>("date_import")
    public static let DATE_EDIT = Expression<String>("date_edit")
    public static let DATE_EXPORT = Expression<String>("date_export")
    public static let COUNT = Expression<Int>("count")
    public static let EXP_SOURCE = Expression<String>("exp_source")
}
