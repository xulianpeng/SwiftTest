//
//  WMUIMaker.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/23.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

/// # title :UI工厂类
/// # author :xulianpeng
class WMUIMaker: NSObject {

    
    
    /*
     label2.snp.makeConstraints(<#T##closure: (ConstraintMaker) -> Void##(ConstraintMaker) -> Void#>)
     */
    
    class   func creatLabel(label:UILabel,text:String,aligenment:NSTextAlignment,fontSize:CGFloat,textColor:UIColor,backgroundColor:UIColor,superView:UIView) -> Void {
        
        label.text = text;
        label.textAlignment = aligenment
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.numberOfLines = 0;
        superView.addSubview(label)
        
    }
    
    /*
    class  func creatButton(button:UIButton,title:String,titleColor:UIColor,imageStr:String,backgroundImageStr:String,cornerRedius:CGFloat,superView:UIView,action:Selector) -> Void {
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setImage(UIImage.init(named: imageStr), for: .normal)
        button.setBackgroundImage(UIImage.init(named: backgroundImageStr), for: .normal)
        button.layer.cornerRadius = cornerRedius
        button.layer.masksToBounds = true
        button.addTarget(self, action:action, for: .touchUpInside)
        superView.addSubview(button)
        
    }
    */
    class  func creatButton(button:UIButton,title:String,titleColor:UIColor,imageStr:String,backgroundImageStr:String,cornerRedius:CGFloat,superView:UIView) -> Void {
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setImage(UIImage.init(named: imageStr), for: .normal)
        button.setBackgroundImage(UIImage.init(named: backgroundImageStr), for: .normal)
        button.layer.cornerRadius = cornerRedius
        button.layer.masksToBounds = true
        //        button.addTarget(self, action:action, for: .touchUpInside)
        superView.addSubview(button)
        
    }

    
}
