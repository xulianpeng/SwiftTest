//
//  xlpHud.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/2/16.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit


/// 相比 MBProgressHud的长处
/*
 
 当MBProgressHud的mode为 text时,有4个限制:
 1.显示的时候 无法交互 比如显示提示信息时 无法滚动 ,
 2.是 text的内容过长时,会以省略号显示,没有自动换行,
 3.显示的位置 不能直接定义, 
 4.其背景色的属性 已弃用.
 
 */


/// 提示框类
class xlpHud: UIView {

    
    let kHudFont = UIFont.systemFont(ofSize: 14) //修改字体
    let kHudFontColor:UIColor = UIColor.yellow   //修改字体颜色
    let kHudBackgroundColor:UIColor = RGB(r: 0, g: 0, b: 0, alpha: 0.8)//修改背景色
    let kPading:Int = 10
    let kViewPading:Int = 10

     /// 初始化方法
     ///
     /// - Parameters:
     ///   - text: 展示文本
     ///   - constransY: y坐标
     init(text:String,constransY:CGFloat) {
        super.init(frame: CGRect.zero)
        
        let myString:String = text

        ///富文本相关的设置
        let aStyle = NSMutableParagraphStyle.init()
        aStyle.lineSpacing = 0 //行间距
        aStyle.alignment = NSTextAlignment.left
        aStyle.firstLineHeadIndent = 10 //起始行开始的距离
        let aAttritString = NSMutableAttributedString.init(string: myString)
        aAttritString.addAttributes([NSFontAttributeName:kHudFont,NSParagraphStyleAttributeName:aStyle], range: NSMakeRange(0, aAttritString.length))
        
        
        
        let maxSize = CGSize(width:SCREENWIDTH - CGFloat(kPading * 2), height:
            SCREENHEIGHT)
        let aSize:CGRect = aAttritString.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin,.truncatesLastVisibleLine,.usesDeviceMetrics],context: nil)
        
        let aWidth:CGFloat = aSize.size.width + CGFloat(kPading)
        let aheight:CGFloat = aSize.size.height + CGFloat(kPading)
        let aX = Int(SCREENWIDTH)/2 - Int(aWidth)/2 - kPading/2
        
        let textLabel:UILabel = UILabel.init(frame: CGRect(x:CGFloat(kPading/2),y:CGFloat(kPading/2),width:aSize.width,height:aSize.height))
        
        textLabel.backgroundColor = UIColor.clear
        textLabel.attributedText = aAttritString
        textLabel.font = kHudFont
        textLabel.textColor = kHudFontColor
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        
        self.frame = CGRect(x:CGFloat(aX) + CGFloat(kPading/2),y:constransY,width:aWidth,height:aheight)
        self.layer.cornerRadius = 5
        self.backgroundColor = kHudBackgroundColor
        self.addSubview(textLabel)
        self.isHidden = true;
        self.alpha = 0.0;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        
        let window :UIWindow = UIApplication.shared.windows.first!
        window.addSubview(self)
        self.isHidden = false;
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
        }
        
    }
    
    func hideWhenAfter(time:CGFloat) {
        var aTime = time
        if (aTime < 0.30) {
            aTime = 0.30
        }
        UIView.animate(withDuration: 1, delay: TimeInterval(aTime), options: [.transitionCrossDissolve,.curveEaseInOut], animations: {
            self.alpha = 0.0
        }) { (true) in
            self.removeFromSuperview()
        
        }
    }

   

}
