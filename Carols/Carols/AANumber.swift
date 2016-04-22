//
//  AANumber.swift
//  tiger
//
//  Created by FOWAFOLO on 16/4/19.
//  Copyright © 2016年 Xiaoguo. All rights reserved.
//

import Foundation

class AANumber: NSObject {
    
    class func getCurrencyFormatStr(number: NSNumber) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.maximumFractionDigits = 2
        return formatter.stringFromNumber(number)!
    }
    
    class func getIntFromStr(str: String) -> Int? {
        if let number = Int(str) {
            return number
        }else {
            return nil
        }
    }
    
    class func getDoubleFromStr(str: String) -> Double? {
        if let number = Double(str) {
            return number
        }else {
            return nil
        }
    }
    
    class func getUUIDStr() -> String{
        return NSUUID().UUIDString
    }
}