//
//  Array+Extension.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/4/17.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class Array_Extension: NSObject {

}

extension Array{
    
    func xlpCheckArr(_ arr:Array?) -> Bool {
        
        if arr != nil && arr!.count > 0 {
            return true
        }else{
            print("=======数组为空")
            return false
        }
    }
}
