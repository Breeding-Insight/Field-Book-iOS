//
//  PlotValuesTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct PlotValuesTable {
    public static let TABLE = Table("plot_values")
    
    public static let ATTRIBUTE_VALUE_ID = Expression<Int>("attribute_value_id")
    public static let ATTRIBUTE_ID = Expression<Int>("attribute_id")
    public static let ATTRIBUTE_VALUE = Expression<String>("attribute_value")
    public static let PLOT_ID = Expression<Int>("plot_id")
    public static let EXP_ID = Expression<Int>("exp_id")
}
