//
//  CollectionCell.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/6/6.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit


class CollectionCell: UICollectionViewCell {
    
    var optionLabel = UILabel()
    let theWidth = 30
    
    var textStr : String?{
        
        didSet{
    
            optionLabel.text = textStr!
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func layoutViews() {
        
        optionLabel.xlpInitLabel(UIColor.lightGray, fontSize: 13, aligenment: .center, superView: contentView) { (make) in
            
            make.left.top.right.bottom.equalTo(0)
            make.width.equalTo(theWidth)
        }
        optionLabel.layer.borderColor = UIColor.lightGray.cgColor
        optionLabel.layer.borderWidth = 1
        optionLabel.layer.cornerRadius = CGFloat(theWidth / 2)
    }
}
