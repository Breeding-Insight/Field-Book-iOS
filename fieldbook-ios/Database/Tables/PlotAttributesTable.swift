//
//  PlotAttributesTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct PlotAttributesTable {
    public static let TABLE = Table("plot_attributes")
    
    public static let ATTRIBUTE_ID = Expression<Int>("attribute_id")
    public static let ATTRIBUTE_NAME = Expression<String>("attribute_name")
    public static let EXP_ID = Expression<Int>("exp_id")
}
