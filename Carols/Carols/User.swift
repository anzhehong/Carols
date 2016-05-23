//
//  User.swift
//  Carols
//
//  Created by FOWAFOLO on 16/5/3.
//  Copyright © 2016年 TAC. All rights reserved.
//

import Foundation
import CoreData


class User: NSManagedObject {

    static var _current: User?
    
    class func createNewUser() -> User {
        let user = User.MR_createEntity()
        user?.nickName = "Not Set"
        user?.avatorUrl = ""
        user?.sex = 1
        user?.phoneNum = "Not Set"
        return user!
    }
    
    class func currentUser() -> User {
        if _current != nil {
            return _current!
        }
        if let user = User.MR_findFirst() {
            return user
        }else {
            return User.createNewUser()
        }
    }
    
    class func loggedUser() -> User? {
        if _current != nil {
            return _current!
        }
        if let user = User.MR_findFirst() {
            print("count: \(User.MR_findAll()?.count)")
            return user
        }else {
            return nil
        }
    }
    
    class func updateUser(updatedUser: User) -> User{
        if var user = User.MR_findFirst() {
            user = updatedUser
            _current = updatedUser
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            return user
        }else {
            var newUser = currentUser()
            newUser = updatedUser
            _current = updatedUser
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            return newUser
        }
    }
}
