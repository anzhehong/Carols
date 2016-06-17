//
//  testViewController.swift
//  Carols
//
//  Created by  Harold LIU on 6/17/16.
//  Copyright © 2016 TAC. All rights reserved.
//

import UIKit
import CustomIOSAlertView

class testViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    let alert = CustomIOSAlertView()
    
    @IBAction func Alert() {
        alert.backgroundColor = UIColor.GlobalMenuBlack()
        alert.containerView = UIView(frame:  CGRectMake(0, 0, view.bounds.width - 60 , 400))
        alert.containerView.addSubview(initScoreView())
        alert.containerView.addSubview(initTableView())
        alert.show()
    }
    
    func initScoreView () -> UILabel {
        let scoreLabel = UILabel(frame:  CGRectMake(0,0,view.bounds.width - 60,60))
        scoreLabel.text = "本次得分为85分！音准不错，再接再厉！"
        return scoreLabel
    }
    
    func initTableView() -> UITableView {
        let tableView = UITableView()
        tableView.frame = CGRectMake(0, 60, view.bounds.width - 60 , 340)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor( red: 0.1569, green: 0.1333, blue: 0.1451, alpha: 1.0 )
        return tableView
    }
    
    //MARK:- TableView DataSource & Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SongLibraryCell(style: .Default, reuseIdentifier: "songLibraryCell", songName: "Ordinary", singerName: "Copeland", albumPic: UIImage(named: "AlbumPic_4")!)
        return cell
    }

}
