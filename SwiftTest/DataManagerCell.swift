//
//  DataManagerCell.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/28.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class DataManagerCell: UITableViewCell {

    var titleLabel = UILabel()
    var dataCountLabel = UILabel()
    var lookBt = UIButton()
    var downBt = UIButton()

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
    }
    func initViews() {
        titleLabel.xlpInitLabel(.black, fontSize: 16, aligenment: .left, superView: self.contentView, snpMaker: { (make) in
            make.left.equalTo(20)
            make.top.equalTo(5)
            make.height.equalTo(kFontWithSize(14).lineHeight)
        })
        dataCountLabel.xlpInitLabel(kRGB(r: 115, g: 115, b: 115, alpha: 1.0), fontSize: 12, aligenment: .left, superView: self.contentView, snpMaker: { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.height.equalTo(kFontWithSize(10).lineHeight)
        })

        downBt.xlpInitButtonEassy("下载", titleColor: .green
            , fontSize: 13,backgroundColor:nil, imageStr: nil, backgroundImageStr: nil, cornerRedius: 3, superView: self.contentView, snpMaker: { (make) in
                make.right.equalTo(-20)
                make.size.equalTo(CGSize(width:50,height:25))
                make.centerY.equalTo(self.contentView.snp.centerY)
        })
        downBt.layer.borderColor = UIColor.green.cgColor
        downBt.layer.borderWidth = 1
        
        lookBt.xlpInitButtonEassy("查看内容△", titleColor: .gray, fontSize: 12, backgroundColor: nil, imageStr: nil, backgroundImageStr: nil, cornerRedius: nil, superView: self.contentView, snpMaker: { (make) in
            make.right.equalTo(downBt.snp.left).offset(-5)
            make.bottom.equalTo(dataCountLabel)
            make.height.equalTo(kFontWithSize(12).lineHeight)
        })
    }
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
