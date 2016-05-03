//
//  User+CoreDataProperties.swift
//  Carols
//
//  Created by FOWAFOLO on 16/5/3.
//  Copyright © 2016年 TAC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var openId: String?
    @NSManaged var nickName: String?
    @NSManaged var sex: NSNumber?
    @NSManaged var avatorUrl: String?
    @NSManaged var id: NSNumber?
    @NSManaged var phoneNum: String?
}
