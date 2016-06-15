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
     
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        historyButton.addTarget(self, action: #selector(RankingViewController.searchGroup), forControlEvents: .TouchUpInside)
        initMenu()
    }
    
    
    func initMenu() {
        let vc = RankingViewContainerController()
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
    }
    
    override func searchGroup(){
        let vc =  (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("serachVC")) as! SearchTableViewController
        vc.title = "类型搜索"
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }
}
