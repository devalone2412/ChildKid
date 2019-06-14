//
//  LoginVC.swift
//  ChildKid
//
//  Created by Luc Thoi Sang on 5/9/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit
import FirebaseAuth
import Toast_Swift

class LoginVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGenerals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let danhSachNhanVienVC = storyboard.instantiateViewController(withIdentifier: "dsNhanVien") as! DanhSachUserVC
            let nav = UINavigationController(rootViewController: danhSachNhanVienVC)
            let revealController = self.revealViewController()
            revealController?.pushFrontViewController(nav, animated: true)
        }  else {
            if let emailData = defaults.object(forKey: "email") as? String, let passwordData = defaults.object(forKey: "password") as? String {
                email.text = emailData
                password.text = passwordData
            }
        }
    }
    
    func setupGenerals() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func dangNhapWasPressed(_ sender: UIButton) {
        dismissKeyboard()
        self.view.makeToastActivity(.center)
        if let email = email.text, let password = password.text {
            AuthService.instance.dangNhap(email: email, password: password) { (success) in
                if success {
                    self.defaults.set(email, forKey: "email")
                    self.defaults.set(password, forKey: "password")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let danhSachNhanVienVC = storyboard.instantiateViewController(withIdentifier: "dsNhanVien") as! DanhSachUserVC
                    let nav = UINavigationController(rootViewController: danhSachNhanVienVC)
                    let revealController = self.revealViewController()
                    revealController?.pushFrontViewController(nav, animated: true)
                } else {
                    self.view.hideToastActivity()
                    print("Đăng nhập thất bại")
                    self.view.makeToast("Email hoặc mật khẩu không đúng", duration: 1.5, position: .bottom)
                }
            }
        }
    }
}
