//
//  User.swift
//  ChildKid
//
//  Created by sang luc on 5/27/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import Foundation

class Empl {
    var id: String?
    var uid: String?
    var email: String?
    var photourl: String?
    var chucvu: String?
    var quyen: String?
    var phong: String?
    var lop: String?
    var hoten: String?
    var isdelete: Int?
    
    init(id: String, uid: String, email: String, photoURL: String, chucVu: String, quyen: String, phong: String, lop: String, hoten: String, isdelete: Int) {
        self.id = id
        self.uid = uid
        self.email = email
        self.photourl = photoURL
        self.chucvu = chucVu
        self.quyen = quyen
        self.phong = phong
        self.lop = lop
        self.hoten = hoten
        self.isdelete = isdelete
    }
}
