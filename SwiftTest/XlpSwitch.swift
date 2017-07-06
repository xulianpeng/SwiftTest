//
//  XlpSwitch.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/6/30.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class XlpSwitch: UIView {

    
    let OnColor = UIColor.green
    let OffColor = UIColor.gray
    
    let bottomView = UIImageView()
    
    let tapView = UIImageView()
    
    var isOnSwitch:Bool = false{
        
        
        set
        
    }
    
    
   
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = 3
        
//        self.backgroundColor = OffColor
        
        
        bottomView.xlpInitImageView(self, corner: 3) { (make) in
            
            make.edges.equalTo(self)
        }
        bottomView.image = kImageWithName("switchbottom")
        
        
        let aWidth = frame.size.width
        let aHeight = frame.size.height
        
        
        
//        tapView.frame = CGRect(x:0,y:0,width:aWidth/2,height:aHeight)
        
//        self.addSubview(tapView)
//        
//        
//        tapView.tapHandle(tap: <#T##UITapGestureRecognizer#>)
        
        tapView.xlpInitView(frame: CGRect(x:0,y:0,width:aWidth/2,height:aHeight), superView: self) { (tap) in
            
            
            UIView.animate(withDuration: 0.3, animations: { 
                
                self.tapView.frame = CGRect(x:aWidth/2,y:0,width:aWidth/2,height:aHeight)
                
                self.backgroundColor = self.OnColor
            })
            
        }
        tapView.image = kImageWithName("switchon")
//        tapView.backgroundColor = UIColor.brown

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
