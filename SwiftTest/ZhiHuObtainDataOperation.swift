//
//  ZhiHuObtainDataOperation.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/2/23.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class ZhiHuObtainDataOperation: Operation {

    var urlStr :String = ""
    
     func initWith(_ url :String){
        
     self.urlStr = url
        
        
    }
    
    override func main() {
        super.main()
        
        if (self.isCancelled) {
            return
        }
        
        //具体的操作
        doYourOperation()
        
    }
    func doYourOperation() {
        
        print("我的网址是什么啊)")
    }
}
