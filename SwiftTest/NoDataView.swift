//
//  NoDataView.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/6/29.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class NoDataView: UIView {

    
    private var noDataImageView = UIImageView()
    private var noDataLabel = UILabel()
    
    let imageWidth = 100
//    {
//        
//        set{
//            
//        }
//        get{
//            return 
//        }
//    }//图片的宽度 可定制
    
    
    
    init(superView:UIView,imageName:String?,str:String?,snapBlock:WMSnapMakerBlock) {
        super.init(frame: CGRect.zero)
        superView.addSubview(self)
        self.snp.makeConstraints(snapBlock)
        
        self.addSubview(noDataImageView)
        
        noDataImageView.snp.makeConstraints { (make) in
            
            make.width.height.equalTo(imageWidth)
            make.center.equalTo(self.snp.center)
        }
        if imageName != nil{
            
            noDataImageView.image = UIImage.init(named: imageName!)
        }else{
            //给一个默认的
//            noDataImageView.image = UIImage.init(named: imageName!)

        }
        
        if str != nil{
            
            noDataLabel.xlpInitLabel(UIColor.black, fontSize: 14, aligenment: .center, superView: self) { (make) in
                make.top.equalTo(noDataImageView.snp.bottom).offset(20)
                make.left.equalTo(10)
                make.right.equalTo(-10)
            }
            noDataLabel.text = str!
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

}
