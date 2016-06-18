//
//  testViewController.swift
//  Carols
//
//  Created by  Harold LIU on 6/17/16.
//  Copyright © 2016 TAC. All rights reserved.
//

import UIKit
import Alamofire
import CustomIOSAlertView

class testViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    let alert = CustomIOSAlertView()
    var recommendResult:[Song]?
    
    var path:NSURL? = nil
    
    @IBAction func Alert() {
        downloadLRC("http://o8z31on6v.bkt.clouddn.com/hello.lrc") { (path, error) in
            let pathURL = (path! as NSString).substringFromIndex(7)
            print(pathURL)
           // let pathURL = "/Users/Harold_LIU/Downloads/1.lrc"
            let url = NSURL(string: pathURL)
            let str = try! String(contentsOfFile: pathURL, encoding: NSUTF8StringEncoding)
            print(str)
        }
    
    }
    
    func downloadLRC(url:String,completion:((String?,NSError?)-> Void)) {
        let destination = Alamofire.Request.suggestedDownloadDestination(
            directory: .DocumentDirectory,
            domain: .UserDomainMask
        )
        Alamofire.download(.GET, url, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                print(totalBytesRead)
            }
            .response { request, response, _, error in
                print("fileURL: \(destination(NSURL(string: "")!, response!))")
                let path = "\(destination(NSURL(string: "")!, response!))"
                completion(path,error)
        }
    }
    
    //MARK:- Download Music
    func download (url:String,completion:((EZAudioFile?,NSError?)-> Void)) {
        let destination = Alamofire.Request.suggestedDownloadDestination(
            directory: .DocumentDirectory,
            domain: .UserDomainMask
        )
        
        Alamofire.download(.GET, url, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                print(totalBytesRead)
            }
            .response { request, response, _, error in
                print(response)
                print("fileURL: \(destination(NSURL(string: "")!, response!))")
                self.path = NSURL(string:  "\(destination(NSURL(string: "")!, response!))")
                let file = EZAudioFile(URL:self.path)
                if file != nil {
                    completion(file,nil)
                } else {
                    completion(nil,error)
                }
        }
    }
    
    func getData () {
        
        
//        let pathLRC = NSBundle.mainBundle().pathForResource("梁静茹-偶阵雨", ofType: "lrc")
//        let mo = DoModel.initSingleModel()
//        let dic: NSDictionary = mo.LRCWithName(pathLRC)
//        LRCDictionary = NSMutableDictionary(dictionary: (dic.objectForKey("LRCDictionary") as! NSDictionary))
//        timeArray = NSMutableArray(array: dic["timeArray"] as! NSArray)
        view.backgroundColor = UIColor(patternImage: UIImage(data: NSData(contentsOfURL: path!)!)!)
        view.setNeedsDisplay()
    }
    
    //MARK:- Alert
    func alerttest() {
        Song.getRecommendation("1", completion: {result,error in
            if error == nil {
                self.recommendResult = result
                self.delay(0, closure: {
                    self.alert.backgroundColor = UIColor.GlobalMenuBlack()
                    self.alert.containerView = UIView(frame:  CGRectMake(0, 0, self.view.bounds.width - 60 , 450))
                    self.configureButton()
                    self.alert.containerView.addSubview(self.initScoreView())
                    self.alert.containerView.addSubview(self.initRecommendationTitle())
                    self.alert.containerView.addSubview(self.initTableView())
                    self.alert.show()
                })
            }
            else {
                print ("error")
            }
        })

    }
    
    
    //MARK:- Random Score
    func score() -> Double {
        var basic = 80.00
        basic += Double(arc4random()%20)
        return basic
    }
    
    //MARK:- Init View & UI
    func initScoreView () -> UILabel {
        let scoreLabel = UILabel(frame:  CGRectMake(0,0,view.bounds.width - 60,60))
        let mark = score()
        if mark >= 90 {
             scoreLabel.text = "本次得分为\(mark)分!太棒了，简直是专业歌手😍"
        } else {
             scoreLabel.text = "本次得分为\(mark)分！音准不错，再接再厉!😊"
        }
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.textAlignment = .Center
        scoreLabel.textColor = UIColor.GlobalRed()
        scoreLabel.backgroundColor = UIColor( red: 0.1569, green: 0.1333, blue: 0.1451, alpha: 1.0 )
        scoreLabel.layer.cornerRadius = 8
        scoreLabel.clipsToBounds = true
        return scoreLabel
    }
    
    func initRecommendationTitle () -> UILabel {
        let titleLabel = UILabel(frame:  CGRectMake(0,55,view.bounds.width - 60,60))
        titleLabel.text = "🎤Carols猜您还喜欢如下歌曲:"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.backgroundColor = UIColor(red: 0.1569, green: 0.1333, blue: 0.1451, alpha: 1.0 )
        return titleLabel
    }
    
    func initTableView() -> UITableView {
        let tableView = UITableView()
        tableView.frame = CGRectMake(0, 115, view.bounds.width - 60 , 340)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor( red: 0.1569, green: 0.1333, blue: 0.1451, alpha: 1.0 )
        return tableView
    }
    
    func configureButton() {
        alert.buttonTitles[0] = "不用了，我接着唱"
    }
    
    //MARK:- TableView DataSource & Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard recommendResult != nil else {
            return 0
        }
        return (recommendResult?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SongLibraryCell(style: .Default, reuseIdentifier: "songLibraryCell", songName: "Ordinary", singerName: "Copeland", albumPic: UIImage(named: "AlbumPic_4")!)
        let url = recommendResult![indexPath.row].SongImage
        cell.album.sd_setImageWithURL(NSURL(string: url!), placeholderImage: UIImage(named: "AlbumPic_3")!)
        cell.songName.text = recommendResult![indexPath.row].SongName
        cell.singerName.text = recommendResult![indexPath.row].SongArtist
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        alert.close()
        let vc =  PlayViewController.sharedInstance
        vc.configureVC(recommendResult!,chooesIndex: indexPath.row)
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }

}
