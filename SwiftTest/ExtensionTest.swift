//
//  ExtensionTest.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/30.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit


//MARK: Button 修饰

typealias buttonClickClosure = (()->Void)

class buttonObject: NSObject {
    var function: buttonClickClosure?
    
    func invokeClosure(_ sender: Any){
        function!()
    }
}

typealias tapHandler = (_ sender:UIButton) -> ()

extension UIButton {
    
    
    
    private struct xlp_associatedKeys{
        
        static  var s_XLPButtonTouchDownKey = "s_XLPButtonTouchDownKey";
        
    }
    
    // 定义个一个计算属性，通过OC的运行时获取关联对象和设置关联对象
    private var buttonObjectClick: buttonObject?
        {
        get
        {
            return objc_getAssociatedObject(self, xlp_associatedKeys.s_XLPButtonTouchDownKey) as! buttonObject?
        } // 如果计算属性的setter没有定义表示新值的参数名，则可以用默认值newValue
        set(newValue) {
            
            
            objc_setAssociatedObject(self, xlp_associatedKeys.s_XLPButtonTouchDownKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func useBlock() {
        self.buttonObjectClick?.function!()
    }
    //MARK: UIButton的扩展    //myAction: Selector?,
    func initButton5(_ title:String?,
                    titleColor:UIColor?,
                    fontSize:CGFloat?,
                    imageStr:String?,
                    backgroundImageStr:String?,
                    cornerRedius:CGFloat?,
                    target:UIViewController,
                    
                    snpMaker:WMSnapMakerBlock,
                    buttonClick:@escaping buttonClickClosure
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
//        if myAction != nil {
//            self.addTarget(target, action: myAction!, for: .touchUpInside)
//        }
        
        self.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)

        target.view.addSubview(self)
        
        self.snp.makeConstraints(snpMaker)
        
        let functionhandler = buttonObject.init()
        functionhandler.function = buttonClick
        
        self.buttonObjectClick = functionhandler
        
        self.addTarget(self, action: #selector(clickMe), for: .touchUpInside)
        
    }
    
    func clickMe() -> Void {
        print("==========点w啊啊===============")
    }
    
    
    struct handStruct {
        var handler: tapHandler!
    }
    
    func btnClick(btn:UIButton){
        ///调用block
//        let theHander = tapHandler!()
//        
//        handStruct.init(handler: theHander)
        
    }
}

class ExtensionTest: NSObject {

}
