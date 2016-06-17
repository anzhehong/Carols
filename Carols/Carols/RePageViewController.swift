//
//  RePageViewController.swift
//  Carols
//
//  Created by  Harold LIU on 6/17/16.
//  Copyright © 2016 TAC. All rights reserved.
//

import UIKit
import PageMenu
 

class RePageViewController: UIViewController,CAPSPageMenuDelegate {
    
    //MARK: - Page Menu
    var controllerArray : [UIViewController] = []
    var pageMenu : CAPSPageMenu?
    var parameters: [CAPSPageMenuOption]?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initPageParams()
        initMenu()
    }
    
    
    func initPageParams() {
        parameters = [
            .MenuHeight(CGFloat(38)),
            .MenuItemSeparatorWidth(0),
            .MenuItemFont(UIFont.systemFontOfSize(20)),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1),
            .SelectionIndicatorColor(UIColor.GlobalRed()),
            .ScrollMenuBackgroundColor(UIColor.GlobalMenuBlack()),
            .ViewBackgroundColor(UIColor.GlobalMenuBlack()),
            .SelectedMenuItemLabelColor(UIColor.whiteColor()),
            .UnselectedMenuItemLabelColor(UIColor.whiteColor()),
            .BottomMenuHairlineColor(UIColor.GlobalMenuBlack()),
        ]
    }
    
    func initMenu() {
        let songLibraryVC   = SongLibraryViewController()
        songLibraryVC.title = "Carols猜你喜欢😍"
        controllerArray.append(songLibraryVC)
        let chosenSongsLibraryVC  = ChosenSongsLibraryViewContainerController()
        chosenSongsLibraryVC.title = "待唱列表🎙"
        controllerArray.append(chosenSongsLibraryVC)
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, CGFloat(64), self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
    
}
