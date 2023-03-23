//
//  BrAPIAuthService.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 3/20/23.
//

import Foundation
import os
import AppAuth

class BrAPIAuthService {
    private let logger = Logger(subsystem: "org.phenoapps.fieldbook", category: "BrAPIAuthService")
    private var metadata: OIDServiceConfiguration?
    private var currentOAuthSession: OIDExternalUserAgentSession?
    private let loginResponseHandler: LoginResponseHandler = LoginResponseHandler()
    
    func getMetadata() async throws {

        // Do nothing if already loaded
        if self.metadata != nil {
            return
        }

        guard let brapiURL = SettingsUtilities.getBrAPIBaseUrl() else {
            print("BrAPI URL is not set")
            return
        }
        
        let discoveryURL = URL(string: brapiURL + "/.well-known/openid-configuration")!
        //todo check the oidc url defined by the user in case it differs

        return try await withCheckedThrowingContinuation { continuation in

            // Try to download metadata
            OIDAuthorizationService.discoverConfiguration(forDiscoveryURL: discoveryURL) { metadata, error in

                self.metadata = metadata
                if error != nil {
                    continuation.resume(throwing: error!)
                } else {   
                    continuation.resume()
                }
            }
        }
    }
    
    /*
     * The OAuth entry point for login processing runs on the UI thread
     */
    func startLoginRedirect(viewController: UIViewController) throws {
        let redirectURL = URL(string: "fieldbook://")!

        // Build the authorization request
        let request = OIDAuthorizationRequest(configuration: self.metadata!,
                                              clientId: "fieldbook",
                                              clientSecret: nil,
                                              scopes: nil,
                                              redirectURL: redirectURL,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: nil)

        // Do the redirect
        self.currentOAuthSession = OIDAuthorizationService.present(
            request,
            presenting: viewController,
            callback: self.loginResponseHandler.callback)
    }
    
    func handleLoginResponse() async throws -> OIDAuthorizationResponse {
        do {
            return try await self.loginResponseHandler.waitForCallback()
        } catch {
            let err = error as NSError
            if (err.userInfo["status"] as? String) == "200" && err.userInfo["access_token"] != nil {
                logger.warning("OAuth error, but assuming that's due to bad state")
                //XXXXXXXXXXX FIX THIS XXXXXXXXXXXXXXX
                // TEMPORARY WORKAROUND - the AppAuth library intercepts the return back from the browser before our code can
                //only an error because of the lack of the nonce from the server
                let redirectURL = URL(string: "fieldbook://")!
                let request = OIDAuthorizationRequest(configuration: self.metadata!,
                                                      clientId: "fieldbook",
                                                      clientSecret: nil,
                                                      scopes: nil,
                                                      redirectURL: redirectURL,
                                                      responseType: OIDResponseTypeCode,
                                                      additionalParameters: nil)
                
                return OIDAuthorizationResponse(request: request, parameters: ["access_token":err.userInfo["access_token"]! as! NSString])
            } else {
                self.currentOAuthSession = nil
                
                if self.isCancelledError(error: error) {
                    throw ErrorFactory.fromRedirectCancelled()
                }
                
                throw ErrorFactory.fromLoginResponseError(error: error)
            }
        }
    }
    
    func finishLogin(authResponse: OIDAuthorizationResponse) async throws {

        self.currentOAuthSession = nil
        if let accessToken = authResponse.accessToken {
            logger.debug("Successfully authorized.  Access token received")
            UserDefaults.standard.set(accessToken, forKey: PreferenceConstants.BRAPI_TOKEN)
        } else {
            UserDefaults.standard.set(nil, forKey: PreferenceConstants.BRAPI_TOKEN)
        }
    }
    
    func expireAccessToken() {
        UserDefaults.standard.set(nil, forKey: PreferenceConstants.BRAPI_TOKEN)
    }
    
    private func getHostingViewController() -> UIViewController {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene!.keyWindow!.rootViewController!
    }
    
    private func isCancelledError(error: Error) -> Bool {

        let authError = error as NSError
        return self.matchesAppAuthError(
            error: error,
            domain: OIDGeneralErrorDomain,
            code: OIDErrorCode.userCanceledAuthorizationFlow.rawValue) &&
            !authError.userInfo.description.localizedStandardContains("active state")
    }
    
    private func matchesAppAuthError(error: Error, domain: String, code: Int) -> Bool {
        let authError = error as NSError
        return authError.domain == domain && authError.code == code
    }
}
