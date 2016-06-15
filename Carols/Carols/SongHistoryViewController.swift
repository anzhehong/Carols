//
//  SongHistoryViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/4.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import PageMenu

class SongHistoryViewController: BaseViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        historyButton.setImage(UIImage(named: "Search Icon"), forState: .Normal)
        initMenu()
    }
    
    func initMenu() {
        
        let vc   = SongHistoryViewContainerController()
        vc.title = "Song History"
        controllerArray.append(vc)
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, CGFloat( titleHeight), self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
    
    override func searchGroup(){
        let vc =  (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("serachVC")) as! SearchTableViewController
        vc.title = "歌曲名"
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }
}
