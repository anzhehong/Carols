//
//  AAHandler.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/23.
//  Copyright © 2016年 TAC. All rights reserved.
//

typealias AAAnyErrorHandler = ((AnyObject?, NSError?) -> Void)
typealias AAArrayErrorHandler = (([AnyObject]?, NSError?) -> Void)
typealias AAUserHandler = ((AAUser?, NSError?) -> Void)
typealias AAUserDataHandler = ((User?, NSError?) -> Void)
typealias AAErrorHandler = ((NSError?)-> Void)