//
//  YeuCauDatTiecVC.swift
//  ChildKid
//
//  Created by SANG on 5/12/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit

class YeuCauDatTiecVC: UIViewController {

    @IBOutlet weak var yeuCauTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        yeuCauTableView.delegate = self
        yeuCauTableView.dataSource = self
        yeuCauTableView.showsVerticalScrollIndicator = false
    }

}

extension YeuCauDatTiecVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = yeuCauTableView.dequeueReusableCell(withIdentifier: "yeuCauCell", for: indexPath) as? YeuCauCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell?.configure(tenPH: "Nguyễn Huy Hoàng", tenTre: "Nguyễn Huy Hoàng1", "Nguyễn Huy Hoàng", ngayDat: dateFormatter.string(from: Date()))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let chapNhan = approve()
        let tuChoi = disapprove()
        return UISwipeActionsConfiguration(actions: [tuChoi, chapNhan])
    }
    
    func approve() -> UIContextualAction {
        let approve = UIContextualAction(style: .normal, title: "Chấp nhận") { (action, view, completion) in
            print("Đã chấp nhận")
            completion(true)
        }
        approve.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        return approve
    }
    
    func disapprove() -> UIContextualAction {
        let disapprove = UIContextualAction(style: .destructive, title: "Từ chối") { (action, view, completion) in
            print("Đã từ chối")
            completion(true)
        }
        disapprove.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
        return disapprove
    }
}
