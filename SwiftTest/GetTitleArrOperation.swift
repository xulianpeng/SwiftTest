//
//  GetTitleArrOperation.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/16.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol GetTitleArrOperationDelegate {
    func getTitleArrDelegateSuccess(_ json:JSON?)
}
class GetTitleArrOperation: Operation {

    var delegate :GetTitleArrOperationDelegate?
    
    var url : String
    var paraDic : [String:String]?
    
    
    init(_ url:String,para:[String:String]?) {
        
        self.url = url
        self.paraDic = para
        
        
        
    }
    
    override func main(){
        
        if self.isCancelled {
            return
        }
        
        obtainData(self.url,para: self.paraDic)
        
    }
    
    func obtainData(_ url:String,para:[String:String]?) {
        
        
        MyManager.sharedInstance.SucceedGETFull2(url, parameters: para) { (json, error) in
            
            if json != nil{
                
                self.delegate?.getTitleArrDelegateSuccess(json)
                
            }else{
                
                print("===\(error)" )
            }
            
        }
        
    }

}
