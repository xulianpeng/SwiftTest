//
//  ButtonExtension.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/3.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

//最终要识别的 闭包  点击方法

private var xlpAssociateButton:String = "xlpAssociateButton"

//private var xlpAssociateTextView:String = "xlpAssociateTextView"
private var xlpAssociateTextViewLabel:String = "xlpAssociateTextViewLabel"


extension UIButton{
    var handle:WMButtonClickBlock{
        
        get {
            
            return objc_getAssociatedObject(self, &xlpAssociateButton) as! WMButtonClickBlock
        }
        
        set(newValue){
            objc_setAssociatedObject(self, &xlpAssociateButton, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func xlpInitButton(_ title:String?,
                     titleColor:UIColor?,
                     fontSize:CGFloat?,
                     imageStr:String?,
                     backgroundImageStr:String?,
                     cornerRedius:CGFloat?,
                     superView:UIView,
                     
                     snpMaker:WMSnapMakerBlock,
                     buttonClick:@escaping WMButtonClickBlock
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
                           snpMaker:WMSnapMakerBlock,
                           buttonClick:@escaping WMButtonClickBlock
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
        
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        superView.addSubview(self)
        
        self.snp.makeConstraints(snpMaker)
        
        handle = buttonClick
        
        addTarget(self, action: #selector(xlpBtnClick(btn:)), for: .touchUpInside)
        
    }
    
    func xlpInitRootButtonTest(_ title:String?,
                           titleColor:UIColor?,
                           fontSize:CGFloat?,
                           backgroundColor:UIColor?,
                           imageStr:String?,
                           backgroundImageStr:String?,
                           cornerRedius:CGFloat?,
                           superView:UIView,
                           buttonClick: @escaping WMButtonClickBlock,
                           snpMaker:@escaping WMSnapMakerBlock
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
        
        self.titleLabel?.adjustsFontSizeToFitWidth = true
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
                            snpMaker:WMSnapMakerBlock,
                            buttonClick:@escaping WMButtonClickBlock
        ) {
        
        
        self.xlpInitRootButton(title, titleColor: titleColor, fontSize: fontSize, backgroundColor: backgroundColor, imageStr: nil, backgroundImageStr: nil, cornerRedius: cornerRedius, superView: superView, snpMaker: snpMaker, buttonClick: buttonClick)
    }
    

    /// 生成具有点击效果的button 不需展示其外观效果
    func xlpInitFianlButton(_ title:String?,
                            titleColor:UIColor?,
                            fontSize:CGFloat?,
                            superView:UIView,
                            snpMaker:WMSnapMakerBlock,
                            buttonClick:@escaping WMButtonClickBlock
        ) {
        
        
        self.xlpInitRootButton(title, titleColor: titleColor, fontSize: fontSize, backgroundColor: .clear, imageStr: nil, backgroundImageStr: nil, cornerRedius: nil, superView: superView, snpMaker: snpMaker, buttonClick: buttonClick)
    }
    func xlpInitFianlButton(_ title:String?,
                            titleColor:UIColor?,
                            fontSize:CGFloat?,
                            superView:UIView,
                            snpMaker:WMSnapMakerBlock
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
       
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        superView.addSubview(self)
        
        self.snp.makeConstraints(snpMaker)
    }

    /// 带frame的button的初始化
    ///
    /// - Parameters:
    ///   - frame: <#frame description#>
    ///   - title: <#title description#>
    ///   - titleColor: <#titleColor description#>
    ///   - fontSize: <#fontSize description#>
    ///   - backgroundColor: <#backgroundColor description#>
    ///   - imageStr: <#imageStr description#>
    ///   - backgroundImageStr: <#backgroundImageStr description#>
    ///   - cornerRedius: <#cornerRedius description#>
    ///   - superView: <#superView description#>
    ///   - buttonClick: <#buttonClick description#>
    func xlpInitRootButtonFrame(_ frame:CGRect,
                           title:String?,
                           titleColor:UIColor?,
                           fontSize:CGFloat?,
                           backgroundColor:UIColor?,
                           imageStr:String?,
                           backgroundImageStr:String?,
                           cornerRedius:CGFloat?,
                           superView:UIView,
                           buttonClick:@escaping WMButtonClickBlock
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
        self.frame = frame
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        superView.addSubview(self)
        
        handle = buttonClick
        
        addTarget(self, action: #selector(xlpBtnClick(btn:)), for: .touchUpInside)
        
    }

    /// 带frame的按钮简化方法
    ///
    /// - Parameters:
    ///   - frame: <#frame description#>
    ///   - title: <#title description#>
    ///   - titleColor: <#titleColor description#>
    ///   - fontSize: <#fontSize description#>
    ///   - superView: <#superView description#>
    ///   - buttonClick: <#buttonClick description#>
    func xlpInitFinalButtonFrame(_ frame:CGRect,
                                 title:String?,
                                 titleColor:UIColor?,
                                 fontSize:CGFloat?,
                                 superView:UIView,
                                 buttonClick:@escaping WMButtonClickBlock){
        
        xlpInitRootButtonFrame(frame, title: title, titleColor: titleColor, fontSize: fontSize, backgroundColor: .clear, imageStr: nil, backgroundImageStr: nil, cornerRedius: nil, superView: superView, buttonClick: buttonClick)
        
    }
    
    func xlpInitButtonEassy(_ title:String?,
                       titleColor:UIColor?,
                       fontSize:CGFloat?,
                       backgroundColor:UIColor?,
                       imageStr:String?,
                       backgroundImageStr:String?,
                       cornerRedius:CGFloat?,
                       superView:UIView,
                       snpMaker:WMSnapMakerBlock) {
        
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
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        superView.addSubview(self)
        self.snp.makeConstraints(snpMaker)
        
        
    }
    
    
}



private var viewTapAssociate:String = "viewTapAssociate"

extension UIView{
    
    var myTapBlock:WMTapBlock{
        
        get {
            
            return objc_getAssociatedObject(self, &viewTapAssociate) as! WMTapBlock
        }
        
        set(newValue){
            objc_setAssociatedObject(self, &viewTapAssociate, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    func xlpInitView(frame:CGRect,superView:UIView) {
        
        self.frame = frame
        superView.addSubview(self)
        self.isUserInteractionEnabled = true
    }

    func xlpInitView(frame:CGRect,superView:UIView,tapBlock:@escaping WMTapBlock) {
        
        self.frame = frame
        superView.addSubview(self)
        myTapBlock = tapBlock
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapHandle(tap:)))
        tap.numberOfTapsRequired = 1
        addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    func xlpInitView(superView:UIView,snpMaker: WMSnapMakerBlock?) {
        
        superView.addSubview(self)
        if snpMaker != nil {
            self.snp.makeConstraints(snpMaker!)
        }
    }
    func xlpInitView(superView:UIView,snpMaker: WMSnapMakerBlock?,tapBlock:@escaping WMTapBlock) {
        
        superView.addSubview(self)
        if snpMaker != nil {
            self.snp.makeConstraints(snpMaker!)
        }
        myTapBlock = tapBlock
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapHandle(tap:)))
        tap.numberOfTapsRequired = 1
        addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }

    func tapHandle(tap:UITapGestureRecognizer)  {
        
        myTapBlock(tap)
    }
    
    
}

//FIXME: 暂时有一个bug,预留字体只能单行显示.还好一般不超过1行
// 预留字体的大小需与textview的字体大小一样
// textview必须设置其代理 否则无法检测其text 的内容的变化
//方法名设置为 属性类型的名字 方便调用
extension UITextView{
    
    
    var xlpPlaceholderLabel:UILabel{
        
        get {
            
            return objc_getAssociatedObject(self, &xlpAssociateTextViewLabel) as! UILabel
        }
        
        set(newValue){
            objc_setAssociatedObject(self, &xlpAssociateTextViewLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) //坑点是这里  若是字符串之类的属性 设为copy即可,若是控件类的关联属性 则需设置为 retain_nonatomic
        }
    }

    
    func xlpPlaceholder(_ placeholder:String,fontSize:CGFloat) {
        
        self.font = kFontWithSize(fontSize)
        //初始化label
        self.xlpPlaceholderLabel = UILabel()
        self.xlpPlaceholderLabel.xlpInitLabel(placeholder, textColor: UIColor.lightGray, fontSize:fontSize, isBold: false, aligenment: .left, backgroundColor: .clear, superView: self) { (make) in
            
            make.left.equalTo(5)
            make.top.equalTo(7)
            make.right.equalTo(self.snp.right).offset(-5)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(textViewChanged), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
    }
    func textViewChanged(notification:NSNotification)  {
        
        if kStringIsEmpty(self.text) {
            self.xlpPlaceholderLabel.isHidden = false
        }else{
            self.xlpPlaceholderLabel.isHidden = true

        }
        
    }

}
