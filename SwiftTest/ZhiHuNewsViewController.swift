//
//  ZhiHuNewsViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/4.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

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
        
        WMNetManager.sharedInstance.SucceedGET(urlStr, parameters: [:]) { (json) in
            let  homeModel = zhiHuControllerModal(json)
            self.zhiHuTopCellModelArr = homeModel.top_stroies
            self.zhiHuCellModelArr = homeModel.stroies
            
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
            return cell
            
        }
        
        let cell:zhiHuCell = tableView.dequeueReusableCell(withIdentifier: "zhiHuCell") as! zhiHuCell
        
        let modal:zhiHuCellModel = self.zhiHuCellModelArr[indexPath.row]
        
        cell.showWithCellModal(modal: modal)
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
