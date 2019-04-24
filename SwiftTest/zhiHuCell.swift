//
//  zhiHuCell.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/4.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

let kImageViewHeight = (kSCREENWIDTH-20)/4


class zhiHuCell: UITableViewCell {

    var titleLable:UILabel?
    var rightImage:UIImageView?
    private var theModal :zhiHuCellModel?
    
    var zhihuModel:zhiHuCellModel?{
        
        get {
            
            return theModal
        }
        
        
        set {
            
            theModal = newValue
            
            showWithCellModal(modal: theModal!)
        }
    }
    
    func showWithCellModal(modal:zhiHuCellModel)  {
        
        self.titleLable?.text = modal.title
        
        let url:URL = URL.init(string: modal.imageURL!)!
        
        self.rightImage?.setImageWith(url, placeholderImage: UIImage.init(named:"defaultCell"))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutTheSubviews()
    }
    
    func layoutTheSubviews()  {
        
        titleLable = UILabel()
        titleLable?.initLabel(nil, textColor: .black, fontSize: 14, backgroundColor: .clear, superView: contentView, snpMaker: { (make) in
            make.left.top.equalTo(10)
            make.width.equalTo((kSCREENWIDTH - 20)/3*2)
        })
        
        rightImage = UIImageView()
        rightImage?.initImageView(nil, superView: contentView, snpMaker: { (make) in
            make.left.equalTo((titleLable?.snp.right)!).offset(5)
            make.top.equalTo((titleLable?.snp.top)!)
            make.right.equalTo(-10)
            make.height.equalTo(kImageViewHeight)
            
        })
    }
    //这个方法 由 关键字 "require" 可知要求必须实现
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
