//
//  AppState.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/28/22.
//

import Foundation
import AppAuth

class AppState: ObservableObject, Equatable {
    @Published var currentStudyId: Int64? = nil
    @Published var authState: OIDAuthState?
    private let brapiAuthService: BrAPIAuthService

    /*
     * Receive globals created by the app class
     */
    init(brapiAuthService: BrAPIAuthService) {

        // Store input
        self.brapiAuthService = brapiAuthService
    }

    /*
     * Do the login redirect
     */
    func login(viewController: UIViewController) async throws {

        // Make sure metadata is loaded
        try await self.brapiAuthService.getMetadata()

        // Do the login redirect on the main thread
        try await MainActor.run {
            try self.brapiAuthService.startLoginRedirect(viewController: viewController)
        }

        // Handle the login response on a background thread
        let response = try await self.brapiAuthService.handleLoginResponse()

        // Swap the code for tokens on a background thread
        try await self.brapiAuthService.finishLogin(authResponse: response)
    }
    
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.currentStudyId == rhs.currentStudyId && lhs.authState == rhs.authState
    }
}
