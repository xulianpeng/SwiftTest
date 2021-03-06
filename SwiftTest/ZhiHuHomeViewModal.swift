//
//  ZhiHuHomeViewModal.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/4.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SwiftyJSON

struct zhiHuCellModel{
    var articleId : Int?
    var imageURL : String?
    var title : String?
    var type : String?
    
    init(_ json : JSON) {
        
        self.articleId = json["id"].int
        self.title = json["title"].string
        self.type = json["type"].string
        self.imageURL =  json["images"][0].string
    }
    
//    func setValuesWithDictionary(dic:NSDictionary) -> Void {
//
//        for i in 0 ..< dic.allKeys.count {
//
//            let key = dic.allKeys[i];
//            let value = dic.object(forKey: key);
////            self.setValue(value, forKey: key as! String);
//
//
//
//        }
//    }
    
}

//首页顶部banner数据模型
struct zhiHuTopCellModel{
    var id : String?
    var imgeURL : String?
    var title : String?
    var type : String?
    
    init(_ json : JSON) {
        
        self.id = json["id"].string
        self.title = json["title"].string
        self.type = json["type"].string
        self.imgeURL = json["image"].string
        
    }
    
}
/*
class zhiHuControllerModal {
    var date : String?
    var top_stroies : [zhiHuTopCellModel] = Array()
    var stroies : [zhiHuCellModel] = Array()
    init(_ json : JSON){
        
        let topStories  =  json["top_stories"].array
        let stories = json["stories"].array
        
        for storyModelJson in stories! {
            
            self.stroies.append(zhiHuCellModel(storyModelJson))
        }
        
        for topStoryModelJson in topStories! {
            
            self.top_stroies.append(zhiHuTopCellModel(topStoryModelJson))
        }
    }

}
*/
struct zhiHuControllerModal {
    
    var date : String?
    var top_stroies : [zhiHuTopCellModel] = Array()
    var stroies : [zhiHuCellModel] = Array()
    init(_ json : JSON){
        
        let topStories  =  json["top_stories"].array
        let stories = json["stories"].array
        
        for storyModelJson in stories! {
            
            self.stroies.append(zhiHuCellModel(storyModelJson))
        }
        
        for topStoryModelJson in topStories! {
            
            self.top_stroies.append(zhiHuTopCellModel(topStoryModelJson))
        }
    }
    
}
