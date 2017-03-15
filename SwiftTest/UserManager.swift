//
//  UserManager.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/1.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class WMUser {

    var userName :String?
    var userPassword:String?
    var userID :String?
    var userHeadImage:NSData?
    var userType:String?//账号类型  普通用户 第三方登录用户
    
    
    
}

class UserManager{
    
    static let sharedInstance = UserManager()
    private init(){}
    
    //注册  用户名账号注册  第三方注册
    class  func registWith(_ name:String,passWord:String)  {
        
        //网络请求 根据返回结果 更新 WMUser 跳转APP首页
    }
    
    //用户名账号登录
    class func logInWith(_ name:String,passWord:String)  {
        
        //网络请求 根据返回结果 更新 WMUser 跳转APP首页
        
    }
    //登出  user 清除  第三方登录的话也是这样 清除跟用户绑定的所有信息
    class func logOut()  {
        
    }
    
}
