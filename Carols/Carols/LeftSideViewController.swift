//
//  LeftSideViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/2.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class LeftSideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor ( red: 0.3059, green: 0.1843, blue: 0.2118, alpha: 1.0 )
        
        let superView = self.view
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        
        let tableView = UITableView()
        tableView.backgroundColor = UIColor ( red: 0.2392, green: 0.1333, blue: 0.1608, alpha: 1.0 )
        superView.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.width.centerX.equalTo(superView)
            make.top.equalTo(superView).offset(200)
            make.bottom.equalTo(superView).offset(-50)
        }
        tableView.separatorStyle = .None
        tableView.scrollEnabled = false
        tableView.dataSource = self
        tableView.rowHeight = (screenHeight - 250) / CGFloat(cellNames.count)
        
        let avator = UIImageView()
        avator.image = UIImage(named: "avator")
        superView.addSubview(avator)
        avator.snp_makeConstraints { (make) in
            make.height.width.equalTo(120)
            make.left.equalTo(superView).offset(35)
            make.top.equalTo(superView).offset(35)
        }
        avator.layer.cornerRadius = 60 // width /2
        avator.clipsToBounds = true
        
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.GlobalRed()
        nameLabel.text = "Harold"
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 25)
        superView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(avator.snp_right).offset(15)
            make.centerY.equalTo(avator)
        }

    }
    
    //MARK: - UITableView DataSource
    let cellNames: [String] = ["Home", "Ranking List", "Chosen Songs", "Playing", "History", "Logout"]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = LeftSideCell(style: .Default, reuseIdentifier: "leftSideCell", label: cellNames[indexPath.row])
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
}

class LeftSideCell: UITableViewCell {
    
    let classLabel = UILabel()
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, label: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor ( red: 0.3098, green: 0.1882, blue: 0.2157, alpha: 1.0 )
        classLabel.text = label
        classLabel.font = UIFont(name: "HelveticaNeue", size: 25)
        self.addSubview(classLabel)
        classLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(35)
            make.centerY.equalTo(self)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        if selected {
            classLabel.textColor = UIColor.GlobalRed()
        }else {
            classLabel.textColor = UIColor.whiteColor()
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}