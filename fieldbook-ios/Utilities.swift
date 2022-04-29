//
//  PreferencesUtilities.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/27/22.
//

import Foundation

struct SettingsUtilities {
    static func getBrAPIPageSize() -> Int {
        return Int(UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_PAGE_SIZE) ?? "1000")!
    }
    
    static func getBrAPIToken() -> String {
        return UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_TOKEN) ?? "abc123"
    }
    
    static func getBrAPIUrl() -> String {
        return UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_URL) ?? "https://test-server.brapi.org/brapi/v2"
//        return "https://test-server.brapi.org/brapi/v2"
    }
    
    static func getCurrentStudyId() -> Int64? {
        if let strVal = UserDefaults.standard.string(forKey:AppConstants.SELECTED_STUDY_ID) {
            return Int64(strVal)
        } else {
            return nil
        }
    }
    
    static func setCurrentStudyId(_ studyId: Int64?) {
        UserDefaults.standard.set(studyId, forKey: AppConstants.SELECTED_STUDY_ID)
    }
}

struct Utilities {
    static func getFirstNonNil(_ strings:[String?]) -> String? {
        for str in strings {
            if(str != nil) {
                return str
            }
        }
        
        return nil;
    }
    
    static func convertToDictionary(_ text: String?) -> [String: String] {
        if let data = text?.data(using: .utf8) {
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                if(dict != nil) {
                    return dict!
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return [:]
    }
}
