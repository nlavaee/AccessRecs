//
//  User.swift
//  AccesRecs
//
//  Created by Amaris Sim on 11/14/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import AuthenticationServices

struct User {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    
    init (credentials: ASAuthorizationAppleIDCredential){
        self.id = credentials.user
        self.firstName = credentials.fullName?.givenName ?? ""
        self.lastName = credentials.fullName?.familyName ?? ""
        self.email = credentials.email ?? ""
    }

}

extension User: CustomDebugStringConvertible{
    var debugDescription: String {
        return """
        ID: \(id)
        FirstName: \(firstName)
        lastName: \(lastName)
        email: \(email)
        """
    }
}
