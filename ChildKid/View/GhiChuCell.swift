//
//  GhiChuCell.swift
//  ChildKid
//
//  Created by SANG on 5/14/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit

class GhiChuCell: UITableViewCell {
    
    @IBOutlet weak var anhTre: BorderImageView!
    @IBOutlet weak var tenTre: UILabel!
    @IBOutlet weak var lop: UILabel!
    @IBOutlet weak var ghiChu: UILabel!
    
    func configure(image: UIImage = UIImage(named: "user-default")!, tenTre: String, lop: String, ghiChu: String) {
        self.anhTre.image = image
        self.tenTre.text = tenTre
        self.lop.text = "Lớp: \(lop)"
        self.ghiChu.text = "Ghi chú: \(ghiChu)"
    }
    
}
