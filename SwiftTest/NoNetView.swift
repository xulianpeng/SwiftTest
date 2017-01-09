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

//protocol reloadHandleProtocol {
//    func reloadHandle()
//}
class NoNetView: UIView {

    var noDataImage = UIImageView()
    var titleLable = UILabel()
    var button = UIButton()
    
//    var noViewDelegate:reloadHandleProtocol?
    
    
    init(_ frame:CGRect, title:String,superView:UIView, reloaDataBlock1:@escaping reloadDataBlock)  {
        
        super.init(frame:frame)
        
        superView.addSubview(self)
        self.backgroundColor = UIColor.blue
//        self.snp.makeConstraints(snpMaker)
        
        noDataImage.initImageView("reloadImage", superView: self) { (make) in
            
            make.top.equalTo(snpTop)
            make.centerX.equalTo(self.snp.centerX)
            
        }
        
        titleLable.initLabel(title, textColor: .gray, fontSize: 14, backgroundColor: .clear, superView: self) { (make) in
            make.top.equalTo(noDataImage.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            
        }
        
        button.xlpInitButton("重新加载", titleColor: .gray, fontSize: 14, imageStr: nil, backgroundImageStr: nil, cornerRedius: 4, superView: self, snpMaker: { (make) in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(30)
        },buttonClick: reloaDataBlock1)
        
        
       
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
