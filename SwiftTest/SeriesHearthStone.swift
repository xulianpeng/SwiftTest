//
//  SeriesHearthStone.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/28.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SwiftyJSON
class SeriesHearthStone: NSObject {

    var abbr : String?
    var clazz : String?
    var created : Int?
    var id : Int?
    var name : String?
    var pubTime : Int?
    var scored : Int?
    var size : Int?
    var standard : Int?
    var updated : Int?
    var visible : Int?
    var wild : Int?
    
    init(_ json : JSON) {
        
        self.abbr = json["abbr"].string
        self.clazz = json["clazz"].string
        self.created = json["created"].int
        self.id = json["id"].int
        self.name = json["name"].string
        self.pubTime = json["pubTime"].int
        self.scored = json["scored"].int;
        self.size = json["size"].int
        self.standard = json["standard"].int
        self.updated = json["updated"].int
        self.visible = json["visible"].int
        self.wild = json["wild"].int
        
    }
    init(_ json:[String:Any]) {
        self.abbr = json["abbr"] as? String
        self.clazz = json["clazz"] as? String
        self.created = json["created"] as? Int
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.pubTime = json["pubTime"] as? Int
        self.scored = json["scored"] as? Int
        self.size = json["size"]! as? Int
        self.standard = json["standard"]as? Int
        self.updated = json["updated"]as? Int
        self.visible = json["visible"]as? Int
        self.wild = json["wild"]as? Int
    }
    
}
class PackageHearthStone: NSObject {
    
}
class CardHearthStone: NSObject {
    
}
