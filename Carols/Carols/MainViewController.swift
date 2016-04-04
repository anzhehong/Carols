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
    let titleHeight = 44
    var userName = "Harold"
    var superView = UIView()
    let nameLabel = UILabel()
    
    //MARK: - Side Menu
    let menuHeight = 38
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
        initMenu()
        initTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UI
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func initTitle() {
        
        nameLabel.text = "Hello,\(userName)"
        nameLabel.textColor = UIColor ( red: 0.9843, green: 0.0549, blue: 0.2667, alpha: 1.0 )
        nameLabel.font = UIFont.systemFontOfSize(16.8)
        superView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(superView)
            make.centerY.equalTo(superView.snp_top).offset(titleHeight/2 + 4)
        }
        
        sideButton.setImage(UIImage(named: "Left View Button"), forState: .Normal)
        superView.addSubview(sideButton)
        sideButton.addTarget(self, action: #selector(MainViewController.leftSideButtonClicked), forControlEvents: .TouchUpInside)
        sideButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(superView.snp_left).offset(20)
            make.height.width.equalTo(24)
        }
        
        historyButton.setImage(UIImage(named: "History Icon"), forState: .Normal)
        superView.addSubview(historyButton)
        historyButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(superView.snp_right).offset(-20)
            make.height.width.equalTo(24)
        }
        
        let titleLine = UIView(frame: CGRect(x: 0, y: titleHeight, width: Int (self.view.frame.width), height: 1))
        titleLine.backgroundColor = UIColor ( red: 0.2275, green: 0.2275, blue: 0.2275, alpha: 1.0 )
        superView.addSubview(titleLine)
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

