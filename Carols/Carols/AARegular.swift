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
    
//    var md5: String! {
//        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
//        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
//        CC_MD5(str!, strLen, result)
//        let hash = NSMutableString()
//        for i in 0..<digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.dealloc(digestLen)
//        return hash as String
//    }
}