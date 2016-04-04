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
        chooseSongLabel.font = UIFont.italicSystemFontOfSize(18)
        chooseSongLabel.textColor = UIColor.whiteColor()
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
        recommendationLabel.font = UIFont.italicSystemFontOfSize(18)
        recommendationLabel.textColor = UIColor.whiteColor()
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
        redArrow.image = UIImage(named: "arrow")
        recommendationContainer.addSubview(redArrow)
        redArrow.snp_makeConstraints { (make) in
            make.right.equalTo(recommendationContainer).offset(-20)
            make.centerY.equalTo(recommendationContainer)
            make.height.width.equalTo(25)
        }
        
        tableView.dataSource = self
        superView.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(superView)
            make.top.equalTo(recommendationContainer.snp_bottom)
            make.bottom.equalTo(superView)
        }
        tableView.backgroundColor = UIColor ( red: 0.1529, green: 0.1373, blue: 0.1451, alpha: 1.0 )
        tableView.separatorColor = UIColor.blackColor()
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

class SongLibraryCell: UITableViewCell {
    
    //TODO: 确定是64吗？
    static let cellHeight = 80
    let albumWidth = 50
    
    let album = UIImageView()
    let songName = UILabel()
    let singerName = UILabel()
    let singButton = UIButton()
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,
         songName: String, singerName: String, albumPic: UIImage) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.album.image = albumPic
        self.songName.text = songName
        self.singerName.text = singerName
        
        configureUI()
    }
    
    func configureUI() {
        self.addSubview(album)
        album.snp_makeConstraints { (make) in
            make.height.width.equalTo(albumWidth)
            make.left.equalTo(self).offset(11)
            make.centerY.equalTo(self)
        }
        
        self.addSubview(songName)
        songName.textColor = UIColor.whiteColor()
        songName.font = UIFont.systemFontOfSize(20)
        songName.snp_makeConstraints { (make) in
            make.left.equalTo(album.snp_right).offset(20)
            make.top.equalTo(album).offset(3)
        }
        
        self.addSubview(singerName)
        singerName.textColor = UIColor.whiteColor()
        singerName.font = UIFont.italicSystemFontOfSize(15)
        singerName.snp_makeConstraints { (make) in
            make.left.equalTo(songName)
            make.bottom.equalTo(album.snp_bottom).offset(-3)
        }
        
        singButton.setImage(UIImage(named: "SingIcon"), forState: .Normal)
        self.addSubview(singButton)
        singButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-18)
        }
        
        self.backgroundColor = UIColor ( red: 0.1529, green: 0.1373, blue: 0.1451, alpha: 1.0 )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}