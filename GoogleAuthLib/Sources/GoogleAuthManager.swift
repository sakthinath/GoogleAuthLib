//
//  GoogleAuthManager.swift
//  GoogleAuthLib
//
//  Created by Sathyanath Masthan on 16/04/25.
//

import Foundation
import GoogleSignIn
import UIKit

public class GoogleAuthManager {
    public weak var delegate: GoogleAuthDelegate?
    private var clientID: String
    
    public init(clientID: String) {
        self.clientID = clientID
    }
    
    // Configure Google Sign-In at app launch
    public func configure() {
        guard let clientID = Bundle.main.object(forInfoDictionaryKey: "GIDClientID") as? String else {
            delegate?.didFailWithError(.configurationError)
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    // Handle URL for Google Sign-In
    public func handle(_ url: URL) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    // Sign in with Google
    public func signIn(presentingViewController: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                if (error as NSError).code == GIDSignInError.canceled.rawValue {
                    self.delegate?.didFailWithError(.signInCancelled)
                } else {
                    self.delegate?.didFailWithError(.unknownError(error))
                }
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self.delegate?.didFailWithError(.noUserIdToken)
                return
            }
            
            let accessToken = user.accessToken.tokenString
            let profile = user.profile
            
            let googleUser = GoogleUser(
                id: user.userID ?? "",
                fullName: profile?.name ?? "",
                givenName: profile?.givenName,
                familyName: profile?.familyName,
                email: profile?.email ?? "",
                profileImageURL: profile?.imageURL(withDimension: 200)
            )
            
            self.delegate?.didSignIn(with: googleUser)
        }
    }
    
    // Sign out
    public func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
    // Disconnect (revoke access)
    public func disconnect() {
        GIDSignIn.sharedInstance.disconnect { [weak self] error in
            if let error = error {
                self?.delegate?.didFailWithError(.unknownError(error))
            } else {
                self?.delegate?.didDisconnect()
            }
        }
    }
    
    // Restore previous sign-in
    public func restorePreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.didFailWithError(.unknownError(error))
                return
            }
            
            guard let user = user,
                  let idToken = user.idToken?.tokenString else {
                return
            }
            
            let profile = user.profile
            
            let googleUser = GoogleUser(
                id: user.userID ?? "",
                fullName: profile?.name ?? "",
                givenName: profile?.givenName,
                familyName: profile?.familyName,
                email: profile?.email ?? "",
                profileImageURL: profile?.imageURL(withDimension: 200)
            )
            
            self.delegate?.didSignIn(with: googleUser)
        }
    }
}
