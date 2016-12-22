//
//  EassyModal.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/20.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

class EassyModal: NSObject {

    /*
     @property (nonatomic, strong) NSNumber * id;
     @property (nonatomic, strong) NSNumber * module;
     @property (nonatomic, strong) NSNumber * replyNum;
     @property (nonatomic, strong) NSString * subClass;
     @property (nonatomic, strong) NSString * thumbnail;
     @property (nonatomic, strong) NSNumber * timeStamp;
     @property (nonatomic, strong) NSString * title;
     @property (nonatomic, strong) NSNumber * topFlag;
     @property (nonatomic, strong) NSString * author;
     @property (nonatomic, strong) NSNumber * visitNum;
     @property (nonatomic, strong) NSNumber * canRead;//是否可见
     @property (nonatomic, strong) NSNumber * type;//类型：普通资讯1、专题2、推广4等
     */
    
    var articleID :Int = 0
    var moduleID :Int = 0
    var replyNum :Int = 0
    var subClass :String = ""
    var thumbnail :String = ""
    var timestamp:Int = 0
    var title:String = ""
    var topFlag:Int = 0
    var author:String = ""
    var visitNum:Int = 0
    var canRead:Int = 0 //是否可见
    var type:Int = 0 //类型：普通资讯1、专题2、推广4等
    /*
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    */
    
    init(articleID:Int,moduleID:Int,replyNum :Int,subClass:String,thumbnail:String,timestamp:Int,title:String,topFlag:Int,author:String,visitNum:Int,canRead:Int,type:Int) {
        
        

        self.articleID = articleID
        self.moduleID = moduleID
        self.replyNum = replyNum
        self.subClass = subClass
        self.thumbnail = thumbnail
        self.timestamp = timestamp
        self.title = title
        self.topFlag = topFlag
        self.author = author
        self.visitNum = visitNum
        self.canRead = canRead
        self.type = type
        
        super.init()
        
    }
    
    func encodeWithCoder(_encoder:NSCoder) {
        
        _encoder.encode(self.articleID,forKey: "articleID")
        _encoder.encode(self.moduleID,forKey: "moduleID")
        _encoder.encode(self.replyNum,forKey: "replyNum")
        _encoder.encode(self.subClass,forKey: "subClass")
        _encoder.encode(self.thumbnail,forKey: "thumbnail")
        _encoder.encode(self.timestamp,forKey: "timestamp")
        _encoder.encode(self.title,forKey: "title")
        _encoder.encode(self.topFlag,forKey: "topFlag")
        _encoder.encode(self.author,forKey: "author")
        _encoder.encode(self.visitNum,forKey: "visitNum")
        _encoder.encode(self.canRead,forKey: "canRead")
        _encoder.encode(self.type,forKey: "type")
        
        
    }
    init(coder decoder:NSCoder){
        articleID = decoder.decodeObject(forKey: "articleID") as! Int!
        moduleID = decoder.decodeObject(forKey: "moduleID") as! Int!
        replyNum = decoder.decodeObject(forKey: "replyNum") as! Int!
        subClass = decoder.decodeObject(forKey: "subClass") as! String!
        thumbnail = decoder.decodeObject(forKey: "thumbnail") as! String!
        timestamp = decoder.decodeObject(forKey: "timestamp") as! Int!
        title = decoder.decodeObject(forKey: "title") as! String!
        topFlag = decoder.decodeObject(forKey: "topFlag") as! Int!
        author = decoder.decodeObject(forKey: "author") as! String!
        visitNum = decoder.decodeObject(forKey: "visitNum") as! Int!
        canRead = decoder.decodeObject(forKey: "canRead") as! Int!
        type = decoder.decodeObject(forKey: "type") as! Int!
    }
    
    
    
    
   
    
    
    
    
}
