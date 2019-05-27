//
//  User.swift
//  ChildKid
//
//  Created by sang luc on 5/27/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import Foundation

class User {
    let uid: String!
    let email: String!
    let photoURL: String?
    let chucVu: String!
    let quyen: String!
    let phong: String?
    let lop: String?
    
    init(uid: String, email: String, photoURL: String, chucVu: String, quyen: String, phong: String = "", lop: String = "") {
        self.uid = uid
        self.email = email
        self.photoURL = photoURL
        self.chucVu = chucVu
        self.quyen = quyen
        self.phong = phong
        self.lop = lop
    }
}
