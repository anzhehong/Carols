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
        nameLabel.text = "Ranking List"
        historyButton.setImage(UIImage(named: "Search Icon"), forState: .Normal)
        initMenu()
    }
    
    func initMenu() {
        let vc = RankingViewContainerController()
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
    }
}
