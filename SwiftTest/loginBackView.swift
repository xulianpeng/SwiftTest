//
//  loginBackView.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/11/22.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class loginBackView: UIView,UITableViewDelegate {

    var BannerImageView : UIImageView = UIImageView()
    var backScrollview : UITableView = UITableView()
    var oriImageHeight : CGFloat = 0
    
    var contentView : UIView = UIView()
    
    /*
    override init(frame:CGRect) {
        super.init(frame:frame)
    
        oriImageHeight = kSCREENHEIGHT * 1 / 3
        
        //        frame.size = CGSize(width:kSCREENWIDTH,height:kSCREENHEIGHT)
//        BannerImageView.xlpInitImageView("login_banner", superView: self, corner: 0) { (make) in
//
//            make.top.equalTo(0)
//            make.centerX.equalTo(self)
//            make.width.equalTo(kSCREENWIDTH)
//            make.height.equalTo(oriImageHeight)
//        }
        
//        BannerImageView.xlpInitView(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:oriImageHeight), superView: self)
        BannerImageView.frame = CGRect(x:0,y:0,width:kSCREENWIDTH,height:oriImageHeight)
//        addSubview(BannerImageView)
        self.addSubview(BannerImageView)
        BannerImageView.backgroundColor = UIColor.red
        BannerImageView.image = UIImage.init(named: "login_banner")
        
        
        var newFrame : CGRect = CGRect.zero
        newFrame.size = CGSize(width:kSCREENWIDTH,height:kSCREENHEIGHT)
        
        
        self.addSubview(backScrollview)
        backScrollview.separatorStyle = .none
        backScrollview.frame = CGRect(x:0,y:0,width:newFrame.size.width,height:newFrame.size.height)
        backScrollview.delegate = self as UITableViewDelegate
        backScrollview.contentInset = UIEdgeInsetsMake(oriImageHeight, 0, 0, 0)
        backScrollview.scrollIndicatorInsets = UIEdgeInsetsMake(oriImageHeight, 0, 0, 0)
        backScrollview.showsVerticalScrollIndicator = false
        backScrollview.alwaysBounceVertical = true
        backScrollview.backgroundColor = UIColor.clear

        
//        let contentView = UIView()
        contentView.xlpInitView(frame: CGRect(x:0,y:0,width:newFrame.size.width,height:newFrame.size.height-oriImageHeight), superView: backScrollview)
        contentView.backgroundColor = UIColor.cyan
        
        
        
    }
    */
    
    
    init(superView:UIView,snpMaker:WMSnapMakerBlock) {
        super.init(frame: CGRect.zero)
        superView.addSubview(self)
        self.snp.makeConstraints(snpMaker)

        oriImageHeight = kSCREENWIDTH / 1.58
     
        BannerImageView.xlpInitImageView("login_banner", superView: self, corner: 0) { (make) in
            
            make.top.equalTo(0)
//            make.centerX.equalTo(self)
            make.left.right.equalTo(0)
            make.width.equalTo(kSCREENWIDTH)
            make.height.equalTo(oriImageHeight)
        }
     
        var newFrame : CGRect = CGRect.zero
        newFrame.size = CGSize(width:kSCREENWIDTH,height:oriImageHeight)
     
     
        self.addSubview(backScrollview)
        backScrollview.separatorStyle = .none
        backScrollview.frame = CGRect(x:0,y:0,width:newFrame.size.width,height:newFrame.size.height)
        backScrollview.delegate = self as UITableViewDelegate
        backScrollview.contentInset = UIEdgeInsets.init(top: oriImageHeight, left: 0, bottom: 0, right: 0)
        backScrollview.scrollIndicatorInsets = UIEdgeInsets.init(top: oriImageHeight, left: 0, bottom: 0, right: 0)
        backScrollview.showsVerticalScrollIndicator = false
        backScrollview.alwaysBounceVertical = true
        backScrollview.backgroundColor = UIColor.clear

        
        contentView.xlpInitView(frame: CGRect(x:0,y:0,width:newFrame.size.width,height:newFrame.size.height-oriImageHeight), superView: backScrollview)
        contentView.backgroundColor = UIColor.cyan
        
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset
        if point.y < -oriImageHeight {
            
            let newHieht : CGFloat =  -point.y
            
            let mm = newHieht / oriImageHeight
            
            let mmWidth = mm * kSCREENWIDTH
//            BannerImageView.snp.updateConstraints({ (make) in
//                make.width.equalTo(mmWidth)
//                make.height.equalTo(newHieht)
//            })
            BannerImageView.transform = CGAffineTransform.init(scaleX: mm, y: mm)

        }else {
            
            if !(oriImageHeight == -point.y){
                
                BannerImageView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)

//                BannerImageView.snp.updateConstraints({ (make) in
//                    make.height.equalTo(oriImageHeight)
//                    make.width.equalTo(kSCREENWIDTH)
//
//                })
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
