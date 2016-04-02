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

class MainViewController: UIViewController, CAPSPageMenuDelegate {
    
    //MARK: - Page Menu
    //MARK: Controller Array
    var controllerArray : [UIViewController] = []
    var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - CAPSPageMenuDelegate
    func initMenu() {
        
        self.view.backgroundColor = UIColor.GlobalMenuBlack()
        
        let controller = LeftSideViewController()
        controller.view.backgroundColor = UIColor.purpleColor()
        controller.title = "SAMPLE TITLE"
        controllerArray.append(controller)
        let controller2 = LeftSideViewController()
        controller2.view.backgroundColor = UIColor.darkGrayColor()
        controller2.title = "2afaff"
        controllerArray.append(controller2)
        
        let parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(0),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1),
            .SelectionIndicatorColor(UIColor.GlobalRed()),
            .ScrollMenuBackgroundColor(UIColor.GlobalMenuBlack()),
            .ViewBackgroundColor(UIColor.GlobalMenuBlack()),
            .SelectedMenuItemLabelColor(UIColor ( red: 0.6627, green: 0.651, blue: 0.6549, alpha: 1.0 )),
            .UnselectedMenuItemLabelColor(UIColor ( red: 0.5725, green: 0.5608, blue: 0.5647, alpha: 1.0 )),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .BottomMenuHairlineColor(UIColor.GlobalMenuBlack()),
            
            ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 40, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
    
    func willMoveToPage(controller: UIViewController, index: Int) {
        print("aaaaa")
    }

    func didMoveToPage(controller: UIViewController, index: Int) {
        print("vvvv")
    }

    // MARK: - Container View Controller
    override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
        return true
    }
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }
}

