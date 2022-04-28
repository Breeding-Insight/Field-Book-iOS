//
//  Table.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

extension Table {
    var getName: String {
        let sql:NSString = self.asSQL() as NSString
        return sql.substring(with: NSRange (location: 15, length: sql.length-16))
    }
}

extension Expression {
    var getName: String {
        let sql:NSString = self.asSQL() as NSString
        return sql.substring(with: NSRange (location: 1, length: sql.length-2))
    }
}
