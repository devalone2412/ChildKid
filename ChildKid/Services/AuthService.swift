//
//  AuthService.swift
//  ChildKid
//
//  Created by sang luc on 5/27/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
    static let instance = AuthService()
    
    func dangNhap(email: String, password: String, handler: @escaping (_ completion: Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                handler(false)
            } else {
                handler(true)
            }
        }
    }
    
    func dangXuat(handler: @escaping (_ completion: Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            handler(true)
        } catch {
            handler(false)
        }
    }
}
