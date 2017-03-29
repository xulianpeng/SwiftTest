//
//  WMNetManager.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/29.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import MBProgressHUD



class WMNetManager: NSObject {

    static let sharedInstance = WMNetManager()
    
    
   
    
    let configuration = URLSessionConfiguration.default
    
    
    
    let globalQueue = DispatchQueue.global(qos: .utility)
    
    
    func WMNetGET(_ urlString:String,parameters:[String:Any]?,success:@escaping successClosure,to failure: @escaping failureClosure) {
        
        
//        let sessionManager = Alamofire.SessionManager(configuration:configuration)
        
        
        
        
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success(let value):
                if let value = value as? [String: Any] {
                    success(value)
                }
            case.failure:
                
                let theError = response.result.error
                failure(theError ?? "请检查网络连接是否正常哦" as! Error)
                print("====\(theError)" )
                break
            }

            
        })
            

    }
    
    
    
    func AllGET(_ urlString:String,parameters:Dictionary<String,Any>,finished:@escaping WMNetFinishBlock) {
        
        
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success(let value):
                
                let theValueJsonxlp = JSON(value)
                finished(theValueJsonxlp,nil)
                
            case.failure:
                
                let theError = response.result.error!
                
                finished(nil,theError)

                break
            }  
            
            
            
        })

        
    }
    
    func SucceedGET(_ urlString:String,parameters:Dictionary<String,Any>,succeed:@escaping WMNetSucceedBlock) {
        
        SVProgressHUD.setBackgroundColor(.red)
        SVProgressHUD.show()
        
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON(completionHandler: { (response) in
            
            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let value):
                
                let theValueJson = JSON(value)
                succeed(theValueJson)
                
            case.failure:
                
                let theError = response.result.error!
                
                print("=====\(theError)")
                
                
                break
            }
            
            
        })
        
        
    }
    
    //MARK: 普通POST ->z针对一般的post请求
    func SucceedPost(_ urlString:String,parameters:Dictionary<String,Any>,succeed:@escaping WMNetSucceedBlock) {
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON(queue: globalQueue, options: JSONSerialization.ReadingOptions.allowFragments) { (response) in
            
            switch response.result {
            case .success(let value):
                
                let theValueJson = JSON(value)
                succeed(theValueJson)
                
            case.failure:
                
                let theError = response.result.error!
                
                print("=====\(theError)")
                
                
                break
            }

        }
    }
    
    //MARK :大文件上传到服务器
    func SucceedUpload(_ any:Any,parameters:Dictionary<String,Any>,succeed:@escaping WMNetSucceedBlock) {
        
//        Alamofire.upload(any, with: <#T##URLRequestConvertible#>)
    }
    

}



/// 推荐 这个网络请求类
class MyManager {
    static let sharedInstance = MyManager()
    private init(){}
    
    func SucceedGET(_ urlString:String,parameters:Dictionary<String,Any>?,succeed:@escaping WMNetSucceedBlock) {
        
//        SVProgressHUD.setBackgroundColor(.gray)
//        SVProgressHUD.show()
        
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON(completionHandler: { (response) in
            
//            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let value):
                
                let theValueJson = JSON(value)
                succeed(theValueJson)
                
            case.failure:
                
                let theError = response.result.error!
                
                print("=====\(theError)")
                
                
                break
            }
            
            
        })
    }

    func SucceedGETFull(_ urlString:String,parameters:Dictionary<String,Any>?,succeed:@escaping WMNetSucceedBlock,failed:@escaping failureClosure) {
        
        //        SVProgressHUD.setBackgroundColor(.gray)
        //        SVProgressHUD.show()
        
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON(completionHandler: { (response) in
            
            //            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let value):
                
                let theValueJson = JSON(value)
                succeed(theValueJson)
                
            case.failure:
                
                let theError = response.result.error!
                
                failed(theError)
                print("=====\(theError)")
                
                
                break
            }
            
            
        })
    }
    
    
    /// 完整的数据请求
    ///
    /// - Parameters:
    ///   - urlString: 网址
    ///   - parameters: 参数
    ///   - finished: 请求完成后的处理包括 成功和失败
    func SucceedGETFull2(_ urlString:String,parameters:Dictionary<String,Any>?,finished:@escaping WMNetFinishBlock) {
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON(completionHandler: { (response) in
            
            switch response.result {
                
            case .success(let value):
                let theValueJson = JSON(value)
                finished(theValueJson,nil)
            case.failure:
                let theError = response.result.error!
                finished(nil,theError)
            }
        
        })
    }
    
//MARK: post请求 para有的话 不能合并到url里面 否则会出现 valid url的错误  至于get请求 暂不清楚
    
    func SucceedPOST(_ urlString:String,parameters:Dictionary<String,Any>,succeed:@escaping WMNetSucceedBlock) {
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
            
            //            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let value):
                
                let theValueJson = JSON(value)
                succeed(theValueJson)
                
            case.failure:
                
                let theError = response.result.error!
                
                print("=====\(theError)")
                
                
                break
            }
            
            
        })
    }
    func SucceedPOSTFull2(_ urlString:String,parameters:Dictionary<String,Any>,finished:@escaping WMNetFinishBlock) {
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
            
            switch response.result {
                
            case .success(let value):
                let theValueJson = JSON(value)
                finished(theValueJson,nil)
            case.failure:
                let theError = response.result.error!
                finished(nil,theError)
            }
            
        })
    
    }

}


