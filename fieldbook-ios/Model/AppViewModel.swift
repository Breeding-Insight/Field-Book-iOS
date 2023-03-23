//
//  AppViewModel.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 3/21/23.
//

import Foundation
import SwiftUI

/*
 * A primitive view model class to manage global objects and state
 */
class AppViewModel: ObservableObject {

    // Global objects supplied during construction
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

    /*
     * The logout entry point
     */
//    func logout(viewController: UIViewController) async throws {
//
//        // Make sure metadata is loaded
//        try await self.authenticator.getMetadata()
//
//        // Do the logout redirect on the main thread
//        try await MainActor.run {
//            try self.authenticator.startLogoutRedirect(viewController: viewController)
//        }
//
//        // Handle the logout response on a background thread
//        _ = try await self.authenticator.handleLogoutResponse()
//    }

    /*
     * Make the refresh token act expired
     */
//    func onExpireRefreshToken() {
//        self.authenticator.expireRefreshToken()
//    }
}

