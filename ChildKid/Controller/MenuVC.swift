//
//  MenuVC.swift
//  ChildKid
//
//  Created by Luc Thoi Sang on 5/9/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func dangXuatWasPressed(_ sender: UIButton) {
        AuthService.instance.dangXuat { (success) in
            if success {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "login") as! LoginVC
                let revealController = self.revealViewController()
                revealController?.pushFrontViewController(loginVC, animated: true)
            } else {
                print("Lỗi đăng xuất")
            }
        }
    }
}
