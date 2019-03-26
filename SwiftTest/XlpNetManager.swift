//
//  XlpNetManager.swift
//  SwiftTest
//
//  Created by xulianpeng on 2019/1/10.
//  Copyright © 2019 xulianpeng. All rights reserved.
//

import UIKit
import Alamofire

class XlpNetManager {

    var sessionManager:Alamofire.SessionManager!
    
//    public func setupOauthHandler(accessToken: String, refreshToken: String){
//        let oauthHandler = OAuth2Handler(accessToken: accessToken, refreshToken: refreshToken)
//        sessionManager.adapter = oauthHandler
//        sessionManager.retrier = oauthHandler
//    }
    
    private func setupDefaultHeader(){
        detaultHeader["Content-Type"] = "application/json"
        detaultHeader["Accept-Language"] = "zh-CN,zh;q=0.9"
        detaultHeader["deviceID"] = UIDevice.current.identifierForVendor?.uuidString
        detaultHeader["version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let systemName = UIDevice.current.systemName
        let systemVersion  = UIDevice.current.systemVersion
        detaultHeader["os"] = "\(systemName) \(systemVersion)" // iOS 11.3
        detaultHeader["model"] = UIDevice.current.model //设备型号 iPhone
        
    }
    
    public static let shared = XlpNetManager()
    private var detaultHeader = [String:String]()
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        sessionManager = Alamofire.SessionManager(configuration: configuration)
        setupDefaultHeader()
    }
    
    @discardableResult
    func  request(url:String,method:HTTPMethod = .get,params: Parameters? = nil, headers :HTTPHeaders? = nil,success:@escaping (_ result:[String:Any])->(),failure:@escaping (_ error:NetError)->()) -> DataRequest{
        
        let dataRequest = sessionManager.request(url, method: method, parameters: params, encoding: setParameterEncoding(method: method), headers: addHeaders(headers:headers)).validate { (request, response, data) -> Request.ValidationResult in
            
            
            guard let responseData = data,let dict = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any] else{
                    let error = NetError(code: response.statusCode, desc: "\(response.statusCode)",info:nil)
                    return Request.ValidationResult.failure(error)
            }
            if let code = dict?["code"] as? Int {
                if code != 0 {
                    let message = dict?["message"] as? String ?? ""
                    let errorBody = dict?["body"] as? [String:Any]
                    let error = NetError(code: code, desc:message,info:errorBody)
                    return Request.ValidationResult.failure(error)
                }else {
                    return Request.ValidationResult.success
                }
            }else {
                return Request.ValidationResult.success
            }
            
            }.responseJSON { (response) in
                
                switch response.result {
                case .success:
                    
                    if let result =  response.result.value as? [String:Any] {
                        
                        if let bodyDict = result["body"] as? [String:Any]{
                            success(bodyDict)
                        }else{
                            success(result)
                        }
                    }else{
                        success([:])
                    }
                    
                    
                case .failure(let error):
                    var error = error as? NetError
//                    let isSignOut = response.request?.url?.absoluteString.contains("account/sign_out") ?? true
//                    if error?.errorCode == 102 ||
//                        error?.errorCode == 103 ||
//                        error?.errorCode == 104 ||
//                        (error?.errorCode == 301 && isSignOut == false) {
//                        // 特殊code不回调
//                    }else {
//                        var desc = error?.localizedDescription
//                        if desc == nil {
//                            desc = response.error?.localizedDescription
//                            error?.desc = desc ?? ""
//                        }
//                        failure(NetError(code: error?.errorCode ?? -999, desc: desc ?? "", info: error?.info))
//                    }
                    var desc = error?.localizedDescription
                    if desc == nil {
                        desc = response.error?.localizedDescription
                        error?.desc = desc ?? ""
                    }
                    failure(NetError(code: error?.errorCode ?? -999, desc: desc ?? "", info: error?.info))
                }
        }
        return dataRequest
    }
    
    private func setParameterEncoding(method:HTTPMethod) -> ParameterEncoding {
        switch method {
        case .get,.head,.delete:
            return URLEncoding.queryString
        case .post,.put,.patch :
            return JSONEncoding(options: [])
        default:
            return URLEncoding.default
        }
    }
    
    /// header
    private func addHeaders(headers:HTTPHeaders?) -> [String:String]{
        var httpHeader = [String:String]()
        for (key,value) in headers ?? [:]{
            httpHeader[key] = value
        }
        for (key,value) in detaultHeader {
            httpHeader[key] = value
        }
        return httpHeader
    }
    
    
}
// MARK: - 自定义错误处理
public struct NetError:Error ,LocalizedError{
    
    var desc : String
    private var code : Int
    private var infomation : [String:Any]?
    
    public var localizedDescription:String {
        return self.desc
    }
    public var errorCode :Int {
        return self.code
    }
    public var info: [String:Any]? {
        return self.infomation
    }
    
    public init(code:Int,desc:String,info:[String:Any]?){
        self.code = code
        self.desc = desc
        self.infomation = info
    }
}
