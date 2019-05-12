//
//  LoginVC.swift
//  ChildKid
//
//  Created by Luc Thoi Sang on 5/9/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGenerals()
    }
    
    func setupGenerals() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func dangNhapWasPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let danhSachNhanVienVC = storyboard.instantiateViewController(withIdentifier: "dsNhanVien") as! DanhSachNhanVienVC
        let nav = UINavigationController(rootViewController: danhSachNhanVienVC)
        let revealController = self.revealViewController()
        revealController?.pushFrontViewController(nav, animated: true)
    }
}
