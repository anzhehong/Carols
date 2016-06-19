//
//  ChosenSongsLibraryViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/2.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import PKHUD

class ChosenSongsLibraryViewContainerController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView = UITableView()
    var songs:[Song]?
    override func viewDidLoad() {
        super.viewDidLoad()
        HUD.show(.LabeledProgress(title: "加载中", subtitle: "⌛️...⌛️"))
        tableView = UITableView(frame: self.view.frame)
        Song.getHistory((User.currentUser().id?.stringValue)!, completion: {result,error in
            HUD.hide(animated: true)
            if error == nil {
                self.songs = result
                HUD.flash(.Success, delay: 1.0)
                self.delay(0, closure: {
                    self.initTableView()
                })
            }
            else {
               HUD.flash(.LabeledError(title: nil, subtitle: "网络错误"), delay: 1.0)
            }
        })

    }
    
    func initTableView() {
        tableView.backgroundColor = UIColor ( red: 0.1529, green: 0.1373, blue: 0.1451, alpha: 1.0 )
        tableView.separatorColor = UIColor.blackColor()
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func GetTableView() -> UITableView {
        let vc = ChosenSongsLibraryViewContainerController()
        vc.viewDidLoad()
        return vc.tableView
    }
    
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ChosenSongsLibraryViewContainerController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (songs?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ChosenSongCell(style: .Default, reuseIdentifier: "chosenSongCell", songName: "White Turns Blue", singerName: "Copeland")
        if indexPath.row == 0 {
            cell.actionImage.setImage(UIImage(named: "Play Icon"), forState: .Normal)
        }
        cell.singerNameLabel.text = songs![indexPath.row].SongArtist
        cell.songNameLabel.text = songs![indexPath.row].SongName
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(ChosenSongCell.cellHeight)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc =  PlayViewController.sharedInstance
        vc.configureVC(songs!,chooesIndex: indexPath.row)
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }

}