//
//  DinhGiaThucDonVC.swift
//  ChildKid
//
//  Created by SANG on 5/13/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit
import SWRevealViewController

class DinhGiaThucDonVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
    }
}
