//
//  RecommendationViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/5.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import PageMenu

class RecommendationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initMenu()
    }

    func initMenu() {
        
        let vc   = RecommendationViewContainerController()
        vc.title = "Recommendation"
        controllerArray.append(vc)
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, CGFloat( titleHeight), self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }

}
