//
//  PhuHuynhCell.swift
//  ChildKid
//
//  Created by sang luc on 5/31/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit

class PhuHuynhCell: UITableViewCell {

    @IBOutlet weak var phuHuynhImage: UIImageView!
    @IBOutlet weak var phuHuynhName: UILabel!
    @IBOutlet weak var quyen: UILabel!
    
    func configure(image: UIImage = UIImage(named: "user-default")!, name: String, quyen: String) {
        self.phuHuynhImage.image = image ?? UIImage(named: "user-default")
        self.phuHuynhName.text = "Tên phụ huynh: \(name)"
        self.quyen.text = "Quyền: \(quyen)"
    }

}
