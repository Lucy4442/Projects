//
//  AuthenticationManager.swift
//  FirebaseAuthentication
//
//  Created by mac on 08/05/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid : String
    let email : String?
    let photourl : String?
    
    init(user : User)
    {
        self.uid = user.uid
        self.email = user.email
        self.photourl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private init() { }
    
     func createUser(email : String,password : String) async throws -> AuthDataResultModel{
      let authdataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authdataResult.user)
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
      guard  let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
       try Auth.auth().signOut()
    }
    
}


