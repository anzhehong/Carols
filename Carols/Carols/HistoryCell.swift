//
//  HistoryCell.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/5.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    static let cellHeight = 64

    let songNameLabel     = UILabel()
    let singerNameLabel   = UILabel()
    let actionImage       = UIButton()
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,
         songName: String, singerName: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        songNameLabel.textColor   = UIColor.whiteColor()
        songNameLabel.text        = songName
        songNameLabel.font        = UIFont.systemFontOfSize(20)
        singerNameLabel.text      = singerName
        singerNameLabel.textColor = UIColor ( red: 0.5608, green: 0.5373, blue: 0.5451, alpha: 1.0 )
        singerNameLabel.font      = UIFont.systemFontOfSize(16)
        
        actionImage.setImage(UIImage(named: "SingIcon"), forState: .Normal)
        self.addSubview(actionImage)
        actionImage.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-18)
            make.height.equalTo(21)
            make.width.equalTo(46)
            make.centerY.equalTo(self)
        }
        
        self.addSubview(songNameLabel)
        songNameLabel.adjustsFontSizeToFitWidth = true
        songNameLabel.minimumScaleFactor = 0.4
        songNameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(25)
            make.right.lessThanOrEqualTo(actionImage.snp_left).offset(-5)
        }
        
        self.addSubview(singerNameLabel)
        singerNameLabel.adjustsFontSizeToFitWidth = true
        singerNameLabel.minimumScaleFactor = 0.4
        singerNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(songNameLabel)
            make.top.equalTo(songNameLabel.snp_bottom).offset(3)
            make.right.lessThanOrEqualTo(actionImage.snp_left).offset(-5)
        }
        
        self.backgroundColor = UIColor ( red: 0.1529, green: 0.1373, blue: 0.1451, alpha: 1.0 )
        self.selectionStyle  = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }}
