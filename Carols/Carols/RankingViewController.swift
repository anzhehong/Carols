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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - CAPSPageMenuDelegate
    func initMenu() {
        
//        let vc = RankingViewContainerController()
////        vc.title = "Ranking List"
//        controllerArray.append(vc)
//        
//        //TODO:  不像segment  .UseMenuLikeSegmentedControl(true),
//        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, CGFloat( titleHeight), self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
//        pageMenu!.delegate = self
////        self.addChildViewController(pageMenu!)
//        self.view.addSubview(pageMenu!.view)
        
        let vc = RankingViewContainerController()
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
    }
}
