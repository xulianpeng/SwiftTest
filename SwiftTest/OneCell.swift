//
//  OneCell.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/10.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
import SnapKit

class OneCell: UITableViewCell {

    
    //类似OC的属性变量的声明 在外部可被调用
    var nameLabel : UILabel!
    var classLabel : UILabel!
    var clickBt = UIButton.init(type:UIButton.ButtonType.custom)
    
    //自定义赋值方法
    func showViewWithModal(modal:OneModal){
        nameLabel.text = modal.name1
        classLabel.text = modal.name2
    }
    
    //重载 初始化方法
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutTheSubviews()
    }
    
    //这个方法 由 关键字 "require" 可知要求必须实现
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutTheSubviews() {
        
        nameLabel = UILabel.init()
//        nameLabel.frame = CGRect(x:10,y:5,width:100,height:30)
        
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = UIColor.brown
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.width.equalTo(100)
            
        }
        
        classLabel = UILabel.init()
//        classLabel.frame = CGRect(x:10,y:40,width:100,height:30)
        classLabel.font = UIFont.systemFont(ofSize: 12)
        classLabel.textColor = UIColor.green
        addSubview(classLabel)
        classLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(-10)
            make.width.equalTo(100)
        }
        
        
//        clickBt.frame = CGRect(x:kSCREENWIDTH - 10 - 50,y:15,width:50,height:50)
        
        contentView.addSubview(clickBt)
        
        clickBt.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.top)
            make.right.equalTo(-20)
            make.width.height.equalTo(60)
        }
        clickBt.backgroundColor = UIColor.yellow
        clickBt .setTitle("点击", for: .normal)
        clickBt .setTitleColor(UIColor.purple, for:UIControl.State.normal)
        clickBt.layer.cornerRadius = 5
    }
    
    

    
    
    //下面是已有的方法
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
