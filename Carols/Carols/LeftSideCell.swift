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
        self.backgroundColor = UIColor.clearColor()
        classLabel.text = label
        classLabel.font = UIFont(name: "HelveticaNeue", size: 30)
        self.addSubview(classLabel)
        classLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(80)
            make.centerY.equalTo(self)
        }
        
        self.selectionStyle = .None
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        if selected {
            classLabel.textColor = UIColor.UIColorFromRGB(0xFC2E55)
        }else {
            classLabel.textColor = UIColor.whiteColor()
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}