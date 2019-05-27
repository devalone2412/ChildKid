//
//  ViewController.swift
//  ChildKid
//
//  Created by Luc Thoi Sang on 5/9/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit
import SWRevealViewController

class DanhSachNhanVienVC: UIViewController {
    
    @IBOutlet weak var searchNV: UISearchBar!
    @IBOutlet weak var nhanVienTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Open.target = self.revealViewController()
        //        Open.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        nhanVienTableView.delegate = self
        nhanVienTableView.dataSource = self
        nhanVienTableView.showsVerticalScrollIndicator = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension DanhSachNhanVienVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nhanVienTableView.dequeueReusableCell(withIdentifier: "nhanvienCell", for: indexPath) as? NhanVienCell
        cell?.configure(name: "Lục Thới Sang", chucVu: "Bếp trưởng", quyen: "BT")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Đã click!")
    }
}

