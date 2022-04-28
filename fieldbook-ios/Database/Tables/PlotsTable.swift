//
//  PlotsTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct PlotsTable {
    public static let TABLE = Table("plots")
    
    public static let PLOT_ID = Expression<Int>("plot_id")
    public static let EXP_ID = Expression<Int>("exp_id")
    public static let UNIQUE_ID = Expression<String>("unique_id")
    public static let PRIMARY_ID = Expression<String>("primary_id")
    public static let SECONDARY_ID = Expression<String>("secondary_id")
    public static let COORDINATES = Expression<String>("coordinates")
}
