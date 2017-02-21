//
//  myCollectionViewCell.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/2/21.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class myCollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var littleTitleLabel = UILabel()
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        titleLabel.frame = CGRect(x:5,y:5,width:70,height:30)
        titleLabel.backgroundColor = UIColor.green
        addSubview(titleLabel)
        
//        littleTitleLabel.frame = CGRect(x:10,y:50,width:100,height:20)
        addSubview(littleTitleLabel)
        
        littleTitleLabel.initLabel(nil, superView: self.contentView) { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        littleTitleLabel.backgroundColor = UIColor.purple
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
