//
//  ViewController.swift
//  ChildKid
//
//  Created by Luc Thoi Sang on 5/9/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit
import SWRevealViewController
import BTNavigationDropdownMenu
import FirebaseDatabase
import FirebaseAuth

class DanhSachUserVC: UIViewController {
    
    @IBOutlet weak var searchUser: UISearchBar!
    @IBOutlet weak var userTableView: UITableView!
    
    
    let items = ["Nhân viên", "Phụ huynh"]
    var arrayEmpls = [Empl]()
    var arrayPhs = [PhuHuynh]()
    var userSelected = "Nhân viên"
    var isSearching = false
    var filteredDataNV = [Empl]()
    var filteredDataPH = [PhuHuynh]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Open.target = self.revealViewController()
        //        Open.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        
        getData()
        
        configTableView()
        setupDismissKeyboard()
        configureDropdownNav()
        searchUser.delegate = self
    }
    
    func getData() {
        if userSelected == "Nhân viên" {
            refNV.observe(.value) { (snapshot) in
                self.arrayEmpls.removeAll()
                for empls in snapshot.children.allObjects as! [DataSnapshot] {
                    let emplObject = empls.value as? [String: AnyObject]
                    let id = emplObject?["maNhanVien"] as! String
                    let chucVu = emplObject?["chucVu"] as! String
                    let email = emplObject?["email"] as! String
                    let hoTen = emplObject?["hoTen"] as! String
                    let isDelete = emplObject?["isDelete"] as! Int
                    let lop = emplObject?["lop"] as! String
                    let phong = emplObject?["phong"] as! String
                    let photoUrl = emplObject?["photoUrl"] as! String
                    let quyen = emplObject?["quyen"] as! String
                    let uid = emplObject?["uid"] as! String
                    
                    let empl = Empl(id: id, uid: uid, email: email, photoURL: photoUrl, chucVu: chucVu, quyen: quyen, phong: phong, lop: lop, hoten: hoTen, isdelete: isDelete)
                    self.arrayEmpls.append(empl)
                }
                self.userTableView.reloadData()
            }
        } else {
            refPH.observe(.value) { (snapshot) in
                self.arrayPhs.removeAll()
                for phs in snapshot.children.allObjects as! [DataSnapshot] {
                    let phObject = phs.value as? [String: AnyObject]
                    let email = phObject?["email"] as! String
                    let hoten = phObject?["ten"] as! String
                    let photoUrl = phObject?["imageUrl"] as! String
                    let quyen = phObject?["quyen"] as! String
                    let tre = phObject?["Tre"] as! [String]
                    let uid = phObject?["uid"] as! String
                    
                    let ph = PhuHuynh(email: email, hoten: hoten, photoUrl: photoUrl, quyen: quyen, tre: tre, uid: uid)
                    self.arrayPhs.append(ph)
                }
                self.userTableView.reloadData()
            }
        }
    }
    
    func configTableView() {
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.showsVerticalScrollIndicator = false
    }
    
    func setupDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    func configureDropdownNav() {
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("Nhân viên"), items: items)
        menuView.cellBackgroundColor = #colorLiteral(red: 0.2470588235, green: 0.6666666667, blue: 0.8862745098, alpha: 1)
        menuView.cellSeparatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        menuView.cellTextLabelFont = UIFont(name: "AvenirNext-DemiBold", size: 17)
        menuView.navigationBarTitleFont = UIFont(name: "AvenirNext-DemiBold", size: 17)
        menuView.cellSelectionColor = #colorLiteral(red: 0.1294117647, green: 0.6156862745, blue: 0.8705882353, alpha: 1)
        menuView.arrowTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        self.navigationItem.titleView = menuView
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            self?.userSelected = self!.items[indexPath]
            switch self!.items[indexPath] {
            case "Nhân viên":
                if self?.arrayEmpls.count != 0 {
                    self?.userTableView.reloadData()
                    return
                }
            case "Phụ huynh":
                if self?.arrayPhs.count != 0 {
                    self?.userTableView.reloadData()
                    return
                }
            default:
                return
            }
            
            self?.getData()
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func themUserWasClicked(_ sender: UIBarButtonItem) {
        if userSelected == "Nhân viên" {
            let themNVVC = storyboard?.instantiateViewController(withIdentifier: "themNV") as! ThemNhanVienVC
            navigationController?.pushViewController(themNVVC, animated: true)
        } else {
            themPH()
        }
    }
    
    func themPH() {
        let email = "nguyenvannam@gmail.com"
        let tre = ["LgNb1aaPn-xmNlMgXKK", "LgNb4LXkoPAvyC5DUSB"]
        Auth.auth().createUser(withEmail: email, password: "mido123456") { (authResult, error) in
            guard let user = authResult?.user else { return }
            let ph = [
                "uid" : user.uid,
                "email" : email,
                "ten" : "Nguyen Van Nam",
                "quyen" : "PH",
                "imageUrl" : "https://firebasestorage.googleapis.com/v0/b/childkit-1c357.appspot.com/o/icons8-user_male_filled%403x.png?alt=media&token=5d48b79d-051a-46c8-994b-55ea3a6be9c3",
                "Tre" : tre
                ] as [String : Any]
            refPH.childByAutoId().setValue(ph)
        }
        print("Đã thêm thành  ")
    }
}

extension DanhSachUserVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userSelected == "Nhân viên" {
            if isSearching {
                return filteredDataNV.count
            } else {
                return arrayEmpls.count
            }
        } else {
            if isSearching {
                return filteredDataPH.count
            } else {
                return arrayPhs.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userSelected == "Nhân viên" {
            let cell = userTableView.dequeueReusableCell(withIdentifier: "nhanvienCell", for: indexPath) as? NhanVienCell
            DispatchQueue.global().async {
                if self.isSearching {
                    let url = URL(string: self.filteredDataNV[indexPath.row].photourl!)!
                    let imageData = try! Data(contentsOf: url)
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)!
                        cell?.configure(image: image, name: self.filteredDataNV[indexPath.row].hoten!, chucVu: self.filteredDataNV[indexPath.row].chucvu!, quyen: self.filteredDataNV[indexPath.row].quyen!)
                    }
                } else {
                    let url = URL(string: self.arrayEmpls[indexPath.row].photourl!)!
                    do {
                        let imageData = try! Data(contentsOf: url)
                        DispatchQueue.main.async {
                            let image = UIImage(data: imageData)!
                            cell?.configure(image: image, name: self.arrayEmpls[indexPath.row].hoten!, chucVu: self.arrayEmpls[indexPath.row].chucvu!, quyen: self.arrayEmpls[indexPath.row].quyen!)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            return cell!
        } else {
            let cell = userTableView.dequeueReusableCell(withIdentifier: "phuHuynhCell", for: indexPath) as? PhuHuynhCell
            
            DispatchQueue.global().async {
                if self.isSearching {
                    let url = URL(string: self.filteredDataPH[indexPath.row].photoUrl!)!
                    let imageData = try! Data(contentsOf: url)
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)!
                        cell?.configure(image: image, name: self.filteredDataPH[indexPath.row].hoten!, quyen: self.filteredDataPH[indexPath.row].quyen!)
                    }
                } else {
                    let url = URL(string: self.arrayPhs[indexPath.row].photoUrl!)!
                    let imageData = try! Data(contentsOf: url)
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)!
                        cell?.configure(image: image, name: self.arrayPhs[indexPath.row].hoten!, quyen: self.arrayPhs[indexPath.row].quyen!)
                    }
                }
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Đã click!")
    }
}

extension DanhSachUserVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchUser.text == nil || searchUser.text == "" {
            isSearching = false
            view.endEditing(true)
            userTableView.reloadData()
        } else {
            isSearching = true
            if userSelected == "Nhân viên" {
                filteredDataNV = arrayEmpls.filter({ (empl) -> Bool in
                    (empl.hoten?.contains(searchText))!
                })
            } else {
                filteredDataPH = arrayPhs.filter({ (phuHuynh) -> Bool in
                    (phuHuynh.hoten?.contains(searchText))!
                })
            }
            userTableView.reloadData()
        }
    }
}
