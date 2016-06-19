//
//  RecommendationViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/5.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import PKHUD

class RecommendationViewContainerController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    var superView = UIView()
    var songs:[Song]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HUD.show(.LabeledProgress(title: "加载中", subtitle: "⌛️...⌛️"))
        tableView.backgroundColor = UIColor.GlobalGray()
        Song.getRecommendation((User.currentUser().id?.stringValue)!, completion: {result,error in
            if error == nil {
                HUD.hide(animated: true)
                HUD.flash(.Success, delay: 1.0)
                self.songs = result
                self.delay(0, closure: {
                    self.initTableView()
                })
            }
            else {
                HUD.hide(animated: true)
                HUD.flash(.LabeledError(title: nil, subtitle: "网络错误"), delay: 1.0)
            }
        })
    }
    
    func initTableView() {
        superView = self.view
        tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        superView.addSubview(tableView)
        tableView.backgroundColor = UIColor (red: 0.1529, green: 0.1373, blue: 0.1451, alpha: 1.0 )
        tableView.separatorColor = UIColor.blackColor()
    }

    class func GetTableView() -> UITableView {
        let vc = RecommendationViewContainerController()
        vc.viewDidLoad()
        return vc.tableView
    }
    
}

//MARK: - UITableViewDatasource
extension RecommendationViewContainerController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (songs?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SongLibraryCell(style: .Default, reuseIdentifier: "songLibraryCell", songName: "Ordinary", singerName: "Copeland", albumPic: UIImage(named: "AlbumPic_4")!)
        guard songs![indexPath.row].SongImage != nil else {
            cell.songName.text = songs![indexPath.row].SongName
            cell.singerName.text = songs![indexPath.row].SongArtist
            return cell
        }
        
        cell.songName.text = songs![indexPath.row].SongName
        cell.singerName.text = songs![indexPath.row].SongArtist
        cell.album.sd_setImageWithURL(NSURL(string:songs![indexPath.row].SongImage!), placeholderImage: UIImage(named: "AlbumPic_4")!)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(SongLibraryCell.cellHeight)
    }
    
    //MARK:- Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc =  PlayViewController.sharedInstance
        vc.configureVC(songs!,chooesIndex: indexPath.row)
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }

}