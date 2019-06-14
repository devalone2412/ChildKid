//
//  DinhGiaThucDonVC.swift
//  ChildKid
//
//  Created by SANG on 5/13/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit
import SWRevealViewController
import FirebaseDatabase

class DinhGiaThucDonVC: UIViewController {

    @IBOutlet weak var minKPA: UITextField!
    @IBOutlet weak var maxKPA: UITextField!
    @IBOutlet weak var chiPhiPhatSinh: UITextField!
    @IBOutlet weak var laiMonAn: UITextField!
    @IBOutlet weak var soTienThuPH: UITextField!
    
    var key: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configSideMenu()
        configValueSoTienThuPH()
        readSettings()
    }
    
    func readSettings() {
        ref_DGTD.observe(.value) { (snapshot) in
            for settings in snapshot.children.allObjects as! [DataSnapshot] {
                let setObjects = settings.value as? [String: String]
                self.key = settings.key
                self.minKPA.text = setObjects!["minKPA"]
                self.maxKPA.text = setObjects!["maxKPA"]
                self.chiPhiPhatSinh.text = setObjects!["chiPhiPhatSinh"]
                self.laiMonAn.text = setObjects!["laiMonAn"]
                self.soTienThuPH.text = setObjects!["soTienThuPH"]
            }
        }
    }
    
    func configValueSoTienThuPH() {
        maxKPA.delegate = self
    }
    
    func configSideMenu() {
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
    }
    
    @IBAction func luuBtnWasPressed(_ sender: BorderButton) {
        if !minKPA.text!.isEmpty && !maxKPA.text!.isEmpty && !chiPhiPhatSinh.text!.isEmpty && !laiMonAn.text!.isEmpty && !soTienThuPH.text!.isEmpty {
            let settings = [
                "minKPA": minKPA.text,
                "maxKPA": maxKPA.text,
                "chiPhiPhatSinh": chiPhiPhatSinh.text,
                "laiMonAn": laiMonAn.text,
                "soTienThuPH": soTienThuPH.text
            ]
            
            if !key.isEmpty {
                let childUpdates = ["/\(key)" : settings]
                ref_DGTD.updateChildValues(childUpdates)
            } else {
                ref_DGTD.childByAutoId().setValue(settings)
            }
        }
        
        let alert = UIAlertController(title: "Thông báo", message: "Đã lưu thành công", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension DinhGiaThucDonVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let valueKPA = Int(textField.text!)
        soTienThuPH.text = "\(valueKPA! * 22)"
    }
}
