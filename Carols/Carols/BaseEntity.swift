//
//  BaseEntity.swift
//  LXDMusicPlayer
//
//  Created by  Harold LIU on 5/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Mantle

class BaseEntity : MTLModel,MTLJSONSerializing {
    
    let formatter = NSDateFormatter()
    
    override init () {
        super.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    required init(coder: NSCoder!) {
        super.init(coder: coder)
    }
    
    required init(dictionary dictionaryValue: [NSObject : AnyObject]!) throws {
       try! super.init(dictionary: dictionaryValue)
    }
    
    class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        print("Attention: override \(#function) in subclass")
        self.doesNotRecognizeSelector(#function)
        return nil
    }

    class func transformToArray(array:NSArray) -> NSArray? {
        var eneties:NSArray?
        do
        {
           eneties = try MTLJSONAdapter.JSONArrayFromModels(array as [AnyObject])
        }
        catch
        {
            print("Error Occur In JSON")
        }
         return eneties
    }

    class func entityFromDic(data: NSDictionary)  -> AnyObject?{
        var entity:AnyObject? = nil
        do
        {
         entity = try MTLJSONAdapter.modelOfClass(BaseEntity.self, fromJSONDictionary: data as! [NSObject : AnyObject])
        }
        catch
        {
            print("Error Occur In JSON")
        }
        return entity
    }
    
    class func entitiesArrayFromArray(array:NSArray) -> NSArray? {
        var arrayEntities:NSArray?
        do
        {
            arrayEntities = try MTLJSONAdapter.modelsOfClass(Song.self, fromJSONArray: array as [AnyObject])
        }
        catch
        {
            print("Error Occur In JSON")
        }
        return arrayEntities
    }
    
   private func transformToDic() -> NSDictionary? {
        var dic :NSDictionary?
        do
        {
            dic = try MTLJSONAdapter.JSONDictionaryFromModel(self)
        }
        catch
        {
            print("Error Occur In JSON")
        }
        return dic
    }
    
   private func dicValue() -> NSDictionary {
        let mdic = NSMutableDictionary(dictionary: super.dictionaryValue)
        
        for originalKey in super.dictionaryValue.keys {
            let key = originalKey as! String
            if self.valueForKey(key) == nil {
                if self.valueForKey(key)!.isKindOfClass(NSString) {
                    mdic.setObject("", forKey: key)
                }
            }
        }
        return mdic.copy() as! NSDictionary
    }
    
   private func createdAtJSONTransformer() -> NSValueTransformer {
        return MTLValueTransformer.reversibleTransformerWithForwardBlock(
            { str -> AnyObject! in
             return self.formatter.dateFromString(String(str))
            },
            reverseBlock:
            { date -> AnyObject! in
                let d = date as! NSDate
                return self.formatter.stringFromDate(d)
        })
    }
    
   private func updatedAtJSONTransformer() -> NSValueTransformer {
        return MTLValueTransformer.reversibleTransformerWithForwardBlock(
            { str -> AnyObject! in
                return self.formatter.dateFromString(String(str))
            },
            reverseBlock:
            { date -> AnyObject! in
                let d = date as! NSDate
                return self.formatter.stringFromDate(d)
        })
    }
   }