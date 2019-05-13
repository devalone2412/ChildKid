//
//  LichSuYeuCauVC.swift
//  ChildKid
//
//  Created by SANG on 5/12/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit

class LichSuYeuCauVC: UIViewController {
    
    @IBOutlet weak var lichSuYeuCauTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lichSuYeuCauTableView.delegate = self
        lichSuYeuCauTableView.dataSource = self
        lichSuYeuCauTableView.showsVerticalScrollIndicator = false
    }
    
}

extension LichSuYeuCauVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = lichSuYeuCauTableView.dequeueReusableCell(withIdentifier: "lichSuYeuCauCell", for: indexPath) as? YeuCauCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell?.configure(tenPH: "Nguyễn Huy Hoàng", tenTre: "Nguyễn Huy Hoang1", "Nguyễn Huy Hoang2", ngayDat: dateFormatter.string(from: Date()))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = xoa()
        let khoiPhuc = getBack()
        return UISwipeActionsConfiguration(actions: [delete, khoiPhuc])
    }
    
    func xoa() -> UIContextualAction {
        let xoa = UIContextualAction(style: .destructive, title: "Xoá") { (action, view, completion) in
            print("Đã xoá")
            completion(true)
        }
        xoa.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
        return xoa
    }
    
    func getBack() -> UIContextualAction {
        let getBack = UIContextualAction(style: .normal, title: "Khôi phục") { (action, view, completion) in
            print("Đã hoàn lại")
            completion(true)
        }
        getBack.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        return getBack
    }
    
}
