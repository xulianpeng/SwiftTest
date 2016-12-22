//
//  EassyCell.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/20.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
import Kingfisher
class EassyCell: UITableViewCell {

    var newsImage = UIImageView()
    var titleLabel = UILabel()
    var timeLabel = UILabel()
    var reviewImage = UIImageView()
    var reviewCountLabel = UILabel()
    var typeNameLabel = UILabel()
    
    func showValueWithModal(modal:EassyModal){
        titleLabel.text = modal.title
        
        timeLabel.text = obtainTimeWith(timestamp:modal.timestamp)
        reviewCountLabel.text = "\(modal.replyNum)"
        
        /*
        if let url = NSURL(string:modal.thumbnail) {
            let data = NSData(contentsOf:url as URL)
            
            newsImage.image = UIImage.init(data: data as! Data)
        }
        */
        
        let url:URL = URL.init(string: modal.thumbnail)!
        newsImage.setImageWith(url, placeholderImage: UIImage.init(named:"cellImage"))
        
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
        newsImage.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.width.equalTo(SCREENWIDTH/3)
            make.height.equalTo(SCREENWIDTH/4)
        }
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(newsImage)
            make.left.equalTo(newsImage.snp.right)
            make.right.equalTo(-10)
            
        }
        
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.lightGray
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(newsImage)
            
        }
        
        reviewCountLabel = UILabel()
        addSubview(reviewCountLabel)
        reviewCountLabel.textColor = UIColor.blue
        reviewCountLabel.font = UIFont.systemFont(ofSize: 12)
        reviewCountLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(timeLabel)
        }
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
