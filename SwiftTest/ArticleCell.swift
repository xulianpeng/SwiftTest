//
//  ArticleCell.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/24.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    var newsImage = UIImageView()
    var titleLabel = UILabel()
    var reviewImage = UIImageView()
    var reviewCountLabel = UILabel()
    var timeLabel = UILabel()
    var typeImage = UIImageView()
    var typeName = UILabel()

    func showWithModel(_ model:Article) {
        
        newsImage.xlpSetImage(model.thumbnail!, placeholder: "defaultCell")
        titleLabel.text = model.title
        timeLabel.text = kTimeCpmpareWithNow(model.timeStamp!)
        reviewCountLabel.text = "\(model.replyNum!)"
        
        let typeLength = kStringGetSize(model.type, font: kFontWithSize(10), maxSize: CGSize(width:kSCREENWIDTH,height:kSCREENHEIGHT))
        typeName.snp.updateConstraints { (make) in
            make.width.equalTo(typeLength.width)
        }
        typeName.text = model.type

        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    func setupView() {
        
        let imgaeWidth = (kSCREENWIDTH/3 - 10) * 7 / 6
        let imgaeHeight = (kSCREENWIDTH/3 - 10) * 2 / 3
        newsImage.xlpInitImageView(self.contentView, corner: 3) { (make) in
            
            make.left.equalTo(7)
            make.top.equalTo(5)
            make.width.equalTo(imgaeWidth)
            make.height.equalTo(imgaeHeight)
        }
        
        
        
        titleLabel.xlpInitLabel(.black, fontSize: 13, aligenment: .left, superView: self.contentView) { (make) in
            make.left.equalTo(newsImage.snp.right).offset(10)
            make.top.equalTo(newsImage)
            make.right.equalTo(-7)
            make.height.equalTo(40)
            
        }
        typeName.xlpInitLabel(.gray, fontSize: 10, aligenment: .left, superView: self.contentView) { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(newsImage)
            make.width.equalTo(0)
            make.height.equalTo(kFontWithSize(10).lineHeight)
        }
        timeLabel.xlpInitLabel(.gray, fontSize: 10, aligenment: .left, superView: self.contentView) { (make) in
            make.left.equalTo(typeName.snp.right).offset(5)
            make.top.equalTo(typeName)
            make.height.equalTo(typeName)
        }
        reviewCountLabel.xlpInitLabel(kRGB(r: 112, g: 112, b: 112, alpha: 1.0), fontSize: 10, aligenment: .left, superView: self.contentView) { (make) in
            make.right.equalTo(-7)
            make.top.equalTo(timeLabel)
            make.width.equalTo(30)
            make.height.equalTo(kFontWithSize(10).lineHeight)
        }
        reviewImage.xlpInitImageView("commentNum", superView: self.contentView, corner: 0) { (make) in
            make.right.equalTo(reviewCountLabel.snp.left).offset(-3)
            make.bottom.equalTo(newsImage)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        
        
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
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

class ArticleTopCell: UITableViewCell {
    
    var newsImage = UIImageView()
    var titleLabel = UILabel()
 
    func showWithModel(_ model:Article) {
        newsImage.xlpSetImage(model.thumbnail!, placeholder: "defaultCell")
        titleLabel.text = model.title
       
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    func setupView() {
        
        newsImage.xlpInitImageView(self.contentView, corner: 3) { (make) in
            
            make.left.equalTo(7)
            make.top.equalTo(5)
            make.right.equalTo(-7)
            make.height.equalTo(kSCREENWIDTH/1.75)
        }

        titleLabel.xlpInitLabel(.white, fontSize: 13, aligenment: .left, superView: newsImage) { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(newsImage.snp.bottom).offset(-5)
            make.right.equalTo(-10)
            make.height.equalTo(kFontWithSize(13).lineHeight)
            
        }
        
        
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
