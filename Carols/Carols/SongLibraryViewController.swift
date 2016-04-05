//
//  SongLibraryViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/2.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class SongLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let album = UIImageView()
    
    //MARK: - Three Buttons
    let startButton = UIButton()
    let groupButton = UIButton()
    let nameButton = UIButton()
    
    var superView = UIView()
    
    let containerView = UIView()
    
    let recommendationContainer = UIView()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        superView = self.view
        
        initAlbum()
        initThreeButton()
        initTableView()
    }
    
    func initAlbum()  {
        album.image = UIImage(named: "AlbumLarge")
        superView.addSubview(album)
        album.snp_makeConstraints { (make) in
            make.height.equalTo(170)
            //MainViewController.titleHeightS + MainViewController.menuHeight
            make.top.equalTo(0)
            make.left.right.equalTo(superView)
        }
    }
    
    //MARK: init three button
    func initThreeButton() {
        
        containerView.backgroundColor = UIColor ( red: 0.102, green: 0.0902, blue: 0.0941, alpha: 1.0 )
        superView.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.right.left.equalTo(superView)
            make.top.equalTo(album.snp_bottom)
            make.height.equalTo(106)
        }
        
        let line1 = UIView()
        line1.backgroundColor = UIColor ( red: 0.2275, green: 0.2275, blue: 0.2275, alpha: 1.0 )
        superView.addSubview(line1)
        line1.snp_makeConstraints { (make) in
            make.left.right.equalTo(superView)
            make.height.equalTo(1)
            make.top.equalTo(containerView)
        }
        
        let line2 = UIView()
        line2.backgroundColor = UIColor ( red: 0.2275, green: 0.2275, blue: 0.2275, alpha: 1.0 )
        superView.addSubview(line2)
        line2.snp_makeConstraints { (make) in
            make.left.right.equalTo(superView)
            make.height.equalTo(1)
            make.bottom.equalTo(containerView)
        }
        
        let chooseSongLabel = UILabel()
        chooseSongLabel.text = "Choose Song"
        chooseSongLabel.font = UIFont.systemFontOfSize(18)
        chooseSongLabel.textColor = UIColor.UIColorFromRGB(0xFFFFFF)
        containerView.addSubview(chooseSongLabel)
        chooseSongLabel.snp_makeConstraints { (make) in
            make.top.equalTo(containerView.snp_top).offset(5)
            make.left.equalTo(containerView).offset(20)
        }
        
        let redView = UIView()
        redView.backgroundColor = UIColor.redColor()
        superView.addSubview(redView)
        redView.snp_makeConstraints { (make) in
            make.height.equalTo(15)
            make.left.equalTo(10)
            make.width.equalTo(5)
            make.centerY.equalTo(chooseSongLabel)
        }
        
        groupButton.setImage(UIImage(named: "ByGroup Icon"), forState: .Normal)
        containerView.addSubview(groupButton)
        groupButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(containerView)
            make.centerY.equalTo(containerView).offset(10)
        }
        
        startButton.setImage(UIImage(named: "ByStars Icon"), forState: .Normal)
        containerView.addSubview(startButton)
        startButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(groupButton)
            make.right.equalTo(groupButton.snp_left).offset(-53)
        }
        
        nameButton.setImage(UIImage(named: "ByName Icon"), forState: .Normal)
        containerView.addSubview(nameButton)
        nameButton.snp_makeConstraints { (make) in
            make.left.equalTo(groupButton.snp_right).offset(53)
            make.centerY.equalTo(groupButton)
        }
    }
    
    func initTableView() {
        
        
        superView.addSubview(recommendationContainer)
        recommendationContainer.snp_makeConstraints { (make) in
            make.left.right.equalTo(superView)
            make.top.equalTo(containerView.snp_bottom)
            make.height.equalTo(36)
        }
        recommendationContainer.backgroundColor = UIColor ( red: 0.1569, green: 0.1333, blue: 0.1451, alpha: 1.0 )
        
        let recommendationLabel = UILabel()
        recommendationLabel.text = "Recommendation"
        recommendationLabel.font = UIFont.systemFontOfSize(18)
        recommendationLabel.textColor = UIColor.UIColorFromRGB(0xFFFFFF)
        recommendationContainer.addSubview(recommendationLabel)
        recommendationLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(recommendationContainer)
            make.left.equalTo(recommendationContainer).offset(20)
        }
        
        let redView = UIView()
        redView.backgroundColor = UIColor.redColor()
        recommendationContainer.addSubview(redView)
        redView.snp_makeConstraints { (make) in
            make.height.equalTo(15)
            make.left.equalTo(10)
            make.width.equalTo(5)
            make.centerY.equalTo(recommendationLabel)
        }

        let redArrow = UIImageView()
        redArrow.image = UIImage(named: "RightArrowIcon")
        recommendationContainer.addSubview(redArrow)
        redArrow.snp_makeConstraints { (make) in
            make.right.equalTo(recommendationContainer).offset(-20)
            make.centerY.equalTo(recommendationContainer)
        }
        
//        tableView.dataSource = self
//        tableView.delegate = self
//        superView.addSubview(tableView)
//        tableView.snp_makeConstraints { (make) in
//            make.left.right.bottom.equalTo(superView)
//            make.top.equalTo(recommendationContainer.snp_bottom)
//            make.bottom.equalTo(superView)
//        }
//        tableView.backgroundColor = UIColor ( red: 0.1529, green: 0.1373, blue: 0.1451, alpha: 1.0 )
//        tableView.separatorColor = UIColor.blackColor()
        
        let ttt = RecommendationViewContainerController.GetTableView()
        superView.addSubview(ttt)
        ttt.dataSource = self
        ttt.delegate = self
        ttt.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(superView)
            make.top.equalTo(recommendationContainer.snp_bottom)
            make.bottom.equalTo(superView)
        }
        
    }
    
    //MARK: - UITableViewDatasource 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SongLibraryCell(style: .Default, reuseIdentifier: "songLibraryCell", songName: "Ordinary", singerName: "Copeland", albumPic: UIImage(named: "AlbumPic_4")!)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(SongLibraryCell.cellHeight)
    }
    
}

