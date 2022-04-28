//
//  PreferencesUtilities.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/27/22.
//

import Foundation

struct PreferencesUtilities {
    static func getBrAPIPageSize() -> Int {
        return Int(UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_PAGE_SIZE) ?? "1000")!
    }
    
    static func getBrAPIToken() -> String {
        return UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_TOKEN) ?? "abc123"
    }
}
