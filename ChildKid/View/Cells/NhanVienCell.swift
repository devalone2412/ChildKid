//
//  NhanVienCell.swift
//  ChildKid
//
//  Created by Luc Thoi Sang on 5/9/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit

class NhanVienCell: UITableViewCell {
    
    @IBOutlet weak var imageNhanVien: UIImageView!
    @IBOutlet weak var nameNhanVien: UILabel!
    @IBOutlet weak var chucVuNhanVien: UILabel!
    @IBOutlet weak var quyenNhanVien: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(image: UIImage = UIImage(named: "user-default")!, name: String, chucVu: String, quyen: String) {
        self.imageNhanVien.image = image
        self.nameNhanVien.text = "Tên nhân viên: \(name)"
        self.chucVuNhanVien.text = "Chức vụ: \(chucVu)"
        self.quyenNhanVien.text = "Quyền: \(quyen)"
    }
    
}
