//
//  SongHistoryViewContainerController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/5.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class SongHistoryViewContainerController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView = UITableView()
    var superView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }

    func initTableView() {
        superView = self.view
        tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        superView.addSubview(tableView)
        tableView.backgroundColor = UIColor ( red: 0.1529, green: 0.1373, blue: 0.1451, alpha: 1.0 )
        tableView.separatorColor = UIColor.blackColor()

    }
}

//MARK: - UITableViewDatasource
extension SongHistoryViewContainerController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = HistoryCell(style: .Default, reuseIdentifier: "chosenSongCell", songName: "White Turns Blue", singerName: "Copeland")
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(SongLibraryCell.cellHeight)
    }

}