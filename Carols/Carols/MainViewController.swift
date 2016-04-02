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
    
    
    //MARK: - Title
    let titleHeight = 52
    var userName = "Harold"
    var superView = UIView()
    let nameLabel = UILabel()
    
    //MARK: - Side Menu
    let sideButton = UIButton()
    let historyButton = UIButton()
    
    //MARK: - Page Menu
    //MARK: Controller Array
    var controllerArray : [UIViewController] = []
    var pageMenu : CAPSPageMenu?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        superView = self.view
        initTitle()
        initMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UI
    func initTitle() {
        
        nameLabel.text = "Hello,\(userName)"
        nameLabel.textColor = UIColor.GlobalRed()
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 18)!
        superView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(superView)
            make.centerY.equalTo(superView.snp_top).offset(titleHeight/2)
        }
        
        sideButton.setImage(UIImage(named: "Left View Button"), forState: .Normal)
        superView.addSubview(sideButton)
        sideButton.addTarget(self, action: #selector(MainViewController.leftSideButtonClicked), forControlEvents: .TouchUpInside)
        sideButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(superView.snp_top).offset(titleHeight/2)
            make.left.equalTo(15)
            make.height.width.equalTo(titleHeight/2)
        }
        
//        historyButton.setImage(UIImage(named: ), forState: <#T##UIControlState#>)
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
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, CGFloat( titleHeight), self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
    
    //MARK: - Actions
    func leftSideButtonClicked()  {
        self.slideMenuController()?.openLeft()
    }
    
    //CASPageMenu Delegate
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

