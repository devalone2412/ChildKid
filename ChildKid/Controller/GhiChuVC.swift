//
//  GhiChuVC.swift
//  ChildKid
//
//  Created by SANG on 5/14/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit

class GhiChuVC: UIViewController {

    @IBOutlet weak var ghiChuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ghiChuTableView.delegate = self
        ghiChuTableView.dataSource = self
        ghiChuTableView.rowHeight = UITableView.automaticDimension
        ghiChuTableView.estimatedRowHeight = 600
    }

}

extension GhiChuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ghiChuTableView.dequeueReusableCell(withIdentifier: "ghiChuCell", for: indexPath) as! GhiChuCell
        cell.configure(tenTre: "Nguyễn Huy Hoàng", lop: "Chồi 5", ghiChu: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book")
        return cell
    }
    
    
}
