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
        view.backgroundColor = .white
       
        
        
        let netStatusManager = NetworkReachabilityManager()
        
        
       
        
        if (netStatusManager?.isReachable)! {
            
            netStatus = true
        }else{
            
            //MARK: 提示断网,检查网络连接,点击再次加载
            netStatus = false
            
            //展示
            subNoNetView = NoNetView.init(CGRect(x:0,y:0,width:SCREENWIDTH,height:SCREENHEIGHT), title: "重新加载", superView: myWindow, reloaDataBlock1: { (btn) in
//                print("============无数据时点我重新加载===============")
                
                self.reloadHandle()

            })

            subNoNetView?.backgroundColor = .red
        }
        
        
        
    }
    public func headerRefreshAction(header:MJRefreshNormalHeader)  {
        
        
        
    }
    
    public func footerRefreshAction(footer:MJRefreshBackNormalFooter)  {
        
        
        
    }
    

    func reloadHandle() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
