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
       
        
        
        let netStatusManager = NetworkReachabilityManager()
        
        
       
        
        if (netStatusManager?.isReachable)! {
            
            netStatus = true
            if subNoNetView != nil && myWindow.subviews.contains(subNoNetView!) {
                subNoNetView?.removeFromSuperview()
            }
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
        viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        SVProgressHUD.dismiss()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        printLog(message: "目前的试图控制器")//这个暂时没啥用
        
        print("====当前将要进入视图====\(self.description)")//MARK:这个告诉我们当前所在的视图控制器的名字
    }
    func printLog<T>(message: T,
                  file: String = #file,
                  method: String = #function,
                  line: Int = #line)
    {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
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
