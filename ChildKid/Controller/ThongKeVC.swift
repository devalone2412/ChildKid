//
//  ThongKeVC.swift
//  ChildKid
//
//  Created by SANG on 5/14/19.
//  Copyright © 2019 Luc Thoi Sang. All rights reserved.
//

import UIKit
import SWRevealViewController

class ThongKeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
    }

}
