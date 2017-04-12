//
//  NewsViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/15.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import FMDB
class NewsViewController: XLPBaseViewController,UITableViewDelegate,UITableViewDataSource {

    
    var moduleID : Int = -1000
    var dataArr = [Any]()
    var topDataArr = [Article]()
    
    let rootTableView = UITableView.init(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT - 64 - 44), style: .plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let resultSet : FMResultSet = xlpSqliteManager.queryTable(kTableModuleList, sql: "select * from moduleTable where tiny = ? ", id: [self.title!])
        while resultSet.next() {
            moduleID = Int(resultSet.int(forColumn: "moduleID"))

        }
        initMainView()
        obtainData()
        
        print(kTimeGetNow())
        
    }

    func obtainData()  {
        
        self.dataArr.removeAll()
        self.topDataArr.removeAll()
        
        let dic = ["timestamp":"0","size":20,"module":moduleID,"version":bundleNumber,"system":"ios"] as [String : Any]                
        MyManager.sharedInstance.SucceedGETFull2(urlGetArticleList, parameters: dic) { (json, error) in
            
            if json != nil{
                if (json?["success"].bool)!{
                    let articleArr = json?["articles"].array
                    for arr in articleArr! {
                        let module = Article.init(arr)
                        module.module = self.moduleID
                        
                        if module.topFlag! > 0{
                            
                            self.dataArr.append(module)
                        }else{
                            self.topDataArr.append(module)
                        }
                    }
                }
                print("数据获取完成了,要开始刷新了啦啦啦\(self.dataArr.count)")
                self.rootTableView.reloadData()
            }
        }
        
        
    }
    func initMainView() {
        rootTableView.initTableView(delegate: self, superView: view,cellClass: [ArticleCell.self,ArticleTopCell.self])
        
        
    }
    
    
    //MARK: tableview的代理事件
    func numberOfSections(in tableView: UITableView) -> Int {
        var sectionCount = 1
        
        if self.topDataArr.count > 0 {
            sectionCount = 2
        }
        return sectionCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return topDataArr.count > 0 ? topDataArr.count : dataArr.count
        case 1:
            return topDataArr.count > 0 ? dataArr.count : 0
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if topDataArr.count > 0 {
            if indexPath.section == 0 {
                let cell:ArticleTopCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTopCell") as! ArticleTopCell
                let model:Article = self.topDataArr[indexPath.row] 
                cell.showWithModel(model)
                return cell
            }
        }
        let cell:ArticleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
        let model:Article = self.dataArr[indexPath.row] as! Article
        cell.showWithModel(model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if topDataArr.count > 0 {
            if indexPath.section == 0 {
                return kSCREENWIDTH/1.75 + 10
            }
        }
        
        return 10 + (kSCREENWIDTH/3 - 10) * 2 / 3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        var article:Article?
        
        if topDataArr.count > 0 {
            
            if indexPath.section == 0 {
                article = topDataArr[indexPath.row]
            }else{
                article = dataArr[indexPath.row] as? Article
            }
            
        }else{
            article = dataArr[indexPath.row] as? Article

        }
        
        let vc = NewsDetailViewController()
        
        let articleID = String.init(format: "%d", (article?.id)!)
        let url1 = "\(SERVER_ADDRESS_onLine)/article/\(articleID)/content?token=\(kToken)&from=iOS&skin=day&version=500&system=ios&read=1&levelNow=1&articleId=\(articleID)&fontSize=13"    
        vc.urlStr = url1
        vc.hidesBottomBarWhenPushed = true
        vc.articleID = articleID;
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
