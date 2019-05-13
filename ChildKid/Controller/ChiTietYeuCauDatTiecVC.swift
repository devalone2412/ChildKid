//
//  ChiTietYeuCauDatTiecVC.swift
//  ChildKid
//
//  Created by SANG on 5/13/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit

class ChiTietYeuCauDatTiecVC: UIViewController {
    
    @IBOutlet weak var menuDatTiecTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuDatTiecTableView.delegate = self
        menuDatTiecTableView.dataSource = self
        menuDatTiecTableView.showsVerticalScrollIndicator = false
    }
    
}

extension ChiTietYeuCauDatTiecVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuDatTiecTableView.dequeueReusableCell(withIdentifier: "menuDatTiecCell", for: indexPath) as! MenuDatTiecCell
        cell.configure(foodName: "Bún nêm nướng kiểu thái lan", kcal: "200", protein: "15", lipit: "2", gluxit: "30")
        return cell 
    }
    
    
}
