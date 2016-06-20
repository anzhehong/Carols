//
//  SongLibraryViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/2.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import NAKPlaybackIndicatorView
import PKHUD
import SafariServices
import SDCycleScrollView

class SongLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,SFSafariViewControllerDelegate,SDCycleScrollViewDelegate {

    let album = UIButton()
    //MARK: - Three Buttons
    let startButton             = UIButton()
    let groupButton             = UIButton()
    let nameButton              = UIButton()
    var superView               = UIView()
    let containerView           = UIView()
    let recommendationContainer = UIView()
    var songs:[Song]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Load")
        HUD.show(.LabeledProgress(title: "正在个性化", subtitle: "您的推荐...⌛️"))
        superView = self.view
        startButton.addTarget(self, action: #selector(SongLibraryViewController.searchStar), forControlEvents: .TouchUpInside)
        groupButton.addTarget(self, action: #selector(SongLibraryViewController.searchGroup), forControlEvents: .TouchUpInside)
        nameButton.addTarget(self, action: #selector(SongLibraryViewController.searchName), forControlEvents: .TouchUpInside)
        Song.getRecommendation((User.currentUser().id?.stringValue)!, completion: {result,error in
            HUD.hide(animated: true)
            if error == nil {
                self.songs = result
                self.delay(0, closure: {
                    HUD.flash(.Success, delay: 1.0)
                    self.initAlbum()
                    self.initThreeButton()
                    self.initTableView()
                })
            }
            else {
                HUD.flash(.LabeledError(title: nil, subtitle: "网络错误"), delay: 1.0)
            }
        })
    }
    
    func initAlbum()  {
        let cycleScrollView = SDCycleScrollView(frame: album.frame, imageNamesGroup: [UIImage(imageLiteral:"billboard"),UIImage(imageLiteral:"uk"),UIImage(imageLiteral:"oricon"),UIImage(imageLiteral:"Mnet")])

        album.backgroundColor = UIColor.clearColor()
        album.addTarget(self, action: #selector(SongLibraryViewController.openXiami), forControlEvents: .TouchUpInside)
        superView.addSubview(cycleScrollView)
        superView.addSubview(album)
        cycleScrollView.snp_makeConstraints { (make) in
            make.height.equalTo(170)
            make.top.equalTo(0)
            make.left.right.equalTo(superView)
        }
        
        album.snp_makeConstraints { (make) in
            make.height.equalTo(170)
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
        chooseSongLabel.text = "搜索歌曲🔍"
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
        superView.backgroundColor = UIColor.GlobalGray()
        superView.addSubview(recommendationContainer)
        recommendationContainer.snp_makeConstraints { (make) in
            make.left.right.equalTo(superView)
            make.top.equalTo(containerView.snp_bottom)
            make.height.equalTo(36)
        }
        recommendationContainer.backgroundColor = UIColor ( red: 0.1569, green: 0.1333, blue: 0.1451, alpha: 1.0 )
        
        let recommendationLabel = UILabel()
        recommendationLabel.text = "Carols猜你喜欢😍"
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
        
        let tableView = RecommendationViewContainerController.GetTableView()
        superView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(superView)
            make.top.equalTo(recommendationContainer.snp_bottom)
            make.bottom.equalTo(superView)
        }
        
    }
 
    func initSearchView(title:String) {
         let vc =  (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("serachVC")) as! SearchTableViewController
         vc.title = title
         let nav = UINavigationController(rootViewController: vc)
         presentViewController(nav, animated: true, completion: nil)
    }
 
    //MARK:- Actions
    func searchName() {
        initSearchView("歌曲名")
    }
    
    func searchStar() {
        initSearchView("歌手")
    }
    
    func searchGroup() {
        initSearchView("风格")
    }
    
    func openXiami() {
        if #available(iOS 9.0, *) {
            let webVC = SFSafariViewController(URL: NSURL(string:"http://www.xiami.com/?spm=a1z1s.3521865.226669510.2.0PRZnw")!, entersReaderIfAvailable: true)
            webVC.delegate = self
            webVC.navigationItem.rightBarButtonItem?.title = "完成"
            self.presentViewController(webVC, animated: true, completion: nil)
        }
    }
    
}

extension SongLibraryViewController {
    //MARK: - UITableViewDatasource & Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard songs != nil else{
            return 0
        }
        return (songs?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SongLibraryCell(style: .Default, reuseIdentifier: "songLibraryCell", songName: "Ordinary", singerName: "Copeland", albumPic: UIImage(named: "AlbumPic_4")!)
        guard songs![indexPath.row].SongImage != nil else {
            cell.songName.text = songs![indexPath.row].SongName
            cell.singerName.text = songs![indexPath.row].SongArtist
            return cell
        }
        let url = NSURL(string:songs![indexPath.row].SongImage! )
        cell.album.sd_setImageWithURL(url, placeholderImage: UIImage(named: "AlbumPic_4")!)
        cell.songName.text = self.songs![indexPath.row].SongName
        cell.singerName.text = self.songs![indexPath.row].SongArtist
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(SongLibraryCell.cellHeight)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc =  PlayViewController.sharedInstance
        vc.configureVC(songs!,chooesIndex: indexPath.row)
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }

}