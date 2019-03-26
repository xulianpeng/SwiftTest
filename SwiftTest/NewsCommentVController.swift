//
//  NewsCommentVController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/4/12.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import MJRefresh
class NewsCommentVController: XLPBaseViewController,UITableViewDelegate,UITableViewDataSource {

    public var articleID:String?
    
    var rootTableView = UITableView.init(frame: CGRect(x:0,y:64,width:kSCREENWIDTH,height:kSCREENHEIGHT - 64), style: .plain)
    
    var normalArr = [NewsCommentModel]()
    var hotNormalArr = [NewsCommentModel]()
    
    var page = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "文章评论"
        rootTableView.estimatedRowHeight = 40
        
        rootTableView.rowHeight = UITableView.automaticDimension

        obtainData()
        xlpInitMjRefresh(self, tableView: rootTableView)

        

    }
    func initUI()  {
        rootTableView.xlpInitTableViewEnd(delegate: self, superView: self.view, cellClass: [commentCell.self])
        rootTableView.backgroundColor = UIColor.blue
    }
    func obtainData() {
        let para = ["page":page,"version":bundleNumber,"system":"ios","token":kToken] as [String : Any]
        let url = SERVER_ADDRESS_onLine + "/article/\(articleID!)/comments/common"
        MyManager.sharedInstance.SucceedGET(url, parameters: para) { (json) in
            
            if json["success"].bool!{
                
                let homeModel = NewsCommentVCModel(json)
                
                self.normalArr = homeModel.commentModelArr
//                self.hotNormalArr = homeModel.commentModelTwoArr
                self.hotNormalArr = [NewsCommentModel]()
//                print(self.normalArr,self.hotNormalArr,self.normalArr.count,self.hotNormalArr.count)
                self.initUI()

                self.rootTableView.reloadData()
            }else{
                
            }
            
            
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

//        let section = (self.hotNormalArr.count > 0) ? 2 : 1
//        print("====分区为多少呢===\(section)")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.hotNormalArr.count > 0 {
            if section == 0 {
                return self.hotNormalArr.count
            }
        }
        return  self.normalArr.count
        
        
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        if self.hotNormalArr.count > 0{
//            
//            if indexPath.section == 0 {
//                let model = self.hotNormalArr[indexPath.row]
//                
//                let contentHeight = kStringGetSize(model.oneContent, font: kFontWithSize(14), maxSize: CGSize(width:kSCREENWIDTH - 20,height:CGFloat(MAXFLOAT))).height
//                return contentHeight + CGFloat(50)
//            }
//        }
//        let model = self.normalArr[indexPath.row]
//        let contentHeight = kStringGetSize(model.oneContent, font: kFontWithSize(16), maxSize: CGSize(width:kSCREENWIDTH - 20,height:CGFloat(MAXFLOAT))).height
//        return contentHeight + CGFloat(50)
// 
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        
        if self.hotNormalArr.count > 0 {
            if indexPath.section == 0 {
                let model = self.hotNormalArr[indexPath.row]
                let cell:commentCell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! commentCell
                cell.initMdole(model)
                return cell
            }
        }
        let model = self.normalArr[indexPath.row]
        let cell:commentCell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! commentCell
        cell.initMdole(model)
        return cell
    }
    
    override func footerRefreshAction(footer: MJRefreshBackNormalFooter) {
        page += 1
        let para = ["page":page,"version":bundleNumber,"system":"ios","token":kToken] as [String : Any]
        let url = SERVER_ADDRESS_onLine + "/article/\(articleID!)/comments/common"
        MyManager.sharedInstance.SucceedGET(url, parameters: para) { (json) in
            
            footer.endRefreshing()
            if json["success"].bool!{
                
                let homeModel = NewsCommentVCModel(json)
                
                let normalArrTemp:[NewsCommentModel] = homeModel.commentModelArr
                //                self.hotNormalArr = homeModel.commentModelTwoArr
//                self.hotNormalArr = [NewsCommentModel]()
                
                self.normalArr += normalArrTemp
                self.rootTableView.reloadData()
            }else{
                
            }
            
            
            
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
