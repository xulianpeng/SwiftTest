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
 
extension UIViewController{
    
    
 }
class XLPBaseViewController: UIViewController {

     let netStatusManager = NetworkReachabilityManager()
    public var baseHeader:MJRefreshNormalHeader = MJRefreshNormalHeader()
    public var baseFooter:MJRefreshBackNormalFooter = MJRefreshBackNormalFooter()
    public var netStatus:Bool = true
    
    let wmIndictor = UIActivityIndicatorView.init(style: .whiteLarge)
    
    public func initMjRefresh(target:UIViewController)  {

         baseHeader = MJRefreshNormalHeader.init(refreshingTarget: target, refreshingAction: #selector(headerRefreshAction))
         baseFooter = MJRefreshBackNormalFooter.init(refreshingTarget: target, refreshingAction: #selector(footerRefreshAction))
    }
    
    public func xlpInitMjRefresh(_ target:UIViewController,tableView:UITableView)  {
        
        baseHeader = MJRefreshNormalHeader.init(refreshingTarget: target, refreshingAction: #selector(headerRefreshAction))
        baseFooter = MJRefreshBackNormalFooter.init(refreshingTarget: target, refreshingAction: #selector(footerRefreshAction))
        tableView.mj_header = baseHeader
        tableView.mj_footer = baseFooter
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

        //TODO: 后添加的请在这里写
        
        
        self.view.addSubview(wmIndictor)
        wmIndictor.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(30)
        }
        
        
        
       
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHandle), name: NSNotification.Name(rawValue: "netStatusChanged"), object: nil)
        
        if (netStatusManager?.isReachable)! {
            
            netStatus = true
            if subNoNetView != nil && myWindow.subviews.contains(subNoNetView!) {
                subNoNetView?.removeFromSuperview()
            }
        }else{
            /*
            //MARK: 提示断网,检查网络连接,点击再次加载
            netStatus = false
            
            //展示
            
            subNoNetView = NoNetView.init(64, title: "请您检查连接后重新加载数据,信球货", style: .OnlyText, superView: myWindow, reloaDataBlock1: { (btn) in
                self.reloadHandle()
            })
            
            subNoNetView?.backgroundColor = .gray
  */
        }
        
        
        
    }
    @objc public func headerRefreshAction(header:MJRefreshNormalHeader)  {
        
        
        
    }
    
    @objc public func footerRefreshAction(footer:MJRefreshBackNormalFooter)  {
        
        
        
    }
    

    @objc func reloadHandle() {
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
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
        
        ///断网处理toast
        if (!(netStatusManager?.isReachable)!) {
            let noNetToast = NoNetTast.init("网络不给力,请检查网络设置", superView: self.view) { (tap) in
                
                self.view.backgroundColor = kRandomColor()
                let hud = xlpHud.init(text: "妈咪妈咪哄", constransY: 300)
                hud.show()
                hud.hideWhenAfter(time: 3)
                
            }
            myWindow.addSubview(noNetToast)
            myWindow.bringSubview(toFront: noNetToast)
        }
//        self.view.addSubview(noNetToast)
//        UIView.animate(withDuration: 3) {
//            noNetToast.frame.origin.y = -64
//        }
    }
    */
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
