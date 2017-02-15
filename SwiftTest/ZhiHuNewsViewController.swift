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

class ZhiHuNewsViewController: XLPBaseViewController,UITableViewDelegate,UITableViewDataSource {

    let urlStr = "http://news-at.zhihu.com/api/4/news/latest"
    
    /// 顶部banner数据模型
    private var zhiHuTopCellModelArr : [zhiHuTopCellModel] = Array()
    /// 新闻cell数据模型
    private var zhiHuCellModelArr : [zhiHuCellModel] = Array()
    
    let rootTableView = UITableView.init(frame: CGRect(x:0,y:0,width:SCREENWIDTH,height:SCREENHEIGHT), style: .plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        obtainData()
    }

    func setUpViews() {
        rootTableView.initTableView(delegate: self, superView: view)
        
        rootTableView.register(zhiHuCell.self, forCellReuseIdentifier: "zhiHuCell")
        rootTableView.register(zhiHuTopCell.self, forCellReuseIdentifier: "zhiHuTopCell")
    }
    func obtainData() {
        
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
        hud.frame = CGRect(x:SCREENWIDTH/2 - 20,y:SCREENHEIGHT/2 - 20,width:40,height:40)
        self.view.addSubview(hud)
        hud.show(animated: true)
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 3.0)
        
        MyManager.sharedInstance.SucceedGET(urlStr, parameters: [:]) { (json) in
            let  homeModel = zhiHuControllerModal(json)
            self.zhiHuTopCellModelArr = homeModel.top_stroies
            self.zhiHuCellModelArr = homeModel.stroies
//            hud.hide(animated: true);
            
            
//            xlpCoredataManager.obtainContext()
//            
//            let top_stroies = json["top_stroies"].array
//            let stories = json["stories"].array
//            
//            
//            for dic in stories!{
//                
//                let theDic:Dictionary =  dic.dictionary!
//                
//                xlpCoredataManager.insertData(entyName: "ZhiHuEntity", dic: theDic as NSDictionary)
//                
//            }
//            
//          
//            xlpCoredataManager.fetchData()
            
            
            
            
            
            self.rootTableView.reloadData()
        }
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
