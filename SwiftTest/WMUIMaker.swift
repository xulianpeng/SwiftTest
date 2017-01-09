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

typealias tapHandler1 = (_ sender:UIButton) -> () //Invalid redeclaration of


class BaseUIButton: UIButton {
    
    var btnHandler: tapHandler1!

    class func button(frame:CGRect,title:String?,fontFloat:CGFloat,image:UIImage?,color:UIColor?,target:Any,superVtew:UIView,handler:@escaping tapHandler1) -> UIButton {
        
        let bt = BaseUIButton()
        bt.frame = frame
        bt.titleLabel?.textAlignment = NSTextAlignment.center
        bt.titleLabel?.font = UIFont.systemFont(ofSize: fontFloat)
        bt.backgroundColor = color
        
        superVtew.addSubview(bt)
        bt.setTitle(title, for: UIControlState.normal)
        bt.setImage(image, for: UIControlState.normal)
//        button.btnHandler = handler
        ///点击
        bt.addTarget(target, action: #selector(btnClick1(btn:)), for: .touchUpInside)
        
       return bt
    }
    
    //把函数方法 包在 闭包里面
    
    @objc private func btnClick1(btn:UIButton){
        
        if btnHandler != nil {
            btnHandler(btn)
        }


    }
    
}
