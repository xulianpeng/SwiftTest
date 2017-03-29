//
//  DataManagerSubCell.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/28.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class DataManagerSubCell: UITableViewCell {

    var seriesImage = UIImageView()
    var titleLabel = UILabel()
    var countLabel = UILabel()
    var downBt = UIButton()
    
    func showWithSeries(_ series:SeriesHearthStone) {
        
//        self.seriesImage.xlpSetImage(<#T##urlStr: String##String#>, placeholder: <#T##String#>)
        self.titleLabel.text = series.name
        var size = 0
        if series.size != nil {
            size = series.size!
        }
        self.countLabel.text = "数据大小为" + "\(Double(size) * 0.1)" + "M"
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
    }
    func initViews() {
        seriesImage.xlpInitImageView(contentView, corner: 0, contentmode: .scaleToFill) { (make) in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.width.height.equalTo(30)
        }
        titleLabel.xlpInitLabel(.black, fontSize: 14, aligenment: .left, superView: contentView) { (make) in
            make.left.equalTo(seriesImage.snp.right).offset(10)
            make.top.equalTo(seriesImage)
            make.height.equalTo(kFontWithSize(14).lineHeight)
        }
        countLabel.xlpInitLabel(.gray, fontSize: 12, aligenment: .left, superView: contentView) { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.top.equalTo(seriesImage)
            make.height.equalTo(kFontWithSize(12).lineHeight)
        }
        downBt.xlpInitButtonEassy("下载", titleColor: UIColor.cyan, fontSize: 13, backgroundColor: nil, imageStr: nil, backgroundImageStr: nil, cornerRedius: 3, superView: contentView) { (make) in
            make.right.equalTo(-20)
            make.height.equalTo(25)
            make.width.equalTo(50)
            make.centerY.equalTo(contentView)
        }
        downBt.layer.borderWidth = 1
        downBt.layer.borderColor = UIColor.cyan.cgColor
        
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
