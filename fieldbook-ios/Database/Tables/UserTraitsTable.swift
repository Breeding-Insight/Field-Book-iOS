//
//  UserTraitsTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct UserTraitsTable {
    public static let TABLE = Table("user_traits")
    
    public static let ID = Expression<Int>("id")
    public static let RID = Expression<String>("rid")
    public static let PARENT = Expression<String>("parent")
    public static let TRAIT = Expression<String>("trait")
    public static let USERVALUE = Expression<String>("userValue")
    public static let TIMETAKEN = Expression<String>("timeTaken")
    public static let PERSON = Expression<String>("person")
    public static let LOCATION = Expression<String>("location")
    public static let REP = Expression<String>("rep")
    public static let NOTES = Expression<String>("notes")
    public static let EXP_ID = Expression<String>("exp_id")
    public static let OBSERVATION_DB_ID = Expression<String>("observation_db_id")
    public static let LAST_SYNCED_TIME = Expression<String>("last_synced_time")
}
