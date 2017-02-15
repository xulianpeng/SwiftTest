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

typealias successClosure = (_ response : [String:Any])->Void
typealias failureClosure = (_ error : Error )->Void

typealias finishClosure = (_ success:JSON?,_ error:Error?) -> Void
typealias succeedBlock = (_ success:JSON)->Void

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
    
    
    
    func AllGET(_ urlString:String,parameters:Dictionary<String,Any>,finished:@escaping finishClosure) {
        
        
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
    
    func SucceedGET(_ urlString:String,parameters:Dictionary<String,Any>,succeed:@escaping succeedBlock) {
        
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
    func SucceedPost(_ urlString:String,parameters:Dictionary<String,Any>,succeed:@escaping succeedBlock) {
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
    func SucceedUpload(_ any:Any,parameters:Dictionary<String,Any>,succeed:@escaping succeedBlock) {
        
//        Alamofire.upload(any, with: <#T##URLRequestConvertible#>)
    }
    

}



/// 推荐 这个网络请求类
class MyManager {
    static let sharedInstance = MyManager()
    private init(){}
    
    func SucceedGET(_ urlString:String,parameters:Dictionary<String,Any>,succeed:@escaping succeedBlock) {
        
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

}


