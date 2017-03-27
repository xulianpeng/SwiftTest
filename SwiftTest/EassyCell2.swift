//
//  EassyCell2.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/4.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import Kingfisher

class EassyCell2: UITableViewCell {

    var newsImage = UIImageView()
    var titleLabel = UILabel()
    var timeLabel = UILabel()
    var reviewImage = UIImageView()
    var reviewCountLabel = UILabel()
    var typeNameLabel = UILabel()
    
    func showValueWithModal(modal:EassyModal){
        titleLabel.text = modal.title
        
//        timeLabel.text = kObtainTimeWith(timestamp:modal.timestamp)
//        reviewCountLabel.text = "\(modal.replyNum)"
        
       
        
        let url:URL = URL.init(string: modal.thumbnail)!
        newsImage.setImageWith(url, placeholderImage: UIImage.init(named:"defaultCell"))
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutTheSubviews()
    }
    
    //这个方法 由 关键字 "require" 可知要求必须实现
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layoutTheSubviews() {
        
        newsImage = UIImageView()
        addSubview(newsImage)
        newsImage.isUserInteractionEnabled = true
        newsImage.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.width.equalTo(kSCREENWIDTH)
            make.height.equalTo(kSCREENWIDTH*3/4)
        }
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 1
        newsImage.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(newsImage.snp.bottom)
            make.left.equalTo(newsImage.snp.left).offset(10)
            make.right.equalTo(-10)
            
        }
        
//        timeLabel = UILabel()
//        timeLabel.font = UIFont.systemFont(ofSize: 12)
//        timeLabel.textColor = UIColor.lightGray
//        addSubview(timeLabel)
//        timeLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(titleLabel)
//            make.bottom.equalTo(newsImage)
//            
//        }
//        
//        reviewCountLabel = UILabel()
//        addSubview(reviewCountLabel)
//        reviewCountLabel.textColor = UIColor.blue
//        reviewCountLabel.font = UIFont.systemFont(ofSize: 12)
//        reviewCountLabel.snp.makeConstraints { (make) in
//            make.right.equalTo(-10)
//            make.bottom.equalTo(timeLabel)
//        }
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
