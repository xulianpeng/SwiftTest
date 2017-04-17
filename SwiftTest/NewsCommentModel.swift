//
//  NewsCommentModel.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/4/12.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SwiftyJSON
class NewsCommentModel: NSObject {

    var headUrl:String?
    var oneName:String?
    var oneLevel:Int?
    var oneCreated:Int?
    var supportNum:Int?
    var oneContent:String?
    var articleID:Int?
    var commentID :Int?
    var userID:Int?
    var remark:String?
    var liked :Bool?
    
    init(_ json:JSON) {
        
        let comment = json["comment"].dictionary!
        let user = json["user"].dictionary!
        
        self.headUrl = user["head"]?.string
        self.oneName = user["username"]?.string
        self.oneLevel = user["credits"]?.int
        self.oneCreated = comment["created"]?.int
        self.supportNum = comment["likes"]?.int
        self.oneContent = comment["content"]?.string
        self.articleID = comment["article"]?.int
        self.commentID = comment["id"]?.int
//        self.userID = user[""]
        self.remark = comment["remark"]?.string
        self.liked = json["liked"].bool
    }
}
class NewsCommentModelTwo: NSObject {
    
    var headUrl:String?;
    var oneName:String?;
    var oneLevel:Int?;
    var oneCreated:Int?;
    var supportNum:Int?;
    var oneContent:String?;
    var twoName:String?;
    var twoCreated:Int?;
    var twoContent:String?;
    var articleID:Int?;
    var commentID:Int?;
    var userID:Int?;
    var remark:String?;
    var liked:Bool?;
    
    init(_ json:JSON) {
//        self.headUrl = json[""]
//        self.oneName = json[""]
//        self.oneLevel = json[""]
//        self.oneCreated = json[""]
//        self.supportNum = json[""]
//        self.oneContent = json[""]
//        self.twoName = json[""]
//        self.twoCreated = json[""]
//        self.twoContent = json[""]
//        self.articleID = json[""]
//        self.commentID = json[""]
//        self.userID = json[""]
//        self.remark = json[""]
//        self.liked = json[""]
        
        let comment = json["comment"].dictionary!
        let user = json["user"].dictionary!
        
        self.headUrl = user["head"]?.string
        self.oneName = user["username"]?.string
        self.oneLevel = user["credits"]?.int
        self.oneCreated = comment["created"]?.int
        self.supportNum = comment["likes"]?.int
        self.oneContent = comment["content"]?.string
        self.articleID = comment["article"]?.int
        self.commentID = comment["id"]?.int
        //        self.userID = user[""]
        self.remark = comment["remark"]?.string
        self.liked = json["liked"].bool
    }

}
class NewsCommentVCModel {
    
    var commentModelArr:[NewsCommentModel] = [NewsCommentModel]()
    var commentModelTwoArr:[NewsCommentModel] = [NewsCommentModel]()
    
    init(_ json:JSON) {
        
        let comments = json["normalComments"].array
        let hotComments = json["hotComments"].array
        
        
        for commentJson in comments!{
            self.commentModelArr.append(NewsCommentModel.init(commentJson))
        }
        
        
        if kXlpCheckArr(hotComments){
            
            for hotCommentJson in hotComments!{
                self.commentModelTwoArr.append(NewsCommentModel(hotCommentJson))
            }
        }
//            hotComments != nil && (hotComments?.count)! > 0 {
//            
//        }
        
    }
    
    
    
}
