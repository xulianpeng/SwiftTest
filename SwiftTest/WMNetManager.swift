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
        
        SVProgressHUD.setBackgroundColor(.white)
        SVProgressHUD.setDefaultStyle(.light)
//        SVProgressHUD.setDefaultMaskType(.gradient) //聚光灯效果
        
        SVProgressHUD.setMinimumDismissTimeInterval(5) //据说是和展示的文字的长度有关 但是时间还是和 预想的时间 差别很大
//        SVProgressHUD.show(withStatus: "你是我的小丫小苹果啦啦啦啦哈哈哈哈你是我的小丫小苹果啦啦啦啦哈哈哈哈你是我的小丫小苹果啦啦啦啦哈哈哈哈")
        // 圆环 转圈  不自动消失
//        SVProgressHUD.showInfo(withStatus: "对不起")
        //感叹号 自动消失 时间 为默认的5s
//        SVProgressHUD.showError(withStatus: "你是我的小丫小苹果啦啦啦啦哈哈哈哈你是我的小丫小苹果啦啦啦啦哈哈哈哈你是我的小丫小苹果啦啦啦啦哈哈哈哈") //x号 自动消失 时间 为默认的5s
        SVProgressHUD.showSuccess(withStatus: "你是我的小丫小苹果啦啦啦啦哈哈哈哈你是我的小丫小苹果啦啦啦啦哈哈哈哈你是我的小丫小苹果啦啦啦啦哈哈哈哈")// 对号 自动消失 时间 为默认的5s
//        SVProgressHUD.show(UIImage.init(named: "triangle")!, status: "你是我的小丫小苹果啦啦啦啦哈哈哈哈你是我的小丫小苹果啦啦啦啦哈哈哈哈你是我的小丫小苹果啦啦啦啦哈哈哈哈") //图片会占据 show(withStatus:中 进度条所在的位置  自动消失 时间 为默认的5s
//        SVProgressHUD.showProgress(0.5, status: "你是我的小丫小苹果啦啦啦啦哈哈哈哈你是我的小丫小苹果啦啦啦啦哈哈哈哈你是我的小丫小苹果啦啦啦啦哈哈哈哈") //不主动显示
        
        SVProgressHUD.dismiss(withDelay: 2)
        
        SVProgressHUD.setOffsetFromCenter(UIOffset.init(horizontal: 0, vertical: 100))
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON(completionHandler: { (response) in
            
//            SVProgressHUD.dismiss(withDelay: 3)
            
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
    
    func GetData(_ urlString:String,parameters:Dictionary<String,Any>?,succeed:@escaping WMNetSucceedDataBlock){

        Alamofire.request(urlString, method: .get, parameters: parameters).responseData { (data) in
            
            if data.data != nil{
                let resultData = (data.data!) as Data
                succeed(resultData)
            }else{
                print("返回值为nil")
            }
            
        }
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
    //目前的网络请求 其失败的时候 不是通过.failure来显示的 而是 success这个字段为非正值来判断
    func SucceedPOSTLast(_ urlString:String,parameters:Dictionary<String,Any>,succeed:@escaping WMNetSucceedBlock) {
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
            
            
            switch response.result {
            case .success(let value):
                
                let theValueJson = JSON(value)
                if theValueJson["success"].int! > 0{
                    succeed(theValueJson)
                }else{
                    
                    print("=====\(theValueJson["msg"])")
                    //在这里可以跳转到登录页 提示身份失效

                }
                
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


