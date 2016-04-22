//
//  AAAlertViewController.swift
//  tiger
//
//  Created by FOWAFOLO on 16/4/18.
//  Copyright © 2016年 Xiaoguo. All rights reserved.
//

import UIKit

class AAAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func showAlert(title: String, message: String) {
        let rootWindow = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController
        let vc = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "好的", style: .Cancel) { (action) in
            rootWindow?.dismissViewControllerAnimated(true, completion: nil)
        }
        vc.addAction(action)
        rootWindow!.presentViewController(vc, animated: true, completion: nil)
    }
    
    class func getAlert(title: String, message: String)-> UIAlertController {
        let rootWindow = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController
        let vc = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "好的", style: .Cancel) { (action) in
            rootWindow?.dismissViewControllerAnimated(true, completion: nil)
        }
//        vc.addAction(action)
        return vc
    }
    
    class func showActionSheet(title: String, message: String)-> UIAlertController {
        let rootWindow = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController
        let vc = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        
        let cancel = UIAlertAction(title: "取消", style: .Cancel) { (action) in
            rootWindow?.dismissViewControllerAnimated(true, completion: nil)
        }
        vc.addAction(cancel)
        return vc
    }
}
