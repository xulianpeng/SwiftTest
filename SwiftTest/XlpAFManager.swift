
//
//  XlpAFManager.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/11/23.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import AFNetworking
class XlpAFManager: NSObject {

    static let sharedInstance = XlpAFManager()

    
    //get 请求
    
    func xlpGet(_ url:String,para:[String:Any],success:@escaping WMNetFinishBlock) {
        
        let manager : AFHTTPSessionManager = AFHTTPSessionManager.init()
        
//        manager.get(url, parameters: para,success: { (task, responseObject) in
//
//            success(responseObject,nil)
//        }) { (task, error) in
//            success(nil,error)
//        }
        
        
        
    }
    
    //post请求
    
    
}
