//
//  UserTrait.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation

class UserTrait: Codable {
    
    public var internalId: Int?
    public var rid: String?
    public var parent: String?
    public var trait: String?
    public var userValue: String?
    public var timeTaken: String?
    public var person: String?
    public var location: String?
    public var rep: String?
    public var notes: String?
    public var expId: String?
    public var observationDbId: String?
    public var lastSyncedTime: String?
}
