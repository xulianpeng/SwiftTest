//
//  ZhiHuNewsViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/4.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import CoreData
import MBProgressHUD
import SwiftyJSON
class ZhiHuNewsViewController: XLPBaseViewController,TestOperationDelegate,UITableViewDelegate,UITableViewDataSource {
    internal func obtainDataDelegateSuccess(_ json: JSON?) {
        
        wmIndictor.stopAnimating()
        print("=====代理方法 咋回事啊=======")
        
        print("======operation的代理回调结果为\(json)============")
        
        if json != nil{
            
            let  homeModel = zhiHuControllerModal(json!)
            self.zhiHuTopCellModelArr = homeModel.top_stroies
            self.zhiHuCellModelArr = homeModel.stroies
            //            self.rootTableView.reloadData()
        }else{
            
            print("===\\代理可以么啊啊大大" )
            
        }
        
        
        rootTableView.reloadData()
    }


    let urlStr = "http://news-at.zhihu.com/api/4/news/latest"
    
    /// 顶部banner数据模型
    private var zhiHuTopCellModelArr : [zhiHuTopCellModel] = Array()
    /// 新闻cell数据模型
    private var zhiHuCellModelArr : [zhiHuCellModel] = Array()
    
    let rootTableView = UITableView.init(frame: CGRect(x:0,y:64,width:kSCREENWIDTH,height:kSCREENHEIGHT - 64), style: .plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let aXlpHud = xlpHud.init(text: "每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分", constransY: 400)
//        aXlpHud.show()
//        aXlpHud.hideWhenAfter(time: 2.0)
        
        let _ = xlpHud.init(text: "每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分每天登陆奖励+10积分", constransY: 400, superView: kKeyWindow(), duration: 3)
        
        
        setUpViews()
        obtainData()
//        obtainDataWithDelegate()
        ///注册通知
        registerNotification()
    }

    func setUpViews() {
        rootTableView.initTableView(delegate: self, superView: view)
        
        rootTableView.register(zhiHuCell.self, forCellReuseIdentifier: "zhiHuCell")
        rootTableView.register(zhiHuTopCell.self, forCellReuseIdentifier: "zhiHuTopCell")
    }
    func obtainData() {
        /*
        let myOperation = ZhiHuObtainDataOperation()
        
        myOperation.initWith("asdas")
        myOperation.completionBlock = {
            
            print("哈哈哈我是最后的操作")
        }
        
         let twoOperation = testOperation11.init("asda我是大帅哥啊 啊啊啊")
        
        twoOperation.addDependency(myOperation)
        let queue = OperationQueue()
        queue.name = "Dowload Queue"
        queue.maxConcurrentOperationCount = 3
        queue.addOperation(myOperation)
        queue.addOperation(twoOperation)
//        queue.cancelAllOperations()
        */
        
        
        
        
        
//        self.netStatus
        let hud = MBProgressHUD.init()
//        hud.mode = MBProgressHUDMode.customView
//        hud.customView = 
//        hud.backgroundColor = UIColor.clear //默认是clear 且hud 是覆盖全屏幕的  则显示的过程中 交互失效
        hud.color = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0)
//        hud.isOpaque = true
        hud.mode = MBProgressHUDMode.text
    //TODO:有个限制 超出屏宽的话 则省略号显示
        hud.label.text = "正在加asdajsdajsdkjk哈坚实的骄傲和发生地方的说法和骄傲啥地方就俺俩的身份是短发接快递发货就爱上的回复载..."
        hud.animationType = MBProgressHUDAnimation.zoomOut
        hud.frame = CGRect(x:kSCREENWIDTH/2 - 20,y:kSCREENHEIGHT/2 - 20,width:40,height:40)
        self.view.addSubview(hud)
        hud.show(animated: true)
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 3.0)
        
        
        /*
        weak var weakSelf = self
        MyManager.sharedInstance.SucceedGETFull2(urlStr, parameters: [:]) { (json, error) in
            
            if json != nil{
               
                let  homeModel = zhiHuControllerModal(json!)
                self.zhiHuTopCellModelArr = homeModel.top_stroies
                self.zhiHuCellModelArr = homeModel.stroies
                self.rootTableView.reloadData()
            }else{
                
                print("===\(error)" )
            }
            
            weakSelf?.navigationItem.title = "防止循环引用"
            weakSelf?.view.backgroundColor = UIColor.red
        }
        */
        weak var weakSelf = self
        XlpNetManager.shared.request(url: urlStr, method: .get, params: [:], headers: nil, success: { (response) in
            
            
            let json = JSON(response)
            let  homeModel = zhiHuControllerModal(json)
            self.zhiHuTopCellModelArr = homeModel.top_stroies
            self.zhiHuCellModelArr = homeModel.stroies
            self.rootTableView.reloadData()
            
            weakSelf?.navigationItem.title = "防止循环引用"
            weakSelf?.view.backgroundColor = UIColor.red
            
        }) { (error) in
            print(error) 
        }
        
    }
    
    
    
    func obtainDataWithDelegate() -> Void {
        
        wmIndictor.startAnimating()
        let twoOperation = testOperation11.init(urlStr)
        
        let queue = OperationQueue()
        queue.name = "Dowload Queue"
        queue.maxConcurrentOperationCount = 1
        queue.addOperation(twoOperation)
        twoOperation.delegate = self
        
    }
    
    func obtainDtaDelegateSuccess(_ json: JSON?) {
        
        print("======operation的代理回调结果为\(json)============")
        
        if json != nil{
            
            let  homeModel = zhiHuControllerModal(json!)
            self.zhiHuTopCellModelArr = homeModel.top_stroies
            self.zhiHuCellModelArr = homeModel.stroies
//            self.rootTableView.reloadData()
        }else{
            
            print("===\\代理可以么啊啊大大" )
        }
        
        rootTableView.reloadData()

    }
    //MARK: tableview代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.zhiHuTopCellModelArr.count > 0 {
            return 2
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && self.zhiHuTopCellModelArr.count > 0 {
            return 1
        }else {
            return self.zhiHuCellModelArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && self.zhiHuTopCellModelArr.count > 0 {
            
            return CGFloat(kTopCellHeight)
        }
        
        return  kImageViewHeight + 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.zhiHuTopCellModelArr.count > 0 && indexPath.section == 0 {
            
            let cell:zhiHuTopCell = tableView.dequeueReusableCell(withIdentifier: "zhiHuTopCell") as! zhiHuTopCell
            cell.showWithModals(modals: self.zhiHuTopCellModelArr)
//            cell.zhiHuTopCellModel = self.zhiHuTopCellModelArr
            return cell
            
        }
        
        let cell:zhiHuCell = tableView.dequeueReusableCell(withIdentifier: "zhiHuCell") as! zhiHuCell
        
        let modal:zhiHuCellModel = self.zhiHuCellModelArr[indexPath.row]
        
//        cell.showWithCellModal(modal: modal)
        cell.zhihuModel = modal
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = ZhiHuDetailVController()
        
//        let baseUrl = "http://news-at.zhihu.com/api/4/news/"
        let baseUrl = "http://daily.zhihu.com/story/"
        
        if self.zhiHuTopCellModelArr.count > 0 && indexPath.section == 0 {
            
//            var topModal:zhiHuTopCellModel = zhiHuTopCellModelArr[indexPath.row]
            
            
            
        }else{
            
            let modal:zhiHuCellModel = zhiHuCellModelArr[indexPath.row]
            
             detailVC.detailUrlString = (baseUrl + String(modal.articleId!))
        }
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    /// 注册通知
    func registerNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationHandle), name: NSNotification.Name(rawValue: "mmm"), object: nil)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"mmm"), object: nil, queue: nil) { (notification) in
            self.navigationController?.navigationBar.barTintColor = UIColor.purple
        }
        
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"nnn"), object: nil, queue: mainQueue) { (sender) in
            
            self.view.backgroundColor = UIColor.brown
        }
        
    }
    @objc func notificationHandle(sender:NSNotification){
    
        self.navigationController?.navigationBar.barTintColor = UIColor.yellow
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: 使用CoreData
    func obtainDataWithCoreData()  {
        
        MyManager.sharedInstance.SucceedGET(urlStr, parameters: [:]) { (json) in
            let  homeModel = zhiHuControllerModal(json)
            self.zhiHuTopCellModelArr = homeModel.top_stroies
            self.zhiHuCellModelArr = homeModel.stroies
          
            
            xlpCoredataManager.obtainContext()
            
            let top_stroies = json["top_stroies"].array
            let stories = json["stories"].array
            
            
            for dic in stories!{
                
                let theDic:Dictionary =  dic.dictionary!
                
                xlpCoredataManager.insertData("ZhiHuEntity", dic: theDic as NSDictionary)
                
            }
            
            
//            xlpCoredataManager.fetchData("ZhiHuEntity")
            
            self.rootTableView.reloadData()
        }
        
 
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
