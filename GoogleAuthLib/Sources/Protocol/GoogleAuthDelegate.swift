//
//  GoogleAuthDelegate.swift
//  GoogleAuthLib
//
//  Created by Sathyanath Masthan on 16/04/25.
//

public protocol GoogleAuthDelegate: AnyObject {
    func didSignIn(with user: GoogleUser)
    func didFailWithError(_ error: AuthError)
    func didDisconnect()
}
