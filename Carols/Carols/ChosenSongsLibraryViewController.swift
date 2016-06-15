//
//  ChosenSongsLibraryViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/5.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import PageMenu

class ChosenSongsLibraryViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initMenu()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - CAPSPageMenuDelegate
    func initMenu() {
        
        let vc = ChosenSongsLibraryViewContainerController()
        vc.title = "待唱列表🎤"
        controllerArray.append(vc)
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, CGFloat( titleHeight), self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
}
