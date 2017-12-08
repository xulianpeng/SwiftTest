
//
//  ATULoginVController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/11/22.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SnapKit
class ATULoginVController: XLPBaseViewController,UITableViewDelegate,UIScrollViewDelegate {

    var BannerImageView : UIImageView = UIImageView()
    var backScrollview : UITableView = UITableView()
    
    var oriImageHeight : CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initUI()
       
        let backView:loginBackView = loginBackView.init(superView: view) { (make) in
            make.top.equalTo(64)
            make.left.equalTo(0)
            make.width.equalTo(kSCREENWIDTH)
            make.height.equalTo(kSCREENHEIGHT)
        }
//        let backView:loginBackView = loginBackView.init(frame: CGRect(x:0,y:64,width:kSCREENWIDTH,height:kSCREENHEIGHT))
//        view.addSubview(backView)
        
        backView.contentView.backgroundColor = UIColor.yellow

        let label = UILabel()
        label.xlpInitLabel("徐联朋", textColor: UIColor.blue, fontSize: 16, isBold: false, aligenment: .center, backgroundColor: UIColor.red, superView: backView.contentView) { (make) in
            
            make.top.equalTo(30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(40)
        }
        
        let bt =  UIButton.init(type: .custom)
        bt.xlpInitEassyButton("点击", titleColor: .green, fontSize: 18, backgroundColor: .cyan, cornerRedius: 3, superView: backView.contentView, snpMaker: { (make) in
            
            make.top.equalTo(label.snp.bottom).offset(30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(40)
        }) { (bt) in
            
            
            self.navigationController?.pushViewController(videoRootViewController(), animated: true)
            
        }
        
        
    }

    func initUI() {
        
        
        oriImageHeight = kSCREENHEIGHT * 1 / 3

        BannerImageView.xlpInitImageView("login_banner", superView: view, corner: 0) { (make) in
            
            make.top.equalTo(64)
//            make.centerX.equalTo(view)
            make.left.right.equalTo(0)
            make.width.equalTo(kSCREENWIDTH)
            make.height.equalTo(oriImageHeight)
        }
        
        
//        view.addSubview(backScrollview)
//        backScrollview.separatorStyle = .none
//        backScrollview.frame = CGRect(x:0,y:64,width:kSCREENWIDTH,height:kSCREENHEIGHT - 64)
//        backScrollview.backgroundColor = kXlpColor(r: 0, g: 243, b: 45, alpha: 0.5)
////        backScrollview.contentSize = CGSize(width:kSCREENWIDTH,height:kSCREENHEIGHT)
//        backScrollview.backgroundColor = UIColor.clear
////        backScrollview.delegate = self
//        backScrollview.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)
//
//        backScrollview.scrollIndicatorInsets = UIEdgeInsetsMake(200, 0, 0, 0)
//        backScrollview.showsVerticalScrollIndicator = false
//        backScrollview.alwaysBounceVertical = true
//
//        let contentView = UIView()
//        contentView.xlpInitView(frame: CGRect(x:0,y:200,width:kSCREENWIDTH,height:kSCREENHEIGHT-200-64), superView: backScrollview)
//        contentView.backgroundColor = UIColor.cyan
        
        
        view.addSubview(backScrollview)
        backScrollview.separatorStyle = .none
        backScrollview.frame = CGRect(x:0,y:64,width:kSCREENWIDTH,height:kSCREENHEIGHT - 64)
//        backScrollview.backgroundColor = kXlpColor(r: 0, g: 243, b: 45, alpha: 0.5)
        backScrollview.backgroundColor = UIColor.clear
        backScrollview.delegate = self as UITableViewDelegate
        backScrollview.contentInset = UIEdgeInsetsMake(oriImageHeight, 0, 0, 0)
        
        backScrollview.scrollIndicatorInsets = UIEdgeInsetsMake(200, 0, 0, 0)
        backScrollview.showsVerticalScrollIndicator = false
        backScrollview.alwaysBounceVertical = true
        
        let contentView = UIView()
        contentView.xlpInitView(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT-oriImageHeight-64), superView: backScrollview)
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
            
            BannerImageView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
//            if !(oriImageHeight == -point.y){
//
//                BannerImageView.snp.updateConstraints({ (make) in
//                    make.height.equalTo(oriImageHeight)
//                    make.width.equalTo(kSCREENWIDTH)
//
//                })
//            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let mm = backScrollview.contentOffset.y
        
        print("滑动kaishi时 其 偏离 y",mm)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let mm = backScrollview.contentOffset.y
        
        print("滑动结束时 其 偏离 y",mm)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
