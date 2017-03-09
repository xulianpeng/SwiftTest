//
//  NoNetView.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/4.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SnapKit

let snpTop = 200
/// 断网提示页面 包括提示信息和点击重新加载按钮

typealias reloadDataBlock = (_ sender:UIButton)->Void
typealias reloadDataWMTapBlock = (_ sender:UITapGestureRecognizer)->Void

enum NoNetViewStyle {
    case Both
    case OnlyImage
    case OnlyText
}
class NoNetView: UIView {

    var noDataImage = UIImageView()
    var titleLable = UILabel()
    var button = UIButton()
    
    var imageHeight = 100
    var buttonHeight = 40
    
    
    /// 无图 有图 有文案 有点击重新加载事件
    /// 该方法舍弃
    /// - Parameters:
    ///   - frame: <#frame description#>
    ///   - title: <#title description#>
    ///   - superView: <#superView description#>
    ///   - reloaDataBlock1: <#reloaDataBlock1 description#>
    init(_ frame:CGRect, title:String,superView:UIView,reloaDataBlock1:@escaping reloadDataBlock)  {
        
        super.init(frame:frame)
        
        superView.addSubview(self)
        
        noDataImage.initImageView("reloadImage", superView: self) { (make) in
            
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(100)
            
        }
        
        titleLable.initLabel(title, textColor: .white, fontSize: 14, isBold: false, aligenment: .center, backgroundColor: .clear, superView: self) { (make) in
            make.top.equalTo(noDataImage.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        
        button.xlpInitFianlButton("点击重新加载", titleColor: .white, fontSize: 18, superView: self, snpMaker: { (make) in
            make.top.equalTo(titleLable.snp.bottom).offset(15)
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(30)
            
        }, buttonClick: reloaDataBlock1)
        
       
        
    }
    
    /// 修改按钮的文案
    ///
    /// - Parameter text: 新的文案信息
    func initWithButtonText(text:String){
        
        button.setTitle(text, for: UIControlState.normal)
    }

    
    /// 推荐这个NONetView
    ///
    /// - Parameters:
    ///   - offsetY: y轴偏移量
    ///   - title: 提示信息
    ///   - style: 分3种 图文 只有图 只有文案
    ///   - superView: nonetview本身
    ///   - reloaDataBlock1: 重新加载的点击事件
    init(_ offsetY:CGFloat, title:String,style:NoNetViewStyle,superView:UIView,reloaDataBlock1:@escaping reloadDataBlock)  {
        
        super.init(frame:CGRect.zero)
        
        self.frame = CGRect(x:0,y:offsetY,width:kSCREENWIDTH,height:kSCREENHEIGHT  - offsetY)
        
        superView.addSubview(self)
        
        
        
        
        ///不加 default 的话 就穷举所有的情况
        switch style {
        case .Both:
            print("有图有文案")
//            defaultInt()
            
            noDataImage.initImageView("reloadImage", superView: self) { (make) in
                
                make.centerX.equalTo(self.snp.centerX)
                make.centerY.equalTo(self.snp.centerY)
                make.width.height.equalTo(imageHeight)
                
            }
            
            titleLable.initLabel(title, textColor: .white, fontSize: 14, isBold: false, aligenment: .center, backgroundColor: .clear, superView: self) { (make) in
                make.top.equalTo(noDataImage.snp.bottom).offset(15)
                make.left.equalTo(self.snp.left).offset(10)
                make.right.equalTo(self.snp.right).offset(-10)
            }
            
            button.xlpInitFianlButton("点击重新加载", titleColor: .white, fontSize: 18, superView: self, snpMaker: { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(15)
                make.left.equalTo(40)
                make.right.equalTo(-40)
                make.height.equalTo(buttonHeight)
                
            }, buttonClick: reloaDataBlock1)
            
        case .OnlyImage:
            print("只有图")
//            onlyImage()
            noDataImage.initImageView("reloadImage", superView: self) { (make) in
                
                make.centerX.equalTo(self.snp.centerX)
                make.centerY.equalTo(self.snp.centerY)
                make.width.height.equalTo(imageHeight)
                
            }
            button.xlpInitFianlButton("点击重新加载", titleColor: .white, fontSize: 18, superView: self, snpMaker: { (make) in
                make.top.equalTo(noDataImage.snp.bottom).offset(15)
                make.left.equalTo(40)
                make.right.equalTo(-40)
                make.height.equalTo(buttonHeight)
                
            }, buttonClick: reloaDataBlock1)
            
            
        case .OnlyText:
            print("只有文案")
//            onlyText()
            titleLable.initLabel(title, textColor: .white, fontSize: 14, isBold: false, aligenment: .center, backgroundColor: .clear, superView: self) { (make) in
                make.center.equalTo(self.snp.center)
                make.left.equalTo(self.snp.left).offset(10)
                make.right.equalTo(self.snp.right).offset(-10)
            }
            button.xlpInitFianlButton("点击重新加载", titleColor: .white, fontSize: 18, superView: self, snpMaker: { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(15)
                make.left.equalTo(40)
                make.right.equalTo(-40)
                make.height.equalTo(buttonHeight)
                
            }, buttonClick: reloaDataBlock1)

            
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class NoNetTast: UIView,UIGestureRecognizerDelegate {
    
    init(_ text:String,superView:UIView,WMTapBlock:@escaping reloadDataWMTapBlock) {
        
//        let aFrame = CGRect(x:0,y:0,width:kSCREENWIDTH,height:64)
        super.init(frame: CGRect.zero)
        
        
        
//        self.initView(frame: aFrame, superView: superView, snpMaker: nil, WMTapBlock: WMTapBlock)
        
        self.initView(superView: superView, snpMaker: { (make) in
            make.left.top.equalTo(0)
//            make.right.equalTo(0)
            make.width.equalTo(kSCREENWIDTH)
            make.height.equalTo(64)
        }, tapBlock: WMTapBlock)
        self.backgroundColor = UIColor.yellow
        
        
        let label:UILabel = UILabel()
        label.initLabel(text, textColor: .black, fontSize: 16, isBold: false, aligenment: .left, backgroundColor: .purple, superView: self) { (make) in
            make.left.equalTo(20)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(self.snp.height)
        }
        label.isUserInteractionEnabled = true
        

        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
