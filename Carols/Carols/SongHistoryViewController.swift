//
//  SongHistoryViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/4.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import SnapKit
import PageMenu

class SongHistoryViewController: UIViewController {

    var pageMenu : CAPSPageMenu?
    var controllerArray : [UIViewController] = []
    let menuHeight = 38
    let titleHeight = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - init menu
    func initMenu()  {
        let chosenSongsLibraryVC = ChosenSongsLibraryViewController()
        chosenSongsLibraryVC.title = "Songs History"
        controllerArray.append(chosenSongsLibraryVC)
        
        let parameters: [CAPSPageMenuOption] = [
            .MenuHeight(CGFloat(menuHeight)),
            .MenuItemSeparatorWidth(0),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1),
            .SelectionIndicatorColor(UIColor.GlobalRed()),
            .ScrollMenuBackgroundColor(UIColor.GlobalMenuBlack()),
            .ViewBackgroundColor(UIColor.GlobalMenuBlack()),
            .SelectedMenuItemLabelColor(UIColor.whiteColor()),
            .UnselectedMenuItemLabelColor(UIColor.whiteColor()),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 14.5)!),
            .BottomMenuHairlineColor(UIColor.GlobalMenuBlack()),
            ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, CGFloat( titleHeight), self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
//        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
    
    // MARK: - Container View Controller
    override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
        return true
    }
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }
    
}
