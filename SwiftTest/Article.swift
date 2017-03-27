//
//  Article.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/24.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SwiftyJSON

class Article: NSObject {

    var id : Int?
    var title : String?
    var timeStamp : Int?
    var author : String?
    var replyNum : Int?
    var visitNum : Int?
    var module : Int?
    var thumbnail : String?
    var subClass : String?
    var topFlag : Int?
    var canRead : Int?
    var type : String?
    
    init(_ json : JSON) {
        
        self.id = json[0].int
        self.title = json[1].string
        self.timeStamp = json[2].int
        self.author = json[3].string
        self.replyNum = json[4].int
        self.visitNum = json[5].int
        //self.module =
        self.thumbnail = json[7].string;
        self.subClass = json[8].string
        self.topFlag = json[9].int
        self.canRead = json[10].int
        self.type = json[17].string
        
    }
}
