//
//  zhiHuTopCell.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/4.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

let kTopCellHeight = 180

class zhiHuTopCell: UITableViewCell {

    
    var scrollView:UIScrollView = UIScrollView()
    //轮播图  加一个定时器 定时2s自动轮播 转到头 则往回轮播
    
    func showWithModals(modals:[zhiHuTopCellModel])  {
        
        scrollView.contentSize = CGSize(width:SCREENWIDTH * CGFloat(modals.count),height:CGFloat(kTopCellHeight))

        var i = 0
        
        for  myModal:zhiHuTopCellModel in modals {
            
            let imageView = UIImageView()
            let titleLabel = UILabel()
            
            imageView.frame = CGRect(x:Int(SCREENWIDTH) * i,y:0,width:Int(SCREENWIDTH),height:kTopCellHeight)
            imageView.isUserInteractionEnabled = true
            
            
            titleLabel.initLabel(myModal.title, textColor: .black, fontSize: 14, backgroundColor: .gray, superView: imageView, snpMaker: { (make) in
                
                make.left.equalTo(5)
                make.bottom.equalTo(-3)
                make.right.equalTo(-5)
                make.height.equalTo(30)
            })
            
            imageView.setImageWith( URL.init(string:myModal.imgeURL!)!)
            scrollView.addSubview(imageView)
            i += 1
        }
        
        let timer = Timer.init(timeInterval: 2, repeats: false) { (aTimer) in
            
            print("定时器啦啦啦")
            
        }
        
        
        

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutTheSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutTheSubviews() {
        
        scrollView = UIScrollView.init(frame: CGRect(x:0,y:0,width:Int(SCREENWIDTH),height:kTopCellHeight))
        addSubview(scrollView)
        scrollView.backgroundColor = .red
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
