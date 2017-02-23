//
//  ZhiHuObtainDataOperation.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/2/23.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class ZhiHuObtainDataOperation: Operation {

    var urlStr = ""
    
     func initWith( url :String){
        
     urlStr = url
        
        
    }
    
    private var operation1: () -> ()
    init(operation: @escaping () -> ())
    {
        
        operation1 = operation
        
        
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
        
        print("我的网址是什么啊\(operation1)")
    }
}
