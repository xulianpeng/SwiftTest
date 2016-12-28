//
//  WMUIExtension.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/27.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

extension UILabel{
    
    func creatLabel(_ text:String,aligenment:NSTextAlignment,fontSize:CGFloat,textColor:UIColor,backgroundColor:UIColor,superView:UIView) -> Void {
        
        self.text = text;
        self.textAlignment = aligenment
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.numberOfLines = 0;
        
        superView.addSubview(self)
        
    }
}

typealias ButtonClickBlock = ((_ sender: UIButton) -> ())
extension UIButton{
    
    func creatButton(_ title:String,titleColor:UIColor,imageStr:String,backgroundImageStr:String,cornerRedius:CGFloat,superView:UIView,_: ButtonClickBlock) -> Void{
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setImage(UIImage.init(named: imageStr), for: .normal)
        self.setBackgroundImage(UIImage.init(named: backgroundImageStr), for: .normal)
        self.layer.cornerRadius = cornerRedius
        self.layer.masksToBounds = true
//        self.addTarget(self, action: #selector(""), for: .touchUpInside)
        superView.addSubview(self)
        
    }

    
}

class WMUIExtension: NSObject {

}
