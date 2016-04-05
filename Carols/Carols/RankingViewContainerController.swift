//
//  RankingViewContainerController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/6.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import PageMenu

class RankingViewContainerController: UIViewController, CAPSPageMenuDelegate {

    
    let album = UIImageView()
    let albumHeight = 170
    var superView = UIView()
    let tablewView = UITableView()
    
    //MARK: - Page Menu
    //MARK: Controller Array
    var controllerArray : [UIViewController] = []
    let menuHeight = 59
    let titleHeight = 64
    var pageMenu : CAPSPageMenu?
    var parameters: [CAPSPageMenuOption]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        superView = self.view
        initAlbum()
        // Do any additional setup after loading the view.
        
        
        initPageParams()
        let all = RankingGenreViewController()
        all.title = "All"
        controllerArray.append(all)
        
        let pop = RankingGenreViewController()
        pop.title = "Pop"
        pop.sortType = "Pop"
        controllerArray.append(pop)
        
        let jazz = RankingGenreViewController()
        jazz.sortType = "Jazz"
        jazz.title = "Jazz"
        controllerArray.append(jazz)
        
        let rb = RankingGenreViewController()
        rb.sortType = "R&B"
        rb.title = "R&B"
        controllerArray.append(rb)
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, CGFloat(albumHeight + titleHeight), self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initAlbum()  {
        album.image = UIImage(named: "AlbumLarge")
        superView.addSubview(album)
        album.snp_makeConstraints { (make) in
            make.height.equalTo(albumHeight)
            make.top.equalTo(titleHeight)
            make.left.right.equalTo(superView)
        }
    }
    
    //MARK: - UI
    func initPageParams() {
        parameters = [
            .MenuHeight(CGFloat(menuHeight)),
            .MenuItemSeparatorWidth(0),
            .MenuItemFont(UIFont.boldSystemFontOfSize(20)),
            .SelectedMenuItemLabelColor(UIColor.UIColorFromRGB(0xFC2E55)),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1),
            .SelectionIndicatorColor(UIColor.GlobalRed()),
            .ScrollMenuBackgroundColor(UIColor.GlobalMenuBlack()),
            .ViewBackgroundColor(UIColor.GlobalMenuBlack()),
            .UnselectedMenuItemLabelColor(UIColor.whiteColor()),
            .BottomMenuHairlineColor(UIColor.GlobalMenuBlack()),
        ]
    }


    func initTableView() {
        
    }
}
