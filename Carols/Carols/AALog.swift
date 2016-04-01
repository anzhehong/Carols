//
//  AALog.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/1.
//  Copyright © 2016年 TAC. All rights reserved.
//

import Foundation
import SwiftyBeaver

class AALog {
    //Red
    class func error(message: AnyObject) {
        //MARK: Colorful Log
        let log = SwiftyBeaver.self
        let console = ConsoleDestination()  // log to Xcode Console
        console.detailOutput = true // log simple (date, level, message)
        console.dateFormat = "HH:mm:ss"  // simpler date format
        log.addDestination(console)
        log.error(message)
        log.error("Error End")
    }
    
    //Yellow
    class func warning(message: AnyObject) {
        let log = SwiftyBeaver.self
        let console = ConsoleDestination()
        console.detailOutput = false
        console.dateFormat = "HH:mm:ss"
        log.addDestination(console)
        log.warning(message)
        log.warning("Warning End")
    }
    
    //Green
    class func info(message: AnyObject) {
        let log = SwiftyBeaver.self
        let console = ConsoleDestination()
        console.detailOutput = false
        console.dateFormat = "HH:mm:ss"
        log.addDestination(console)
        log.info(message)
        log.info("Info End")
    }
    
    //Blue
    class func debug(message: AnyObject) {
        let log = SwiftyBeaver.self
        let console = ConsoleDestination()
        console.detailOutput = false
        console.dateFormat = "HH:mm:ss"
        log.addDestination(console)
        log.debug(message)
        log.debug("Debug End")
    }
    
    //Gray
    class func test(message: AnyObject) {
        let log = SwiftyBeaver.self
        let console = ConsoleDestination()
        console.detailOutput = false
        console.dateFormat = "HH:mm:ss"
        log.addDestination(console)
        log.verbose(message)
        log.verbose("Test End")
    }

}