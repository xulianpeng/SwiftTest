//
//  commentCell.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/4/17.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class commentCell: UITableViewCell {

    var  headImageView = UIImageView()
    var  oneNameLabel = UILabel()
    var  oneLevelLabel = UILabel()
    var  oneCreatedTimeLabel = UILabel()
    var  oneContentLabel = UILabel()
    var  supportLabel = UILabel()
    var  supportBt = UIButton()
    var  replyBt = UIButton()
    var  line = UILabel()
//    var  TGArticleCommentOne *commentOne;
    var  imagesArray = [String]()
    var  reportBt = UIButton()
    
    func initMdole(_ model:NewsCommentModel) {
        
        headImageView.xlpSetImage(model.headUrl!, placeholder: "defaultCell")
        oneNameLabel.text = model.oneName
        oneCreatedTimeLabel.text = kTimeCpmpareWithNow(model.oneCreated!)
        oneContentLabel.text = model.oneContent
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        
    }
    func initUI()  {
        headImageView.xlpInitImageView(self.contentView, corner: 15, snapMaker: { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        })
        oneNameLabel.xlpInitLabel(kRGB(r: 45, g: 78, b: 128, alpha: 1.0), fontSize: 13, aligenment: .left, superView: self.contentView, snpMaker: { (make) in
            make.left.equalTo(headImageView.snp.right).offset(10)
            make.top.equalTo(headImageView)
            make.height.equalTo(20)
        })
        oneCreatedTimeLabel.xlpInitLabel(kRGB(r: 112, g: 112, b: 112, alpha: 1.0), fontSize: 10, aligenment: .left, superView: self.contentView, snpMaker: { (make) in
            make.left.equalTo(oneNameLabel)
            make.bottom.equalTo(headImageView)
            make.height.equalTo(kFontWithSize(10).lineHeight)
        })
        oneContentLabel.xlpInitLabel(.black, fontSize: 16, aligenment: .left, superView: self.contentView, snpMaker: { (make) in
            make.left.equalTo(headImageView)
            make.top.equalTo(headImageView.snp.bottom).offset(10)
            make.right.equalTo(-5)
            make.bottom.equalTo(-5)
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
