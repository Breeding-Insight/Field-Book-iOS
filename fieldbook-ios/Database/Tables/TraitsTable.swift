//
//  TraitsTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct TraitsTable {
    public static let TABLE = Table("traits")
    
    public static let ID = Expression<Int>("id")
    public static let EXTERNAL_DB_ID = Expression<String>("external_db_id")
    public static let TRAIT_DATA_SOURCE = Expression<String>("trait_data_source")
    public static let TRAIT = Expression<String>("trait")
    public static let FORMAT = Expression<String>("format")
    public static let DEFAULTVALUE = Expression<String>("defaultValue")
    public static let MINIMUM = Expression<String>("minimum")
    public static let MAXIMUM = Expression<String>("maximum")
    public static let DETAILS = Expression<String>("details")
    public static let CATEGORIES = Expression<String>("categories")
    public static let ISVISIBLE = Expression<String>("isVisible")
    public static let REALPOSITION = Expression<Int>("realPosition")
}
