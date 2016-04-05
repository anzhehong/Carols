//
//  ChosenSongsLibraryViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/2.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class ChosenSongsLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.frame)
        tableView.backgroundColor = UIColor ( red: 0.1529, green: 0.1373, blue: 0.1451, alpha: 1.0 )
        tableView.separatorColor = UIColor.blackColor()
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ChosenSongCell(style: .Default, reuseIdentifier: "chosenSongCell", songName: "White Turns Blue", singerName: "Copeland")
        if indexPath.row == 0 {
            cell.actionImage.image = UIImage(named: "Play Icon")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(ChosenSongCell.cellHeight)
    }
}