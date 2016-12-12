//
//  OneModal.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/10.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

class OneModal: NSObject {

    var name1 : String?
    var name2 : String?
    
    init(name1:String,name2:String) {
        super.init()
        self.name1 = name1
        self.name2 = name2
    }
    
    func encodeWithCoder(_encoder:NSCoder) {
        
        _encoder.encode(self.name1,forKey: "xlp_name1")
        
        _encoder.encode(self.name2,forKey: "xlp_name2")
        
    }
    init(coder decoder:NSCoder){
        name1 = decoder.decodeObject(forKey: "xlp_name1") as! String?
        name2 = decoder.decodeObject(forKey: "xlp_name2") as! String?

    }
    
}
