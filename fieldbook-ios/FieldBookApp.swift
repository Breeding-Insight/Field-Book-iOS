//
//  fieldbook_iosApp.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/5/21.
//

import SwiftUI

@main
struct FieldBookApp: App {
    private let brapiAuthService: BrAPIAuthService
    private let appState: AppState
    
    init() {
        self.brapiAuthService = BrAPIAuthService()
        self.appState = AppState(brapiAuthService: brapiAuthService)
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(appState)
                
        }
    }
}
