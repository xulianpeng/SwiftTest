//
//  ADView.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/4/17.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class ADView: UIView {

    var adImageView = UIImageView()
    var jumpBt = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        adImageView.xlpInitView(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT), superView: self) { (tap) in
            
            //调到广告详情页 先判断adurl是否合法可用 这样在广告详情页就不需要做判断了
            
            let adUrl = kUserDefaultsValueString("adDetailUrl")
            if  adUrl != nil && !adUrl!.isEmpty  {
                //不合法网址  http://  会crash
                //合法 则可跳转到广告详情页
                if kStringZZJudge(adUrl!, type: .url) {
                    
                    let adDetailVC =  UINavigationController.init(rootViewController:ADDetailVController())
                    self.removeFromSuperview()
                    kKeyWindow().rootViewController?.present(adDetailVC, animated: true, completion: nil)
                }else{
                    
                   self.unDisplayADDetail()

                }
                
            }else{
                self.unDisplayADDetail()
            }
        
           
        }
        
        let dataPath = kGetDocumentPath().appendingPathComponent("/AD/adData")
        adImageView.image = UIImage.init(contentsOfFile: dataPath)
        
        jumpBt.xlpInitFianlButton("跳过", titleColor: .white, fontSize: 13, superView: adImageView, snpMaker: { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(60)
            make.width.equalTo(70)
            make.height.equalTo(40)
        }) { (bt) in
            self.unDisplayADDetail()
        }
    }
    
    func unDisplayADDetail() {
        UIView.animate(withDuration: 0.3, animations: {
            
            self.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            self.alpha = 0.0
        }, completion: { (true) in
            
            self.removeFromSuperview()
        })

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
