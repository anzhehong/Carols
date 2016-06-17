//
//  ViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/1.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import SnapKit
import PageMenu

class MainViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenu()
    }
    
    //MARK: - CAPSPageMenuDelegate
    func initMenu() {
        let songLibraryVC          = SongLibraryViewController()
        songLibraryVC.title        = "曲库"
        controllerArray.append(songLibraryVC)
        let chosenSongsLibraryVC   = ChosenSongsLibraryViewContainerController()
        chosenSongsLibraryVC.title = "待唱列表"
        controllerArray.append(chosenSongsLibraryVC)
        
        pageMenu           = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, CGFloat( titleHeight), self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }

}

