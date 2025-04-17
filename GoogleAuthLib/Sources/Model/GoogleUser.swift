//
//  GoogleUser.swift
//  GoogleAuthLib
//
//  Created by Sathyanath Masthan on 16/04/25.
//

public struct GoogleUser {
    public let id: String
    public let fullName: String
    public let givenName: String?
    public let familyName: String?
    public let email: String
    public let profileImageURL: URL?
    
    public init(id: String, fullName: String, givenName: String?, familyName: String?, email: String, profileImageURL: URL?) {
        self.id = id
        self.fullName = fullName
        self.givenName = givenName
        self.familyName = familyName
        self.email = email
        self.profileImageURL = profileImageURL
    }
}
