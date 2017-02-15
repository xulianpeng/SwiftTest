//
//  ButtonExtension.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/3.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

//最终要识别的 闭包  点击方法
typealias xlpButtonClickHandler = (_ sender:UIButton) -> Void

private var xlpAssociate:String = "xlpAssociate"



extension UIButton{
    var handle:xlpButtonClickHandler{
        
        get {
            
            return objc_getAssociatedObject(self, &xlpAssociate) as! xlpButtonClickHandler
        }
        
        set(newValue){
            objc_setAssociatedObject(self, &xlpAssociate, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func xlpInitButton(_ title:String?,
                     titleColor:UIColor?,
                     fontSize:CGFloat?,
                     imageStr:String?,
                     backgroundImageStr:String?,
                     cornerRedius:CGFloat?,
                     superView:UIView,
                     
                     snpMaker:snapMakerClosure,
                     buttonClick:@escaping xlpButtonClickHandler
        ) {
        
        if title != nil {
            self.setTitle(title, for: .normal)
        }
        if titleColor != nil {
            self.setTitleColor(titleColor, for: .normal)
        }
        if fontSize != nil {
            
            self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
        if imageStr != nil {
            self.setImage(UIImage.init(named: imageStr!), for: .normal)
        }
        if backgroundImageStr != nil {
            self.setBackgroundImage(UIImage.init(named: backgroundImageStr!), for: .normal)
        }
        if cornerRedius != nil {
            self.layer.cornerRadius = cornerRedius!
            self.layer.masksToBounds = true
        }
        
        superView.addSubview(self)
        
        self.snp.makeConstraints(snpMaker)
        
        handle = buttonClick
        
        addTarget(self, action: #selector(xlpBtnClick(btn:)), for: .touchUpInside)
   
    }
    
    func xlpBtnClick(btn:UIButton) -> Void {
        
         print("=======来啊来啊 互相伤害啊==========")
        handle(btn)
    }
    
    func xlpInitRootButton(_ title:String?,
                           titleColor:UIColor?,
                           fontSize:CGFloat?,
                           backgroundColor:UIColor?,
                           imageStr:String?,
                           backgroundImageStr:String?,
                           cornerRedius:CGFloat?,
                           superView:UIView,
                           snpMaker:snapMakerClosure,
                           buttonClick:@escaping xlpButtonClickHandler
        ) {
        
        if title != nil {
            self.setTitle(title, for: .normal)
        }
        if titleColor != nil {
            self.setTitleColor(titleColor, for: .normal)
        }
        if fontSize != nil {
            
            self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
        if backgroundColor != nil {
            self.backgroundColor = backgroundColor
        }
        if imageStr != nil {
            self.setImage(UIImage.init(named: imageStr!), for: .normal)
        }
        if backgroundImageStr != nil {
            self.setBackgroundImage(UIImage.init(named: backgroundImageStr!), for: .normal)
        }
        if cornerRedius != nil {
            self.layer.cornerRadius = cornerRedius!
            self.layer.masksToBounds = true
        }
        
        superView.addSubview(self)
        
        self.snp.makeConstraints(snpMaker)
        
        handle = buttonClick
        
        addTarget(self, action: #selector(xlpBtnClick(btn:)), for: .touchUpInside)
        
    }
    
    func xlpInitEassyButton(_ title:String?,
                            titleColor:UIColor?,
                            fontSize:CGFloat?,
                            backgroundColor:UIColor?,
                            cornerRedius:CGFloat?,
                            superView:UIView,
                            snpMaker:snapMakerClosure,
                            buttonClick:@escaping xlpButtonClickHandler
        ) {
        
        
        self.xlpInitRootButton(title, titleColor: titleColor, fontSize: fontSize, backgroundColor: backgroundColor, imageStr: nil, backgroundImageStr: nil, cornerRedius: cornerRedius, superView: superView, snpMaker: snpMaker, buttonClick: buttonClick)
    }
    

}

