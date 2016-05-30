//
//  RankingGenreViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/6.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import SVProgressHUD

class RankingGenreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    var superView = UIView()
    var sortType  = "All"
    var songs : [Song]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        superView            = self.view
        tableView            = UITableView(frame: self.view.frame)
        
        if sortType == "All" {
            Song.getAllSongRank( {result,error in
                if error == nil {
                self.songs = result
                print(self.songs?.count)
                self.delay(0, closure: {
                SVProgressHUD.dismissWithDelay(2)
                self.initMenu()
                })
                }
                else {
                print (error)
                }
                })
        }
        else {
            Song.getSongByTag(self.title!,completion: {result,error in
                if error == nil {
                    self.songs = result
                    print(self.songs?.count)
                    self.delay(0, closure: {
                        SVProgressHUD.dismissWithDelay(2)
                        self.initMenu()
                    })
                }
                else {
                    print (error)
                }
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        SVProgressHUD.show()
        SVProgressHUD.showWithStatus("Updating")
        SVProgressHUD.setDefaultMaskType(.Gradient)
        Song.getSongByTag(self.title!,completion: {result,error in
            if error == nil {
                self.songs = result
                print(self.songs?.count)
                self.delay(0, closure: {
                    self.initMenu()
                })
            }
            else {
                print (error)
            }
        })
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

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc =  (UIStoryboard(name: "PlayView", bundle: nil).instantiateViewControllerWithIdentifier("musicVC")) as! PlayViewController
      //  vc.setVCData("music_list", type: ".json",chooseIndex:0)
        vc.configureVC(songs!,chooesIndex: indexPath.row)
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }

}
