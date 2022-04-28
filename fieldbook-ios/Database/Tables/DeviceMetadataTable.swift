//
//  DeviceMetadataTable.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

struct DeviceMetadataTable {
    public static let TABLE = Table("device_metadata")
    
    public static let LOCALE = Expression<String>("locale")
}
