//
//  RankingGenreViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/6.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class RankingGenreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    var superView = UIView()
    var sortType  = "All"

    override func viewDidLoad() {
        super.viewDidLoad()
        initMenu()
    }
    
    func initMenu() {
        superView            = self.view
        tableView            = UITableView(frame: self.view.frame)
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
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SongLibraryCell(style: .Default, reuseIdentifier: "songLibraryCell", songName: "Ordinary", singerName: "Copeland", albumPic: UIImage(named: "AlbumPic_4")!)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Test From Liu: \(indexPath.row)")
        let vc =  (UIStoryboard(name: "PlayView", bundle: nil).instantiateViewControllerWithIdentifier("musicVC")) as! PlayViewController
        vc.setVCData("music_list", type: ".json",chooseIndex:0)
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }

}
