//
//  AppState.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/28/22.
//

import Foundation

class AppState: ObservableObject, Equatable {
    @Published var currentStudyId: Int64? = nil
    
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.currentStudyId == rhs.currentStudyId
    }
}
