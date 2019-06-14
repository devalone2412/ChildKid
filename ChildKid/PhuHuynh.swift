//
//  PhuHuynh.swift
//  ChildKid
//
//  Created by sang luc on 5/31/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import Foundation

class PhuHuynh {
    var email: String?
    var hoten: String?
    var photoUrl: String?
    var quyen: String?
    var tre: [String]?
    var uid: String?
    
    init(email: String, hoten: String, photoUrl: String, quyen: String, tre: [String], uid: String) {
        self.email = email
        self.hoten = hoten
        self.photoUrl = photoUrl
        self.quyen = quyen
        self.tre = tre
        self.uid = uid
    }
}
