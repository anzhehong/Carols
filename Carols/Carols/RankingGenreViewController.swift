//
//  RankingGenreViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/6.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import PKHUD

class RankingGenreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    var superView = UIView()
    var sortType  = "All"
    var songs : [Song]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HUD.show(.LabeledProgress(title: "加载中", subtitle: "⌛️...⌛️"))
        superView            = self.view
        tableView            = UITableView(frame: self.view.frame)
        if sortType == "All" {
            Song.getAllSongRank( {result,error in
                HUD.hide(animated: true)
                if error == nil {
                    self.songs = result
                    self.delay(0, closure: {
                    self.initMenu()
                    HUD.flash(.Success, delay: 1.0)
                })
                }
                else {
                    HUD.flash(.LabeledError(title: nil, subtitle: "网络错误，请检查您的Wi-Fi设置"), delay: 1.0)
                }
            })
        }
        else if sortType == "Rock" {
            Song.getRockRank( {result,error in
                HUD.hide(animated: true)
                if error == nil {
                    self.songs = result
                    print(self.songs?.count)
                    HUD.flash(.Success, delay: 1.0)
                    self.delay(0, closure: {
                        self.initMenu()
                    })
                }
                else {
                    HUD.flash(.LabeledError(title: nil, subtitle: "网络错误，请检查您的Wi-Fi设置"), delay: 1.0)
                }
            })
        }
        else if sortType == "Pop" {
            Song.getPopRank( {result,error in
                HUD.hide(animated: true)
                if error == nil {
                    self.songs = result
                    HUD.flash(.Success, delay: 1.0)
                    print(self.songs?.count)
                    self.delay(0, closure: {
                        self.initMenu()
                    })
                }
                else {
                    HUD.flash(.LabeledError(title: nil, subtitle: "网络错误，请检查您的Wi-Fi设置"), delay: 1.0)
                }
            })

        }
        else {
            Song.getJazzRank( {result,error in
                HUD.hide(animated: true)
                if error == nil {
                    HUD.flash(.Success, delay: 1.0)
                    self.songs = result
                    print(self.songs?.count)
                    self.delay(0, closure: {
                        self.initMenu()
                    })
                }
                else {
                    HUD.flash(.LabeledError(title: nil, subtitle: "网络错误，请检查您的Wi-Fi设置"), delay: 1.0)
                }
            })
        }
    }
    
    func initMenu() {
        tableView.dataSource = self
        tableView.delegate   = self
        superView.addSubview(tableView)
    }

}

//MARK: - UITableViewDatasource
extension RankingGenreViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (songs?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SongLibraryCell(style: .Default, reuseIdentifier: "songLibraryCell", songName: "Ordinary", singerName: "Copeland", albumPic: UIImage(named: "AlbumPic_4")!)
        cell.singerName.text = songs![indexPath.row].SongArtist
        cell.songName.text = songs![indexPath.row].SongName
        cell.album.sd_setImageWithURL(NSURL(string: songs![indexPath.row].SongImage!), placeholderImage: UIImage(named: "AlbumPic_4")!)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc =  PlayViewController.sharedInstance
        vc.configureVC(songs!,chooesIndex: indexPath.row)
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }

}
