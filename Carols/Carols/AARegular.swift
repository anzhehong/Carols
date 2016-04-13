//
//  AARegular.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/12.
//  Copyright © 2016年 TAC. All rights reserved.
//

import Foundation

//judge input text
extension String {
    func isNumber() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[1-9]+[0-9]*",
                                             options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options:[],
                                        range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func isName() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[^\\s,./<>?;':]+",
                                             options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options:[],
                                        range: NSMakeRange(0, utf16.count)) != nil
    }
}