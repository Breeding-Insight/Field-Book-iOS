//
//  RangeTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct RangeTable {
    public static let TABLE = Table("range")
    
    public static let ID = Expression<Int>("id")
    public static let RANGE = Expression<String>("range")
    public static let PLOT = Expression<String>("plot")
    public static let ENTRY = Expression<String>("entry")
    public static let PLOT_ID = Expression<String>("plot_id")
    public static let PEDIGREE = Expression<String>("pedigree")
}
