//
//  UIViewController+Extension.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/2/28.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func initIndicator(_ superView:UIView) -> UIActivityIndicatorView {
        
        let myIndictor = UIActivityIndicatorView.init(style: .gray)
        superView.addSubview(myIndictor)
        myIndictor.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(50)
        }
        return myIndictor
    }
}

