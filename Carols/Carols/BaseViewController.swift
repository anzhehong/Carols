//
//  BaseViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/4.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import SnapKit
import PageMenu

class BaseViewController: UIViewController, CAPSPageMenuDelegate {
    
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
    
    //MARK: - ViewController Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        superView = self.view
        initTitle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UI
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
    
    //MARK: - Actions
    func leftSideButtonClicked()  {
        self.slideMenuController()?.openLeft()
    }
    
    // MARK: - Container View Controller
    override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
        return true
    }
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }

}
