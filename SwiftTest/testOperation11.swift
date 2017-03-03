//
//  testOperation11.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/3.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SwiftyJSON


protocol TestOperationDelegate {
    
     func obtainDataDelegateSuccess(_ json:JSON?)

    
}
class testOperation11: Operation {

    var delegate :TestOperationDelegate?
    
    var url : String
    
    
    init(_ url:String) {
        
        self.url = url
        
    }
    
    override func main(){
    
        if self.isCancelled {
            return
        }
    
        obtainData(self.url)
    
    }
    
    func obtainData(_ url:String) {
        
       print("asdasasd我们的大中国啊 好大的一个家")
        
        MyManager.sharedInstance.SucceedGETFull2(url, parameters: [:]) { (json, error) in
            
            if json != nil{
                
//                let  homeModel = zhiHuControllerModal(json!)
                
//                self.zhiHuTopCellModelArr = homeModel.top_stroies
//                self.zhiHuCellModelArr = homeModel.stroies
//                self.rootTableView.reloadData()
                
                
            self.delegate?.obtainDataDelegateSuccess(json)
                
            }else{
                
                print("===\(error)" )
            }
            
        }

    }
}
