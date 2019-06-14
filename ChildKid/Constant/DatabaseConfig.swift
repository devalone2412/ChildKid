//
//  FirebaseConfig.swift
//  ChildKid
//
//  Created by sang luc on 6/1/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import Foundation
import FirebaseDatabase

let ref = Database.database().reference()
let refNV = ref.child("Nhân viên")
let refPH = ref.child("Phụ huynh")
let ref_DGTD = ref.child("Định giá thực đơn")
let ref_DatTiec_PH = ref.child("Đặt tiệc").child("Phụ huynh")
let ref_DatTiec_GV = ref.child("Đặt tiệc").child("Giáo viên")
let ref_MA_DT = ref.child("Món ăn").child("Món đặt tiệc")
let ref_Tre = ref.child("Trẻ")
