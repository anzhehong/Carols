//
//  LeftSideViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/2.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class LeftSideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "loginBack")!)
        
        let superView = self.view
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        let avator = UIImageView()
        avator.image = UIImage(named: "avator")
        superView.addSubview(avator)
        avator.snp_makeConstraints { (make) in
            make.height.width.equalTo(95)
            make.left.equalTo(superView).offset(45)
            make.top.equalTo(superView).offset(60)
        }
        avator.layer.cornerRadius = 95 / 2 // width /2
        avator.clipsToBounds = true
        
        
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.UIColorFromRGB(0xFC2E55)
        nameLabel.text = "Harold"
        nameLabel.font = UIFont.boldSystemFontOfSize(30)
        superView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(avator.snp_right).offset(25)
            make.centerY.equalTo(avator)
        }
        
        let tableView = UITableView()
        tableView.backgroundColor = UIColor .clearColor()
        superView.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.width.centerX.equalTo(superView)
//            make.top.equalTo(superView).offset(200)
            make.top.equalTo(avator.snp_bottom).offset(65)
//            make.bottom.equalTo(superView).offset(-50)
            make.bottom.equalTo(superView)
        }
        tableView.separatorStyle = .None
        tableView.scrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = (screenHeight - 250) / CGFloat(cellNames.count)


    }
    
    //MARK: - UITableView DataSource
    let cellNames: [String] = ["Home", "Ranking List", "Chosen Songs", "Playing", "History", "Logout"]
    
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
            slideMenuController.mainViewController = MainViewController()
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
        }
        
        self.presentViewController(slideMenuController, animated: false, completion: nil)
    }
    
    
}