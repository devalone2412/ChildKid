//
//  MenuDatTiecCellTableViewCell.swift
//  ChildKid
//
//  Created by SANG on 5/13/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit

class MenuDatTiecCell: UITableViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var kcalLbl: UILabel!
    @IBOutlet weak var proteinLbl: UILabel!
    @IBOutlet weak var lipitLbl: UILabel!
    @IBOutlet weak var gluxitLbl: UILabel!
    
    func configure(image: UIImage = UIImage(named: "mon-default")!, foodName: String, kcal: String, protein: String, lipit: String, gluxit: String) {
        self.foodImage.image = image
        self.foodName.text = foodName
        self.kcalLbl.text = "\(kcal) kcal"
        self.proteinLbl.text = "Protein: \(protein)g"
        self.lipitLbl.text = "Lipit: \(lipit)g"
        self.gluxitLbl.text = "Gluxit: \(gluxit)g"
    }
    
}
