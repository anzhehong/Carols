//
//  LeftSideViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/2.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import SDWebImage
import SVProgressHUD

class LeftSideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellNames: [String] = ["首页", "排行榜", "待唱列表", "猜你喜欢", "历史记录", "登出"]
    var tableView           = UITableView()
    
    
    //MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.rowHeight = (tableView.frame.size.height) / CGFloat(cellNames.count)
    }
    
    //MARK: - UI
    func configureUI() {
        let superView = self.view
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "loginBack")!)
        
        let avator   = UIImageView()
        avator.sd_setImageWithURL(NSURL(string: User.currentUser().avatorUrl!), placeholderImage: UIImage(named: "avator"))
        superView.addSubview(avator)
        avator.snp_makeConstraints { (make) in
            make.top.equalTo(superView).offset(69)
            make.height.width.equalTo(95)
            make.centerX.equalTo(superView.snp_centerX)
        }
        avator.layer.cornerRadius = 95 / 2 // width /2
        avator.clipsToBounds = true
        
        
        let nameLabel       = UILabel()
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.text      = User.currentUser().nickName!
        nameLabel.font      = UIFont.boldSystemFontOfSize(30)
        superView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(avator.snp_bottom).offset(10)
            make.centerX.equalTo(avator)
        }
        
        let logoutButton = UIButton()
        superView.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(LeftSideViewController.logout), forControlEvents: .TouchUpInside)
        logoutButton.setTitle("Logout", forState: .Normal)
        logoutButton.snp_makeConstraints { (make) in
            make.right.equalTo(superView).offset(-61)
            make.bottom.equalTo(superView).offset(-50)
            
        }
        
        let logoutImage = UIImageView(image: UIImage(named: "Logout Icon"))
        superView.addSubview(logoutImage)
        logoutImage.snp_makeConstraints { (make) in
            make.centerY.equalTo(logoutButton)
            make.right.equalTo(logoutButton.snp_left).offset(-7)
            make.height.equalTo(16)
            make.width.equalTo(18)
        }
        
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clearColor()
        superView.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.width.centerX.equalTo(superView)
            make.top.equalTo(nameLabel.snp_bottom).offset(60)
            make.bottom.equalTo(logoutButton.snp_top).offset(-64)
        }
        tableView.separatorStyle = .None
        tableView.scrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func logout() {
        AAUser.logout { (error) in
            if error == nil {
//                AppDelegate.sharedAppDelegate().window?.rootViewController?.presentViewController(LoginViewController(), animated: true, completion: nil)
                self.presentViewController(LoginViewController(), animated: true, completion: nil)
            }else {
                AAAlertViewController.getAlert("错误", message: error!.localizedDescription)
            }
        }
    }
}

//MARK: - UITableView DataSource & Delegate
extension LeftSideViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = LeftSideCell(style: .Default, reuseIdentifier: "leftSideCell", label: cellNames[indexPath.row])
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let mainViewController = SongHistoryViewController()
        let leftViewController = LeftSideViewController()
        let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
        slideMenuController.changeLeftViewWidth(screenWidth / 1.2)
        
        if indexPath.row == 0 {
            slideMenuController.mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mainVC")
        } else if indexPath.row == 1 {
            
            slideMenuController.mainViewController = RankingViewController()
        }
        else if indexPath.row == 2 {
            slideMenuController.mainViewController = ChosenSongsLibraryViewController()
        }
        else if indexPath.row == 3 {
            slideMenuController.mainViewController = RecommendationViewController()
        }
            
        else if indexPath.row == 4 {
            slideMenuController.mainViewController = SongHistoryViewController()
        }else if indexPath.row == 5 {
            logout()
        }
        
        self.presentViewController(slideMenuController, animated: false, completion: nil)
    }
}