 //
//  XLPBaseViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/22.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh
import Alamofire
class XLPBaseViewController: UIViewController {

    public var baseHeader:MJRefreshNormalHeader = MJRefreshNormalHeader()
    public var baseFooter:MJRefreshBackNormalFooter = MJRefreshBackNormalFooter()
    public var netStatus:Bool = true
    
    public func initMjRefresh(target:UIViewController)  {

         baseHeader = MJRefreshNormalHeader.init(refreshingTarget: target, refreshingAction: #selector(headerRefreshAction))
         baseFooter = MJRefreshBackNormalFooter.init(refreshingTarget: target, refreshingAction: #selector(footerRefreshAction))
    }
    
   
    var subNoNetView : NoNetView?
    
    var myWindow: UIWindow {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.window!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
       
        ///实现进入一个视图控制器 打印输出控制器的名字
        print("====当前将要进入视图====\(self.description)")//MARK:这个告诉我们当前所在的视图控制器的名字

        ///
        
        
        
        
        let netStatusManager = NetworkReachabilityManager()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHandle), name: NSNotification.Name(rawValue: "netStatusChanged"), object: nil)
        
        if (netStatusManager?.isReachable)! {
            
            netStatus = true
            if subNoNetView != nil && myWindow.subviews.contains(subNoNetView!) {
                subNoNetView?.removeFromSuperview()
            }
        }else{
            
            //MARK: 提示断网,检查网络连接,点击再次加载
            netStatus = false
            
            //展示
//            subNoNetView = NoNetView.init(CGRect(x:0,y:64,width:kSCREENWIDTH,height:kSCREENHEIGHT), title: "数据连接已断开,请检查后重新加载", superView: myWindow, reloaDataBlock1: { (btn) in
////                print("============无数据时点我重新加载===============")
//                
//                self.reloadHandle()
//
//            })
//            subNoNetView?.initWithButtonText(text: "请您检查连接后重新加载数据,信球货")
            
            subNoNetView = NoNetView.init(64, title: "请您检查连接后重新加载数据,信球货", style: .OnlyText, superView: myWindow, reloaDataBlock1: { (btn) in
                self.reloadHandle()
            })
            
            subNoNetView?.backgroundColor = .gray
        }
        
        
        
    }
    public func headerRefreshAction(header:MJRefreshNormalHeader)  {
        
        
        
    }
    
    public func footerRefreshAction(footer:MJRefreshBackNormalFooter)  {
        
        
        
    }
    

    func reloadHandle() {
        viewDidLoad()
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "netStatusChanged"), object: nil)
        //断网页面移除
        subNoNetView?.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
        
        ///断网处理toast
        
        let noNetToast = NoNetTast.init("网络不给力,请检查网络设置", superView: self.view) { (tap) in
            
            self.view.backgroundColor = XLPRandomColor()
            let hud = xlpHud.init(text: "妈咪妈咪哄", constransY: 300)
            hud.show()
            hud.hideWhenAfter(time: 3)
            
        }
//        self.view.addSubview(noNetToast)
        myWindow.addSubview(noNetToast)
        myWindow.bringSubview(toFront: noNetToast)
//        UIView.animate(withDuration: 3) {
//            noNetToast.frame.origin.y = -64
//        }
    }
    //做调试用
    func printLog<T>(message: T,
                  file: String = #file,
                  method: String = #function,
                  line: Int = #line)
    {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
   

}
