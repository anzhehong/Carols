//
//  RankingViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/6.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import PageMenu

class RankingViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "排行榜💡"
        initMenu()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initMenu() {
        let vc = RankingViewContainerController()
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
    }
}
