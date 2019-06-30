//
//  YeuCauDatTiecVC.swift
//  ChildKid
//
//  Created by SANG on 5/12/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI

class YeuCauDatTiecVC: UIViewController {
    
    @IBOutlet weak var yeuCauTableView: UITableView!
    @IBOutlet weak var userSC: UISegmentedControl!
    
    var listYCPH = [YeuCauPH]()
    var listMA = [MonAn]()
    var tenTre = [String]()
    var tenPH: String = ""
    var imageUrlTre = [String]()
    var tenNV: String = ""
    var imageUrlNV: String!
    var listYCGV = [YeuCauGV]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        yeuCauTableView.delegate = self
        yeuCauTableView.dataSource = self
        yeuCauTableView.showsVerticalScrollIndicator = false
        getDataYeuCau()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataYeuCau()
    }
    
    func getDataYeuCau() {
        switch userSC.selectedSegmentIndex {
        case 0:
            ref_DatTiec_PH.observe(.value) { (snapshot) in
                self.listYCPH.removeAll()
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    let ycPH = data.value as! [String: AnyObject]
                    let maMonAn = ycPH["MonAn"] as! [String]
                    let maTre = ycPH["Tre"] as! [String]
                    let giaTD = ycPH["giaTD"] as! String
                    let isApprove = ycPH["isApprove"] as! String
                    let ngayDat = ycPH["ngayDat"] as! String
                    let maPH = ycPH["nguoiDat"] as! String
                    let soKPAn = ycPH["soKPAn"] as! String
                    let maYC = data.key
                    
                    if isApprove != "Y" && isApprove != "N" {
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
                                    self.yeuCauTableView.reloadData()
                                })
                            })
                        })
                    } else {
                        self.listYCPH.removeAll()
                        self.yeuCauTableView.reloadData()
                    }
                }
            }
        case 1:
            ref_DatTiec_GV.observe(.value) { (snapshot) in
                self.listYCGV.removeAll()
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    let dtObjs = data.value as! [String: AnyObject]
                    let maMonAn = dtObjs["MonAn"] as! [String]
                    let description = dtObjs["description"] as! String
                    let giaTD = dtObjs["giaTD"] as! String
                    let isApprove = dtObjs["isApprove"] as! String
                    let ngayDat = dtObjs["ngayDat"] as! String
                    let nguoiDat = dtObjs["nguoiDat"] as! String
                    let soKPAn = dtObjs["soKPAn"] as! String
                    let maYC = data.key
                    
                    
                    if isApprove != "Y" && isApprove != "N" {
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
                                self.yeuCauTableView.reloadData()
                            })
                        })
                    } else {
                        self.listYCGV.removeAll()
                        self.yeuCauTableView.reloadData()
                    }
                }
            }
        default:
            return
        }
    }
    
    @IBAction func userSCChange(_ sender: UISegmentedControl) {
        getDataYeuCau()
    }
    
    func sendMail(message: String) {
        let mailComposeVC = self.configMailController(message: message)
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeVC, animated: true, completion: nil)
        } else {
            print("Không thể gửi được")
        }
    }
    
    func configMailController(message: String) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.setSubject("Yêu cầu đặt tiệc mới từ phụ huynh")
        mailComposerVC.setMessageBody("<b>\(message)</b>", isHTML: true)
        mailComposerVC.setToRecipients(["sanglt2412@gmail.com"])
        mailComposerVC.mailComposeDelegate = self
        return mailComposerVC
    }
}

extension YeuCauDatTiecVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension YeuCauDatTiecVC: UITableViewDelegate, UITableViewDataSource {
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
            let cell = yeuCauTableView.dequeueReusableCell(withIdentifier: "yeuCauPHCell", for: indexPath) as? YeuCauPHCell
            
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
            let cell = yeuCauTableView.dequeueReusableCell(withIdentifier: "yeuCauGVCell", for: indexPath) as! YeuCauGVCell
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
        let chapNhan = approve(indexPath: indexPath)
        let tuChoi = disapprove(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [tuChoi, chapNhan])
    }
    
    func approve(indexPath: IndexPath) -> UIContextualAction {
        let approve = UIContextualAction(style: .normal, title: "Chấp nhận") { (action, view, completion) in
            switch self.userSC.selectedSegmentIndex {
            case 0:
                ref_DatTiec_PH.child(self.listYCPH[indexPath.row].maYC).updateChildValues(["isApprove": "Y"])
                self.getDataYeuCau()
//                self.sendMail(message: "Yêu cầu đặt tiệc của quý phụ huynh đã được chấp nhận! Xin vui lòng thanh toán phí đặt tiệc trong vòng 3 ngày từ khi nhận được email này!")
            case 1:
                ref_DatTiec_GV.child(self.listYCGV[indexPath.row].maYC).updateChildValues(["isApprove": "Y"])
                self.getDataYeuCau()
//                self.sendMail(message: "Yêu cầu đặt tiệc của bạn đã được chấp nhận!")
            default:
                return
            }
            completion(true)
        }
        approve.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        return approve
    }
    
    func disapprove(indexPath: IndexPath) -> UIContextualAction {
        let disapprove = UIContextualAction(style: .destructive, title: "Từ chối") { (action, view, completion) in
            switch self.userSC.selectedSegmentIndex {
            case 0:
                ref_DatTiec_PH.child(self.listYCPH[indexPath.row].maYC).updateChildValues(["isApprove": "N"])
                self.getDataYeuCau()
//                self.sendMail(message: "Yêu cầu đặt tiệc của quý phụ huynh không được chấp nhận")
            case 1:
                ref_DatTiec_GV.child(self.listYCGV[indexPath.row].maYC).updateChildValues(["isApprove": "N"])
                self.getDataYeuCau()
//                self.sendMail(message: "Yêu cầu đặt tiệc của bạn không được chấp nhận!")
            default:
                return
            }
            completion(true)
        }
        disapprove.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
        return disapprove
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chiTietYeuCauDatTiecVC = storyboard?.instantiateViewController(withIdentifier: "chitietyeucau") as? ChiTietYeuCauDatTiecVC
        chiTietYeuCauDatTiecVC?.index = userSC.selectedSegmentIndex
        switch userSC.selectedSegmentIndex {
        case 0:
            chiTietYeuCauDatTiecVC?.ycDTPH = listYCPH[indexPath.row]
        case 1:
            chiTietYeuCauDatTiecVC?.ycDTGV = listYCGV[indexPath.row]
        default:
            return
        }
        navigationController?.pushViewController(chiTietYeuCauDatTiecVC!, animated: true)
    }
}
