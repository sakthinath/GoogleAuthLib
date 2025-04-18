//
//  AuthError.swift
//  GoogleAuthLib
//
//  Created by Sathyanath Masthan on 16/04/25.
//
import Foundation

public enum AuthError: Error {
    case noUserIdToken
    case noAccessToken
    case invalidUserData
    case signInCancelled
    case configurationError
    case unknownError(Error)
    
    public var localizedDescription: String {
        switch self {
        case .noUserIdToken: return "No user ID token found"
        case .noAccessToken: return "No access token found"
        case .invalidUserData: return "Invalid user data"
        case .signInCancelled: return "Sign in was cancelled"
        case .configurationError: return "Configuration error"
        case .unknownError(let error): return "Unknown error: \(error.localizedDescription)"
        }
    }
}
