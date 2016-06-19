//
//  SongHistoryViewContainerController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/5.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import PKHUD

class SongHistoryViewContainerController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView = UITableView()
    var superView = UIView()
    var songs : [Song]?
    override func viewDidLoad() {
        super.viewDidLoad()
        superView = self.view
        tableView = UITableView(frame: self.view.frame)
        HUD.show(.LabeledProgress(title: "加载中", subtitle: "⌛️...⌛️"))
        Song.getHistory((User.currentUser().id?.stringValue)!, completion: {result,error in
            if error == nil {
                self.songs = result
                print(self.songs?.count)
                self.delay(0, closure: {
                    HUD.hide(animated: true)
                    HUD.flash(.Success, delay: 1.0)
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
        return (songs?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = HistoryCell(style: .Default, reuseIdentifier: "chosenSongCell", songName: "White Turns Blue", singerName: "Copeland")
        cell.songNameLabel.text = songs![indexPath.row].SongName
        cell.songNameLabel.text = songs![indexPath.row].SongArtist
        
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