//
//  ViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/1.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import SnapKit
import PageMenu

class MainViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenu()
    }
    
    //MARK: - CAPSPageMenuDelegate
    func initMenu() {
        
        //        self.view.backgroundColor = UIColor.GlobalMenuBlack()
        
        let songLibraryVC = SongLibraryViewController()
        songLibraryVC.title = "Song Library"
        controllerArray.append(songLibraryVC)
        let chosenSongsLibraryVC = ChosenSongsLibraryViewController()
        chosenSongsLibraryVC.title = "Chosen Songs"
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
        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }

}

