//
//  ADView.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/4/17.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class ADView: UIView {

    var adImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        adImageView.xlpInitView(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT), superView: self) { (tap) in
            
            print("====点击广告了啦啦啦")
            UIView.animate(withDuration: 0.3, animations: { 
               
                self.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
                self.alpha = 0.0
            }, completion: { (true) in
                
                self.removeFromSuperview()
            })
        }
        
        let dataPath = kGetDocumentPath().appendingPathComponent("/AD/adData")
        print("======广告保存的路径")
        adImageView.image = UIImage.init(contentsOfFile: dataPath)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
