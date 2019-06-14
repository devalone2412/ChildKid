//
//  ThemNhanVienVC.swift
//  ChildKid
//
//  Created by SANG on 5/12/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit
import Toast_Swift
import FirebaseDatabase
import FirebaseAuth
import iOSDropDown

class ThemNhanVienVC: UIViewController {
    
    @IBOutlet weak var hoTenTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var chucVuSegment: UISegmentedControl!
    @IBOutlet weak var quyenSegment: UISegmentedControl!
    @IBOutlet weak var phongDropdown: DropDown!
    @IBOutlet weak var lopDropdown: DropDown!
    
    let itemsChucVu = ["B.Trưởng", "NV.Bếp", "NV.Kho", "Bảo mẫu", "Giáo viên"]
    let itemsQuyen = ["BT", "NVB", "NVK", "BM", "GV"]
    var phongSelected = ""
    var lopSelected = ""
    let id = Int.random(in: 100000..<1000000)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configDismissKeyboard()
        setupNavbar()
        configDropdown()
        initID()
    }
    
    func initID() {
        emailTF.text = "\(id)@childkit.com"
    }
    
    func configDropdown() {
        phongDropdown.optionArray = ["None","Phòng 1", "Phòng 2", "Phòng 3", "Phòng 4", "Phòng 5"]
        phongDropdown.optionIds = [0, 1, 2, 3, 4, 5]
        phongDropdown.isSearchEnable = false
        phongDropdown.selectedRowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        phongDropdown.listHeight = 200
        
        phongDropdown.didSelect { (selectedText , index, id) in
            self.phongSelected = selectedText
        }
        
        lopDropdown.optionArray = ["None","Lớp mầm", "Lớp chồi", "Lớp lá"]
        lopDropdown.optionIds = [0, 1, 2, 3, 4]
        lopDropdown.isSearchEnable = false
        lopDropdown.selectedRowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        lopDropdown.listHeight = 200
        
        lopDropdown.didSelect { (selectedText, index, id) in
            self.lopSelected = selectedText
        }
    }
    
    func setupNavbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Thêm", style: .done, target: self, action: #selector(addNhanVien))
    }
    
    @objc func addNhanVien() {
        if hoTenTF.text! != "" && phongSelected != "" && lopSelected != "" {
            let hoten = hoTenTF.text
            let email = emailTF.text!
            let chucVu = itemsChucVu[chucVuSegment.selectedSegmentIndex]
            let quyen = itemsQuyen[quyenSegment.selectedSegmentIndex]
            let phong = phongSelected
            let lop = lopSelected
            let isDelete = false
            
            Auth.auth().createUser(withEmail: email, password: "\(id)") { (authResult, error) in
                guard let userNV = authResult?.user else {
                    print(error?.localizedDescription)
                    return
                }
                let nhanVien: [String: Any] = [
                    "maNhanVien" : "\(self.id)",
                    "chucVu" : chucVu,
                    "email" : email,
                    "hoTen" : hoten as! String,
                    "isDelete" : isDelete,
                    "lop" : lop as! String,
                    "phong" : phong as! String,
                    "photoUrl" : "https://firebasestorage.googleapis.com/v0/b/childkit-1c357.appspot.com/o/icons8-user_male_filled%403x.png?alt=media&token=5d48b79d-051a-46c8-994b-55ea3a6be9c3",
                    "quyen" : quyen,
                    "uid" : userNV.uid
                ]
                refNV.childByAutoId().setValue(nhanVien)
                self.navigationController?.popViewController(animated: true)
                
            }
        } else {
            view.makeToast("Xin vui lòng điền đầy đủ thông tin", duration: 1, position: .bottom)
        }
    }
    
    func configDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
