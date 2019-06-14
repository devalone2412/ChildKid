//
//  LichSuYeuCauVC.swift
//  ChildKid
//
//  Created by SANG on 5/12/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LichSuYeuCauVC: UIViewController {
    
    @IBOutlet weak var lichSuYeuCauTableView: UITableView!
    @IBOutlet weak var userSC: UISegmentedControl!
    @IBOutlet weak var statusDatTiec: UISegmentedControl!
    
    var listYCPH = [YeuCauPH]()
    var listYCGV = [YeuCauGV]()
    var listMA = [MonAn]()
    var tenPH: String = ""
    var imageUrlTre = [String]()
    var tenTre = [String]()
    var tenNV: String = ""
    var imageUrlNV: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lichSuYeuCauTableView.delegate = self
        lichSuYeuCauTableView.dataSource = self
        lichSuYeuCauTableView.showsVerticalScrollIndicator = false
        
        getData()
    }
    
    func getData() {
        if userSC.selectedSegmentIndex == 0 {
            if statusDatTiec.selectedSegmentIndex == 0 {
                ref_DatTiec_PH.observe(.value) { (snapshot) in
                    for data in snapshot.children.allObjects as! [DataSnapshot] {
                        let ycPH = data.value as! [String: AnyObject]
                        if ycPH["isApprove"] as! String == "Y" {
                            let maMonAn = ycPH["MonAn"] as! [String]
                            let maTre = ycPH["Tre"] as! [String]
                            let giaTD = ycPH["giaTD"] as! String
                            let isApprove = ycPH["isApprove"] as! String
                            let ngayDat = ycPH["ngayDat"] as! String
                            let maPH = ycPH["nguoiDat"] as! String
                            let soKPAn = ycPH["soKPAn"] as! String
                            let maYC = data.key
                            
                            ref_MA_DT.observe(.value, with: { (snapshot) in
                                self.listMA.removeAll()
                                for data in snapshot.children.allObjects as! [DataSnapshot] {
                                    let maObjs = data.value as! [String: AnyObject]
                                    if maMonAn.contains(maObjs["maMA"] as! String) {
                                        let g = maObjs["G"] as! String
                                        let kCal = maObjs["Cal"] as! String
                                        let l = maObjs["L"] as! String
                                        let p = maObjs["P"] as! String
                                        let imageURL = maObjs["imageURL"] as! String
                                        let maCategory = maObjs["maCategory"] as! String
                                        let maMA = maObjs["maMA"] as! String
                                        let nguyenLieu = maObjs["nguyenlieu"] as! [[String: String]]
                                        let tenMA = maObjs["tenMA"] as! String
                                        let isChecked = false
                                        let gia = maObjs["gia"] as! String
                                        
                                        let monAn = MonAn(g: g, kCal: kCal, l: l, p: p, imageURL: imageURL, maCategory: maCategory, maMA: maMA, nguyenLieu: nguyenLieu, tenMA: tenMA, isChecked: isChecked)
                                        
                                        monAn.gia = gia
                                        self.listMA.append(monAn)
                                    }
                                }
                                
                                refPH.observe(.value, with: { (snapshot) in
                                    for data in snapshot.children.allObjects as! [DataSnapshot] {
                                        let phObjs = data.value as! [String: AnyObject]
                                        if maPH == data.key {
                                            self.tenPH = phObjs["ten"] as! String
                                            break;
                                        }
                                    }
                                    
                                    ref_Tre.observe(.value, with: { (snapshot) in
                                        self.tenTre.removeAll()
                                        self.listYCPH.removeAll()
                                        self.imageUrlTre.removeAll()
                                        for data in snapshot.children.allObjects as! [DataSnapshot] {
                                            let treObjs = data.value as! [String: AnyObject]
                                            if maTre.contains(data.key) {
                                                self.tenTre.append(treObjs["ten"] as! String)
                                                self.imageUrlTre.append(treObjs["imageURL"] as! String)
                                            }
                                        }
                                        
                                        let yc_PH = YeuCauPH(maYC: maYC, imageUrl: self.imageUrlTre,monAn: self.listMA, tenTre: self.tenTre, giaTD: giaTD, tenPH: self.tenPH, soKPAn: soKPAn, ngayDat: ngayDat, isApprove: isApprove)
                                        
                                        self.listYCPH.append(yc_PH)
                                        self.lichSuYeuCauTableView.reloadData()
                                    })
                                })
                            })
                        } else {
                            self.listYCPH.removeAll()
                            self.lichSuYeuCauTableView.reloadData()
                        }
                    }
                }
            } else {
                ref_DatTiec_PH.observe(.value) { (snapshot) in
                    for data in snapshot.children.allObjects as! [DataSnapshot] {
                        let ycPH = data.value as! [String: AnyObject]
                        if ycPH["isApprove"] as! String == "N" {
                            let maMonAn = ycPH["MonAn"] as! [String]
                            let maTre = ycPH["Tre"] as! [String]
                            let giaTD = ycPH["giaTD"] as! String
                            let isApprove = ycPH["isApprove"] as! String
                            let ngayDat = ycPH["ngayDat"] as! String
                            let maPH = ycPH["nguoiDat"] as! String
                            let soKPAn = ycPH["soKPAn"] as! String
                            let maYC = data.key
                            
                            ref_MA_DT.observe(.value, with: { (snapshot) in
                                self.listMA.removeAll()
                                for data in snapshot.children.allObjects as! [DataSnapshot] {
                                    let maObjs = data.value as! [String: AnyObject]
                                    if maMonAn.contains(maObjs["maMA"] as! String) {
                                        let g = maObjs["G"] as! String
                                        let kCal = maObjs["Cal"] as! String
                                        let l = maObjs["L"] as! String
                                        let p = maObjs["P"] as! String
                                        let imageURL = maObjs["imageURL"] as! String
                                        let maCategory = maObjs["maCategory"] as! String
                                        let maMA = maObjs["maMA"] as! String
                                        let nguyenLieu = maObjs["nguyenlieu"] as! [[String: String]]
                                        let tenMA = maObjs["tenMA"] as! String
                                        let isChecked = false
                                        let gia = maObjs["gia"] as! String
                                        
                                        let monAn = MonAn(g: g, kCal: kCal, l: l, p: p, imageURL: imageURL, maCategory: maCategory, maMA: maMA, nguyenLieu: nguyenLieu, tenMA: tenMA, isChecked: isChecked)
                                        
                                        monAn.gia = gia
                                        self.listMA.append(monAn)
                                    }
                                }
                                
                                refPH.observe(.value, with: { (snapshot) in
                                    for data in snapshot.children.allObjects as! [DataSnapshot] {
                                        let phObjs = data.value as! [String: AnyObject]
                                        if maPH == data.key {
                                            self.tenPH = phObjs["ten"] as! String
                                            break;
                                        }
                                    }
                                    
                                    ref_Tre.observe(.value, with: { (snapshot) in
                                        self.tenTre.removeAll()
                                        self.listYCPH.removeAll()
                                        self.imageUrlTre.removeAll()
                                        for data in snapshot.children.allObjects as! [DataSnapshot] {
                                            let treObjs = data.value as! [String: AnyObject]
                                            if maTre.contains(data.key) {
                                                self.tenTre.append(treObjs["ten"] as! String)
                                                self.imageUrlTre.append(treObjs["imageURL"] as! String)
                                            }
                                        }
                                        
                                        let yc_PH = YeuCauPH(maYC: maYC, imageUrl: self.imageUrlTre,monAn: self.listMA, tenTre: self.tenTre, giaTD: giaTD, tenPH: self.tenPH, soKPAn: soKPAn, ngayDat: ngayDat, isApprove: isApprove)
                                        
                                        self.listYCPH.append(yc_PH)
                                        self.lichSuYeuCauTableView.reloadData()
                                    })
                                })
                            })
                        } else {
                            self.listYCPH.removeAll()
                            self.lichSuYeuCauTableView.reloadData()
                        }
                    }
                }
            }
        } else {
            if statusDatTiec.selectedSegmentIndex == 0 {
                ref_DatTiec_GV.observe(.value) { (snapshot) in
                    for data in snapshot.children.allObjects as! [DataSnapshot] {
                        let dtObjs = data.value as! [String: AnyObject]
                        if dtObjs["isApprove"] as! String == "Y" {
                            let maMonAn = dtObjs["MonAn"] as! [String]
                            let description = dtObjs["description"] as! String
                            let giaTD = dtObjs["giaTD"] as! String
                            let isApprove = dtObjs["isApprove"] as! String
                            let ngayDat = dtObjs["ngayDat"] as! String
                            let nguoiDat = dtObjs["nguoiDat"] as! String
                            let soKPAn = dtObjs["soKPAn"] as! String
                            let maYC = data.key
                            
                            ref_MA_DT.observe(.value, with: { (snapshot) in
                                self.listMA.removeAll()
                                for data in snapshot.children.allObjects as! [DataSnapshot] {
                                    let maObjs = data.value as! [String: AnyObject]
                                    if maMonAn.contains(maObjs["maMA"] as! String) {
                                        let g = maObjs["G"] as! String
                                        let kCal = maObjs["Cal"] as! String
                                        let l = maObjs["L"] as! String
                                        let p = maObjs["P"] as! String
                                        let imageURL = maObjs["imageURL"] as! String
                                        let maCategory = maObjs["maCategory"] as! String
                                        let maMA = maObjs["maMA"] as! String
                                        let nguyenLieu = maObjs["nguyenlieu"] as! [[String: String]]
                                        let tenMA = maObjs["tenMA"] as! String
                                        let isChecked = false
                                        let gia = maObjs["gia"] as! String
                                        
                                        let monAn = MonAn(g: g, kCal: kCal, l: l, p: p, imageURL: imageURL, maCategory: maCategory, maMA: maMA, nguyenLieu: nguyenLieu, tenMA: tenMA, isChecked: isChecked)
                                        monAn.gia = gia
                                        
                                        self.listMA.append(monAn)
                                    }
                                }
                                
                                refNV.observe(.value, with: { (snapshot) in
                                    self.listYCGV.removeAll()
                                    for data in snapshot.children.allObjects as! [DataSnapshot] {
                                        let nvObjs = data.value as! [String: AnyObject]
                                        if nguoiDat == data.key {
                                            self.tenNV = nvObjs["hoTen"] as! String
                                            self.imageUrlNV = nvObjs["photoUrl"] as! String
                                            break;
                                        }
                                    }
                                    
                                    let yc_GV = YeuCauGV(maYC: maYC, imageUrl: self.imageUrlNV, monAn: self.listMA, description: description, giaTD: giaTD, isApprove: isApprove, ngayDat: ngayDat, tenGV: self.tenNV, soKPAn: soKPAn)
                                    
                                    self.listYCGV.append(yc_GV)
                                    self.lichSuYeuCauTableView.reloadData()
                                })
                            })
                        } else {
                            self.listYCGV.removeAll()
                            self.lichSuYeuCauTableView.reloadData()
                        }
                    }
                }
            } else {
                ref_DatTiec_GV.observe(.value) { (snapshot) in
                    for data in snapshot.children.allObjects as! [DataSnapshot] {
                        let dtObjs = data.value as! [String: AnyObject]
                        if dtObjs["isApprove"] as! String == "N" {
                            let maMonAn = dtObjs["MonAn"] as! [String]
                            let description = dtObjs["description"] as! String
                            let giaTD = dtObjs["giaTD"] as! String
                            let isApprove = dtObjs["isApprove"] as! String
                            let ngayDat = dtObjs["ngayDat"] as! String
                            let nguoiDat = dtObjs["nguoiDat"] as! String
                            let soKPAn = dtObjs["soKPAn"] as! String
                            let maYC = data.key
                            
                            ref_MA_DT.observe(.value, with: { (snapshot) in
                                self.listMA.removeAll()
                                for data in snapshot.children.allObjects as! [DataSnapshot] {
                                    let maObjs = data.value as! [String: AnyObject]
                                    if maMonAn.contains(maObjs["maMA"] as! String) {
                                        let g = maObjs["G"] as! String
                                        let kCal = maObjs["Cal"] as! String
                                        let l = maObjs["L"] as! String
                                        let p = maObjs["P"] as! String
                                        let imageURL = maObjs["imageURL"] as! String
                                        let maCategory = maObjs["maCategory"] as! String
                                        let maMA = maObjs["maMA"] as! String
                                        let nguyenLieu = maObjs["nguyenlieu"] as! [[String: String]]
                                        let tenMA = maObjs["tenMA"] as! String
                                        let isChecked = false
                                        let gia = maObjs["gia"] as! String
                                        
                                        let monAn = MonAn(g: g, kCal: kCal, l: l, p: p, imageURL: imageURL, maCategory: maCategory, maMA: maMA, nguyenLieu: nguyenLieu, tenMA: tenMA, isChecked: isChecked)
                                        monAn.gia = gia
                                        
                                        self.listMA.append(monAn)
                                    }
                                }
                                
                                refNV.observe(.value, with: { (snapshot) in
                                    self.listYCGV.removeAll()
                                    for data in snapshot.children.allObjects as! [DataSnapshot] {
                                        let nvObjs = data.value as! [String: AnyObject]
                                        if nguoiDat == data.key {
                                            self.tenNV = nvObjs["hoTen"] as! String
                                            self.imageUrlNV = nvObjs["photoUrl"] as! String
                                            break;
                                        }
                                    }
                                    
                                    let yc_GV = YeuCauGV(maYC: maYC, imageUrl: self.imageUrlNV, monAn: self.listMA, description: description, giaTD: giaTD, isApprove: isApprove, ngayDat: ngayDat, tenGV: self.tenNV, soKPAn: soKPAn)
                                    
                                    self.listYCGV.append(yc_GV)
                                    self.lichSuYeuCauTableView.reloadData()
                                })
                            })
                        } else {
                            self.listYCGV.removeAll()
                            self.lichSuYeuCauTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func userChanged(_ sender: UISegmentedControl) {
        statusDatTiec.selectedSegmentIndex = 0
        getData()
        lichSuYeuCauTableView.reloadData()
    }
    
    @IBAction func statusChanged(_ sender: UISegmentedControl) {
        getData()
        lichSuYeuCauTableView.reloadData()
    }
    
}

extension LichSuYeuCauVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch userSC.selectedSegmentIndex {
        case 0:
            return listYCPH.count
        case 1:
            return listYCGV.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch userSC.selectedSegmentIndex {
        case 0:
            let cell = lichSuYeuCauTableView.dequeueReusableCell(withIdentifier: "lichSuYeuCauCell", for: indexPath) as? YeuCauPHCell
            
            DispatchQueue.global().async {
                let url = URL(string: self.listYCPH[indexPath.row].imageUrl[0])!
                let imageData = try! Data(contentsOf: url)
                let tenPH = self.listYCPH[indexPath.row].tenPH!
                let tenTre = self.listYCPH[indexPath.row].tenTre!
                let ngayDat = self.listYCPH[indexPath.row].ngayDat
                let soKPAn = self.listYCPH[indexPath.row].soKPAn
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)!
                    cell?.configure(anhTre: image, tenPH: tenPH, tenTre: tenTre, ngayDat: ngayDat!, soKPAn: soKPAn!)
                }
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = lichSuYeuCauTableView.dequeueReusableCell(withIdentifier: "lichSuYeuCauCellGV", for: indexPath) as! YeuCauGVCell
            DispatchQueue.global().async {
                let url = URL(string: self.listYCGV[indexPath.row].imageUrl)!
                let imageData = try! Data(contentsOf: url)
                let tenGV = self.listYCGV[indexPath.row].tenGV
                let description = self.listYCGV[indexPath.row].description
                let ngayDat = self.listYCGV[indexPath.row].ngayDat
                let soKPAn = self.listYCGV[indexPath.row].soKPAn
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)!
                    cell.configure(image: image, tenGV: tenGV!, moTa: description!, ngayDat: ngayDat!, soKPAn: soKPAn!)
                }
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = xoa(indexPath: indexPath)
        let khoiPhuc = getBack(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, khoiPhuc])
    }
    
    func xoa(indexPath: IndexPath) -> UIContextualAction {
        let xoa = UIContextualAction(style: .destructive, title: "Xoá") { (action, view, completion) in
            if self.userSC.selectedSegmentIndex == 0 {
                ref_DatTiec_PH.child(self.listYCPH[indexPath.row].maYC).removeValue()
                self.getData()
            } else {
                ref_DatTiec_GV.child(self.listYCGV[indexPath.row].maYC).removeValue()
                self.getData()
            }
            completion(true)
        }
        xoa.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
        return xoa
    }
    
    func getBack(indexPath: IndexPath) -> UIContextualAction {
        let getBack = UIContextualAction(style: .normal, title: "Khôi phục") { (action, view, completion) in
            if self.userSC.selectedSegmentIndex == 0 {
                ref_DatTiec_PH.child(self.listYCPH[indexPath.row].maYC).updateChildValues(["isApprove": ""])
                self.getData()
            } else {
                ref_DatTiec_GV.child(self.listYCGV[indexPath.row].maYC).updateChildValues(["isApprove": ""])
                self.getData()
            }
            completion(true)
        }
        getBack.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        return getBack
    }
    
}
