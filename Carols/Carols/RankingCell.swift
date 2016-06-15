//
//  RankingCell.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/6.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class RankingCell: UITableViewCell {

    //TODO: 确定是64吗？
    static let cellHeight = 64
    let albumWidth        = 50

    var album             = UIImageView()
    let songName          = UILabel()
    let singerName        = UILabel()
    let singButton        = UIButton()
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,
         songName: String, singerName: String, albumPic: UIImage) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.album           = UIImageView(frame: CGRect(origin: self.frame.origin, size: CGSizeMake(CGFloat(albumWidth), CGFloat(albumWidth))))
        self.album.image     = albumPic
        self.songName.text   = songName
        self.singerName.text = singerName
        
        configureUI()
    }
    
    func configureUI() {
        self.addSubview(album)
        album.layer.cornerRadius = 10
        album.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(11)
            make.centerY.equalTo(self)
            make.width.equalTo(albumWidth)
            make.height.equalTo(albumWidth)
        }

        self.addSubview(songName)
        songName.textColor = UIColor.UIColorFromRGB(0xFFFFFF)
        songName.font      = UIFont.systemFontOfSize(20)
        songName.snp_makeConstraints { (make) in
            make.left.equalTo(album.snp_right).offset(20)
            make.top.equalTo(self).offset(8)
        }
        
        self.addSubview(singerName)
        singerName.textColor = UIColor.UIColorFromRGB(0xA49EA1)
        singerName.font      = UIFont.systemFontOfSize(18)
        singerName.snp_makeConstraints { (make) in
            make.left.equalTo(songName)
            make.top.equalTo(songName.snp_bottom).offset(3)
        }
        
        singButton.setImage(UIImage(named: "SingIcon"), forState: .Normal)
        self.addSubview(singButton)
        singButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-18)
        }
        
        self.backgroundColor = UIColor ( red: 0.1529, green: 0.1373, blue: 0.1451, alpha: 1.0 )
        self.selectionStyle  = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
