//
//  AuthenticationManager.swift
//  435messagingnumber4
//
//  Created by Chase Morrone on 12/1/23.
//

import Foundation
import Firebase

class AuthenticationManager {
    func signIn(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }

    func signUp(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}
