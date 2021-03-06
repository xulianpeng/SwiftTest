//
//  WMUIExtension.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/27.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
//import SnapKit


//MARK: UILabel 的 extension
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
    //MARK:原始的初始化方式
    func initLabel(_ text:String?,
                   textColor:UIColor?,
                   fontSize:CGFloat,
                   isBold:Bool,
                   aligenment:NSTextAlignment,
                   backgroundColor:UIColor?,
                   superView:UIView,
                   snpMaker:WMSnapMakerBlock) {
        self.text = text;
        self.textColor = textColor
        if isBold {
            self.font = UIFont.boldSystemFont(ofSize: fontSize)
        }else{
            
            self.font = UIFont.systemFont(ofSize: fontSize)
        }
        self.textAlignment = aligenment
        self.backgroundColor = backgroundColor
        self.numberOfLines = 0;
        superView.addSubview(self)
        self.snp.makeConstraints(snpMaker)
        
    }
    func initLabel(_ text:String?,
                   textColor:UIColor?,
                   fontSize:CGFloat,
                   backgroundColor:UIColor?,
                   superView:UIView,
                   snpMaker:WMSnapMakerBlock) {
        self.initLabel(text, textColor: textColor, fontSize: fontSize, isBold: false, aligenment: .left, backgroundColor: backgroundColor, superView: superView, snpMaker: snpMaker)
    }
    func initLabel(_ text:String?,
                   superView:UIView,
                   snpMaker:WMSnapMakerBlock) {
        self.initLabel(text, textColor: kLabelTextColor, fontSize: kLabelFontSize, isBold: false, aligenment: .left, backgroundColor: .clear, superView: superView, snpMaker: snpMaker)
    }

    
    func xlpInitLabel(_ text:String?,
                   textColor:UIColor?,
                   fontSize:CGFloat,
                   isBold:Bool,
                   aligenment:NSTextAlignment,
                   backgroundColor:UIColor?,
                   superView:UIView,
                   snpMaker:WMSnapMakerBlock) {
        self.text = text;
        self.textColor = textColor
        if isBold {
            self.font = UIFont.boldSystemFont(ofSize: fontSize)
        }else{
            
            self.font = UIFont.systemFont(ofSize: fontSize)
        }
        self.textAlignment = aligenment
        self.backgroundColor = backgroundColor
        self.numberOfLines = 0;
        superView.addSubview(self)
        self.snp.makeConstraints(snpMaker)
        
    }
    func xlpInitLabel(_ textColor:UIColor?,
                      fontSize:CGFloat,
                      isBold:Bool,
                      aligenment:NSTextAlignment,
                      backgroundColor:UIColor?,
                      superView:UIView,
                      snpMaker:WMSnapMakerBlock) {
        
        xlpInitLabel(nil, textColor: textColor, fontSize: fontSize, isBold: isBold, aligenment: aligenment, backgroundColor: backgroundColor, superView: superView, snpMaker: snpMaker)
        
    }
    func xlpInitLabel(_ textColor:UIColor?,
                      fontSize:CGFloat,
                      aligenment:NSTextAlignment,
                      superView:UIView,
                      snpMaker:WMSnapMakerBlock) {
        
        xlpInitLabel(nil, textColor: textColor, fontSize: fontSize, isBold: false, aligenment: aligenment, backgroundColor: .clear, superView: superView, snpMaker: snpMaker)
        
    }
    
}



extension UIButton{
    
    typealias touchDownClickClosure = (_ sender:UIButton)->Void
    
    private struct xlp_associatedKeys{
        
        static  var s_XLPButtonTouchDownKey = "s_XLPButtonTouchDownKey";
        
    }
    
    private class buttonContainer{
        
        var touchDown :touchDownClickClosure?
        
    }
    // 定义个一个计算属性，通过OC的运行时获取关联对象和设置关联对象
    private var newDataBlock: buttonContainer?
        {
        get
        {
            if let newDataBlock = objc_getAssociatedObject(self, &xlp_associatedKeys.s_XLPButtonTouchDownKey) as? buttonContainer
            {
                return newDataBlock
            }
            return nil
        } // 如果计算属性的setter没有定义表示新值的参数名，则可以用默认值newValue
        set(newValue) {
            objc_setAssociatedObject(self, xlp_associatedKeys.s_XLPButtonTouchDownKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
//            self.removeTarget(self, action: Selector?, for: <#T##UIControlEvents#>)
//            self .removeTarget(self, action: #selector(newValue), for: .touchUpInside)
//            if ((newValue) != nil) {
//                self.addTarget(self, action: #selector(newValue), for: .touchUpInside)
//            }
        }
    }
    
    convenience init(buttonClick :touchDownClickClosure?)
    {
        self.init()
        
        let buttonContainer1:buttonContainer = buttonContainer()
        
        buttonContainer1.touchDown = buttonClick
        
        self.newDataBlock = buttonContainer1
        
    }
    
}


/*
typealias touchDownClickClosure = (_ mySender:UIButton)->Void

extension UIControl{
    
    
    private struct xlp_associatedKeys{
        
        static  var s_XLPButtonTouchDownKey = "s_XLPButtonTouchDownKey";
        
    }
    
     class buttonContainer{
    
//    struct  buttonContainer{
        var touchDown :touchDownClickClosure?
        
    }
    
    
    // 定义个一个计算属性，通过OC的运行时获取关联对象和设置关联对象
     var newDataBlock: buttonContainer?
        {
        get
        {
            if let newDataBlock = objc_getAssociatedObject(self, &xlp_associatedKeys.s_XLPButtonTouchDownKey) as? buttonContainer
            {
                return newDataBlock
            }
            return nil
        } // 如果计算属性的setter没有定义表示新值的参数名，则可以用默认值newValue
        set(newValue) {
            objc_setAssociatedObject(self, xlp_associatedKeys.s_XLPButtonTouchDownKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            
//                        self .removeTarget(self, action: #selector(newValue), for: .touchUpInside)
//                        if ((newValue) != nil) {
//                            self.addTarget(self, action: #selector(newValue), for: .touchUpInside)
//                        }
        }
    }
    
   
    
//    convenience init(buttonClick :touchDownClickClosure?)
//    {
//        self.init()
//        
//        let buttonContainer1:buttonContainer = buttonContainer()
//        
//        buttonContainer1.touchDown = buttonClick
//        
//        self.newDataBlock = buttonContainer1
//        
//    }
    
}
func onTouchDown(sender:UIButton) {
    
//    let myControl:UIControl = UIControl.init()
    
//        var touchDown:touchDownClickClosure  = myControl.buttonContainer.touchDown
    
    
}
 
 */
typealias WMButtonClickBlock1 = ((_ sender: Selector) -> ())
extension UIButton{
    
    func creatButton(_ title:String,titleColor:UIColor,imageStr:String,backgroundImageStr:String,cornerRedius:CGFloat,superView:UIView,_: WMButtonClickBlock1) -> Void{
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setImage(UIImage.init(named: imageStr), for: .normal)
        self.setBackgroundImage(UIImage.init(named: backgroundImageStr), for: .normal)
        self.layer.cornerRadius = cornerRedius
        self.layer.masksToBounds = true
        superView.addSubview(self)
    }

    func creatButton(_ title:String,titleColor:UIColor,imageStr:String,backgroundImageStr:String,cornerRedius:CGFloat,superView:UIView,myAction: Selector) -> Void{
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setImage(UIImage.init(named: imageStr), for: .normal)
        self.setBackgroundImage(UIImage.init(named: backgroundImageStr), for: .normal)
        self.layer.cornerRadius = cornerRedius
        self.layer.masksToBounds = true
        self.addTarget(self, action: myAction, for: .touchUpInside)
        superView.addSubview(self)
    }
    
    func creatButton(_ title:String?,titleColor:UIColor?,imageStr:String?,backgroundImageStr:String?,cornerRedius:CGFloat?,target:UIViewController,myAction: Selector?) {
        
        if title != nil {
            self.setTitle(title, for: .normal)
        }
        if titleColor != nil {
            self.setTitleColor(titleColor, for: .normal)
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
        if myAction != nil {
            self.addTarget(target, action: myAction!, for: .touchUpInside)
        }
        target.view.addSubview(self)
        
       
    }
    
    
    func creatButton(_ title:String?,titleColor:UIColor?,imageStr:String?,backgroundImageStr:String?,cornerRedius:CGFloat?,target:UIViewController,myAction: Selector?,snpMaker:WMSnapMakerBlock) {
        
        if title != nil {
            self.setTitle(title, for: .normal)
        }
        if titleColor != nil {
            self.setTitleColor(titleColor, for: .normal)
        }
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
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
        if myAction != nil {
            self.addTarget(target, action: myAction!, for: .touchUpInside)
        }
        target.view.addSubview(self)
       
        self.snp.makeConstraints(snpMaker)
    }
    
    //MARK: UIButton的扩展
    func initButton(_ title:String?,
                     titleColor:UIColor?,
                     fontSize:CGFloat?,
                     imageStr:String?,
                     backgroundImageStr:String?,
                     cornerRedius:CGFloat?,
                     target:Any,
                     myAction: Selector?,
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
        if myAction != nil {
            self.addTarget(target, action: myAction!, for: .touchUpInside)
        }
        if ((target as? UIViewController) != nil) {
            
            (target as AnyObject).view.addSubview(self)
        }else if ((target as? UIView) != nil) {
            (target as AnyObject).addSubview(self)
        }
        
        
        
        self.snp.makeConstraints(snpMaker)
        
    }

    
    func initButton(_ title:String?,
                 titleColor:UIColor?,
                 target:UIViewController,
                 myAction:Selector?,
                 snpMaker:WMSnapMakerBlock) {
        self.initButton(title,
                     titleColor: titleColor,
                     fontSize: kBtFontSize,
                     imageStr: nil,
                     backgroundImageStr: nil,
                     cornerRedius: kBtCornerRadius,
                     target: target,
                     myAction: myAction,
                     snpMaker: snpMaker)
        
    }
    
//     clickAction:buttonClickClosure
   /*
    func initButton(_ title:String?,
                    titleColor:UIColor?,
                    fontSize:CGFloat?,
                    imageStr:String?,
                    backgroundImageStr:String?,
                    cornerRedius:CGFloat?,
                    target:UIViewController,
                    myAction: Selector?,
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
        if myAction != nil {
            self.addTarget(target, action: myAction!, for: .touchUpInside)
        }
        target.view.addSubview(self)
        
        
        
        self.snp.makeConstraints(snpMaker)
        
        
        
    }
    
    
    private struct xlp_associatedKeys{
        
        static  var s_XLPButtonTouchDownKey = "s_XLPButtonTouchDownKey";
        
    }
    */
//    private var toHandler: buttonObject?{
//        
//        get{
//            if let newDataBlock = objc_getAssociatedObject(self, &xlp_associatedKeys.s_XLPButtonTouchDownKey) as? buttonObject
//            {
//                return newDataBlock
//            }
//            return nil
//        }
//        set(newValue){
//            objc_setAssociatedObject(self, xlp_associatedKeys.s_XLPButtonTouchDownKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//            
//        }
//    }
    
    
}



//MARK: UITextfield 的 extension
extension UITextField {
    
    //常做登录界面 用户名 密码输入框 预留字体高度自定义
    func initTextfield(_ textColor:UIColor?,
                       fontSize:CGFloat?,
                       alignment:NSTextAlignment,
                       placeholder:String?,
                       placeholderFontSize:CGFloat?,
                       placeholderColor:UIColor?,
                       isSecurity:Bool,
                       clearsOnBeginEditing:Bool,
                       delegate:Any,
                       superView:UIView,
                       snpMaker:WMSnapMakerBlock
        ){
        
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize!)
        self.textAlignment = alignment
        self.placeholder = placeholder
        self.setValue(placeholderColor, forKeyPath: "_placeholderLabel.textColor")
        self.setValue(placeholderFontSize, forKeyPath: "_placeholderLabel.font")
        self.isSecureTextEntry = isSecurity //是否密文输入
        self.delegate = delegate as? UITextFieldDelegate
        self.clearsOnBeginEditing = clearsOnBeginEditing
        self.clearButtonMode = .never //always never whileEditing  unlessEditing
        self.backgroundColor = .clear
        superView.addSubview(self)
        self.snp.makeConstraints(snpMaker)
        
    }
    //默认居中显示 预留字体默认显示
    func initTextfield(_ textColor:UIColor?,
                       fontSize:CGFloat?,
                       placeholder:String?,
                       isSecurity:Bool,
                       clearsOnBeginEditing:Bool,
                       delegate:Any,
                       superView:UIView,
                       snpMaker:WMSnapMakerBlock
        ){
        
        self.initTextfield(textColor, fontSize: fontSize, alignment: .center, placeholder: placeholder, placeholderFontSize: nil, placeholderColor: nil, isSecurity: isSecurity, clearsOnBeginEditing: clearsOnBeginEditing, delegate: delegate, superView: superView, snpMaker: snpMaker)
        
    }
    
    //普通的textfield
    func initTextfield(_ textColor:UIColor?,
                       fontSize:CGFloat?,
                       placeholder:String?,
                       delegate:Any,
                       superView:UIView,
                       snpMaker:WMSnapMakerBlock){
        
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize!)
        self.placeholder = placeholder
        self.delegate = delegate as? UITextFieldDelegate
        self.backgroundColor = .clear
        superView.addSubview(self)
        self.snp.makeConstraints(snpMaker)
        
    }
    func xlpInitTextfield(_ textColor:UIColor?,
                       fontSize:CGFloat?,
                       placeholder:String?,
                       delegate:Any,
                       boderstyle:UITextField.BorderStyle,
                       superView:UIView,
                       tag:Int,
                       snpMaker:WMSnapMakerBlock){
        
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize!)
        self.placeholder = placeholder
        self.delegate = delegate as? UITextFieldDelegate
        self.borderStyle = boderstyle
        self.tag = tag
        self.backgroundColor = .clear
        superView.addSubview(self)
        self.snp.makeConstraints(snpMaker)
        
    }

    func xlpInitTextfieldDefault(_ textColor:UIColor?,
                          fontSize:CGFloat?,
                          placeholder:String?,
                          delegate:Any,
                          tag:Int,
                          superView:UIView,
                          snpMaker:WMSnapMakerBlock){
        
        xlpInitTextfield(textColor, fontSize: fontSize, placeholder: placeholder, delegate: delegate, boderstyle: .roundedRect, superView: superView, tag: tag, snpMaker: snpMaker)
        
    }

}

//MARK:UIImageView 的 extension

extension UIImageView {
    
    func initImageView(_ name:String?,superView:UIView,snpMaker:WMSnapMakerBlock) {
        
        if name != nil {
            
            self.image = UIImage.init(named: name!)
        }
        superView.addSubview(self)
        self.snp.makeConstraints(snpMaker)
    }
}
//MARK:UITableview 的 extension

extension UITableView{
    
    //由于其style只能通过初始化方式设置,故只做简单补充
    //默认颜色是 clear
    func initTableView(delegate:Any,superView:UIView) {
        
        self.backgroundColor = .clear
        self.delegate = delegate as? UITableViewDelegate
        self.dataSource = delegate as? UITableViewDataSource
        self.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        //cellClass
        /*
        if cellClass != nil {
            
            for cell in cellClass! {
                
                let identifier:String =  NSStringFromClass(cell!) as String
                print(identifier)
                self.register(cell, forCellReuseIdentifier: identifier)
            }
        }*/
        superView.addSubview(self)
        
        
    }
    func initTableView(delegate:Any,superView:UIView,cellClass:[AnyClass?]?) {
        
        self.backgroundColor = .clear
        self.delegate = delegate as? UITableViewDelegate
        self.dataSource = delegate as? UITableViewDataSource
        self.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        //cellClass
        
        if cellClass != nil {
            
            for cell in cellClass! {
                
                let identifier:String =  NSStringFromClass(cell!) as String
                var lastStr :String = ""
                if identifier.components(separatedBy: ".").count > 0 {
                    lastStr = identifier.components(separatedBy: ".").last!
                }
                self.register(cell, forCellReuseIdentifier: lastStr)
            }
        }
        superView.addSubview(self)
        
        
    }
    
    func xlpInitTableViewEnd(delegate:Any,superView:UIView,cellClass:[AnyClass?]?)  {
    
        self.backgroundColor = .clear
        self.delegate = delegate as? UITableViewDelegate
        self.dataSource = delegate as? UITableViewDataSource
        self.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        if cellClass != nil {
            
            for cell in cellClass! {
                
                let identifier:String =  NSStringFromClass(cell!) as String
                var lastStr :String = ""
                if identifier.components(separatedBy: ".").count > 0 {
                    lastStr = identifier.components(separatedBy: ".").last!
                }
                self.register(cell, forCellReuseIdentifier: lastStr)
            }
        }
        superView.addSubview(self)
    }
}
class WMUIExtension: NSObject {

}


