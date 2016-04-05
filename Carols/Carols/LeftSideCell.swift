//
//  LeftSideCell.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/5.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

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