//
//  SearchTableView.swift
//  Carols
//
//  Created by  Harold LIU on 6/15/16.
//  Copyright © 2016 TAC. All rights reserved.
//

import UIKit
import Alamofire

class SearchTableViewController: UITableViewController,UISearchBarDelegate{

    //Params
    @IBOutlet weak var searchBar: UISearchBar!
    var searchResults: [Song]?
    //MARK:- Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundView = UIImageView(image: UIImage(named: "loginBack"))
        navigationController?.navigationBar.barTintColor = UIColor.GlobalMenuBlack()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.GlobalRed()]
    }
    
    //MARK:- Data Source & Delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard searchResults != nil else {
            return 0
        }
        return (searchResults?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let searchCell = SongLibraryCell(style: .Default, reuseIdentifier: "searchCell", songName: "Ordinary", singerName: "Copeland", albumPic: UIImage(named: "AlbumPic_3")!)
        let URL = NSURL(string: searchResults![indexPath.row].SongImage!)
        searchCell.singerName.text = self.searchResults![indexPath.row].SongArtist
        searchCell.songName.text = self.searchResults![indexPath.row].SongName
        searchCell.album.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "AlbumPic_3"))
        return searchCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc =  PlayViewController.sharedInstance
        vc.configureVC(searchResults!,chooesIndex: indexPath.row)
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }
    
    //MARK:- Search Bar Delegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if title == "歌手" {
            searchResults = nil
            Song.getSongsByStarName(searchBar.text!, completion: { (songs, error) in
                if error == nil {
                self.searchResults = songs
                self.delay(0, closure: {
                    self.tableView.reloadData()
                    self.searchBar.resignFirstResponder()
                })
                } else {
                    //display error
                    return
                }
                
            })
            
        } else if title == "歌曲名" {
            Song.getSongBySongName(searchBar.text!, completion: { (songs, error) in
                if error == nil {
                    self.searchResults = songs
                    self.delay(0, closure: {
                        self.tableView.reloadData()
                        self.searchBar.resignFirstResponder()
                    })
                } else {
                    //display error
                    return
                }
            })
            
        } else {
            Song.getSongByTag(searchBar.text!, completion: { (songs, error) in
                if error == nil {
                    self.searchResults = songs
                    self.delay(0, closure: {
                        self.tableView.reloadData()
                        self.searchBar.resignFirstResponder()
                    })
                } else {
                    //display error
                    return
                }

            })
        }
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
    }
    
    //MARK:- Action
    @IBAction func refresh(sender: UIBarButtonItem) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchResults = nil
        self.tableView.reloadData()
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
