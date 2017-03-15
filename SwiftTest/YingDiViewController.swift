//
//  YingDiViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/15.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class YingDiViewController: XLPBaseViewController,UIScrollViewDelegate,TitleArrViewDelegate {

//    let firstVC = XLPBaseViewController()
//    let secondVC = XLPBaseViewController()
//    let thirdVC = XLPBaseViewController()
    
    var titleView :TitleArrView?
    
    var titleArr = ["资讯","守望","炉石","昆特","游戏王","万智","阵面","电游","手游","皇战","电台","HEX","杂谈"]
    
//    var vcArr = [NewsViewController]()
    let mainView = UIScrollView()
    
    let mainHeight = kSCREENHEIGHT - 64 - 44
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavTitleView()
        
        mainView.frame = CGRect(x:0,y:64,width:kSCREENWIDTH,height:mainHeight )
        mainView.bounces = true
        self.view.addSubview(mainView)
        mainView.isPagingEnabled = true
        mainView.delegate = self
        mainView.tag = 100
        mainView.contentSize = CGSize(width:kSCREENWIDTH * CGFloat(titleArr.count),height:mainHeight )
        
        for (index,title) in titleArr.enumerated() {
            let childVC = NewsViewController()
            childVC.title = title
            childVC.view.frame = CGRect(x:kSCREENWIDTH * CGFloat(index),y:0,width:kSCREENWIDTH,height:mainHeight)
            childVC.view.backgroundColor = KRandomColor()
            mainView.addSubview(childVC.view)
            self.addChildViewController(childVC)
            
        }
        
    }
    func initNavTitleView()  {
        
        titleView = TitleArrView.init(frame: CGRect(x:40,y:20,width:kSCREENWIDTH - 80,height:44), titleArr: titleArr)
        titleView!.backgroundColor = UIColor.clear
        titleView?.delegate = self
        self.navigationItem.titleView = titleView
    }
    
    func clickTitleViewAtIndex(_ index: Int) {
        
        let mm = kSCREENWIDTH * CGFloat(index)
        UIView.animate(withDuration: 0.3) {
            self.mainView.contentOffset = CGPoint(x:mm,y:0)
            
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        ///如果不+kSCREENWIDTH/2,会出现 变化的太快
        if scrollView.tag == 100 {
            let theWidth = kSCREENWIDTH

            let index:Int = Int(scrollView.contentOffset.x + theWidth/2 ) / Int(theWidth)
            
            titleView?.setCurrentIndex(index)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
