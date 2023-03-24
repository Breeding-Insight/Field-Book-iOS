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
    
    static func getBrAPIToken() -> String? {
        return UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_TOKEN)
    }
    
    static func getBrAPIUrl() -> String? {
        let brapiVersion = UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_VERSION) ?? "2"
        
        guard let brapiBaseUrl = UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_URL) else {
            print("brapi url not set")
            return nil
        }
        return  (brapiBaseUrl.hasSuffix("/") ? brapiBaseUrl : brapiBaseUrl + "/") + "brapi/v" + brapiVersion
    }
    
    static func getBrAPIBaseUrl() -> String? {
        return UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_URL)
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
    
    static func convertToJSONObject(_ text: String?) -> JSONObject {
        if let data = text?.data(using: .utf8) {
            do {
                let obj = try JSONSerialization.jsonObject(with: data, options: []) as? JSONObject
                if(obj != nil) {
                    return obj!
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return JSONObject(value: [:])
    }
}

struct DateUtils {

    /*
     * Return a date for display
     */
    static func dateToUtcDisplayString(date: Date) -> String {

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "MMM dd yyyy HH:mm:ss"
        return formatter.string(from: date)
    }

    /*
     * Receive a timestamp from the API
     */
    static func apiErrorTimestampToDate(isoTimestamp: String) -> Date? {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.date(from: isoTimestamp)
    }
}
