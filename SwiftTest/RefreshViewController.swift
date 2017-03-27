//
//  RefreshViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/3.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import MJRefresh
import FMDB
import MBProgressHUD

class RefreshViewController: XLPBaseViewController,UITableViewDelegate,UITableViewDataSource {

    var finalArr = [EassyModal]()
    var rootTableView = UITableView()
    
    let urlString2 :String = "http://www.iyingdi.com/article/list"
    var paraDic2:[String:Any] = ["module":19,"size":20,"system":"ios","timestamp":0,"version":500,"visible":1]
    
    var minTimestamp = 0
    
    var topModalArr:Array = [EassyModal]()
    
    var dataBase :FMDatabase = FMDatabase()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        obtainData()
        initDB()
        
        
    }

    func setupUI() {
//        self.navigationController?.title = "Refresh测试"
        rootTableView = UITableView.init(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT), style: .plain)
        rootTableView.initTableView(delegate: self, superView: view,cellClass: [EassyCell.self,EassyCell2.self])
        rootTableView.register(EassyCell.self, forCellReuseIdentifier: "cell")
        rootTableView.register(EassyCell2.self, forCellReuseIdentifier: "cell2")
        
        
        
        
 
        /*
         //MARK: 普通的刷新方法
        let header11:MJRefreshNormalHeader = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(headerRefreshAction11))
        let footer11:MJRefreshBackNormalFooter = MJRefreshBackNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(footerRefreshAction(footer:)))
        
        rootTableView.mj_header = header11
        rootTableView.mj_footer = footer11
        */
        
        //MARK: 集合到基类
        initMjRefresh(target: self)
        rootTableView.mj_header = self.baseHeader
        rootTableView.mj_footer = baseFooter

        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if topModalArr.count > 0 {
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? EassyCell2
                let modal:EassyModal = topModalArr[0]
                cell?.showValueWithModal(modal: modal)
                
                return cell!
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? EassyCell
        let modal:EassyModal = finalArr[indexPath.row]
        cell?.showValueWithModal(modal: modal)
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if topModalArr.count > 0 {
            
            if indexPath.row == 0 {
                return kSCREENWIDTH * 3 / 4
            }
        }
        return kSCREENWIDTH/4 + 20
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
//        let detailVC = RefreshDetailViewController()
        
        let detailVC = RefreshWKWebViewController()
        
        let modal = finalArr[indexPath.row]
        
        let baseUrl = "http://www.iyingdi.com/article/"
            
        let detailUrl = baseUrl + String(modal.articleID) + "/content?" + String(kToken) + "&from=iOS&skin=day&version=500&system=ios&read=0&levelNow=1&articleId=\(modal.articleID)&fontSize=13"
        

        detailVC.url = detailUrl
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    
    func obtainData() {
        
//        WMNetManager.sharedInstance.SucceedGET(urlString2, parameters: paraDic2) { (jsonValue) in
        
        
        
         MyManager.sharedInstance.SucceedGET(urlString2, parameters: paraDic2) { (jsonValue) in
            
            let articlesArr = jsonValue["articles"].array
            
            var tempArr = [EassyModal]()
            for arr in articlesArr!   {
                let modal = EassyModal.init(articleID:arr[0].int!,
                                            moduleID: 19,
                                            replyNum: arr[4].int!,
                                            subClass: arr[17].string!,
                                            thumbnail: arr[7].string!,
                                            timestamp: arr[2].int!,
                                            title: arr[1].string!,
                                            topFlag: arr[9].int!,
                                            author: arr[14].string!,
                                            visitNum: arr[5].int!,
                                            canRead: arr[10].int!,
                                            type: arr[11].int!)
                
                
                //MARK: 调用写入数据库的方法

                self.SQL_insertTableWithModal(modal:modal)
                tempArr.append(modal)
                
                if modal.topFlag < 0{
                    self.topModalArr.append(modal)
                }
                
            }
 
            self.finalArr = tempArr
            
            DispatchQueue.main.async {
                
                self.rootTableView.reloadData()
            }
            
            
        }

    }
    
    //断网时 点击重载按钮 从数据库加载
    
    override func reloadHandle() {
        
        super.reloadHandle()
        
        var dicArr = [Any]()
        
        if dataBase.open() {
        
            if let resulstSet = dataBase.executeQuery("select *from articleList", withArgumentsIn: nil) {
            
                while resulstSet.next() {
                    
                    //可以直接获取字典
//                    let dic = resulstSet.resultDictionary()
//                    dicArr.append(dic ?? [:])
                    //也可以 单个获取
                    let articleID = resulstSet.int(forColumn: "articleID")
                    let moduleID = resulstSet.int(forColumn: "moduleID")
                    let replyNum = resulstSet.int(forColumn: "replyNum")
                    let subClass = resulstSet.string(forColumn: "subClass")
                    let thumbnail = resulstSet.string(forColumn: "thumbnail")
                    let timestamp = resulstSet.int(forColumn: "timestamp")
                    let title = resulstSet.string(forColumn: "title")
                    let topFlag = resulstSet.int(forColumn: "topFlag")
                    let author = resulstSet.string(forColumn: "author")
                    let visitNum = resulstSet.int(forColumn: "visitNum")
                    let canRead = resulstSet.int(forColumn: "canRead")
                    let type = resulstSet.int(forColumn: "type")
                    
                    let modal = EassyModal.init(articleID: Int(articleID), moduleID: Int(moduleID), replyNum: Int(replyNum), subClass: subClass!, thumbnail: thumbnail!, timestamp: Int(timestamp), title: title!, topFlag: Int(topFlag), author: author!, visitNum: Int(visitNum), canRead: Int(canRead), type: Int(type))
                    
                    
                    dicArr.append(modal)
                    
                }
                self.subNoNetView?.removeFromSuperview()
                setupUI()
                self.rootTableView.reloadData()
                print(dicArr)
            }else {
                print("select failed: \(dataBase.lastErrorMessage())")
            }
        
        }
        
    }
    //MARK: 初始化数据库
    
    func initDB()  {
        
        
        let document = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let articleDBPath = document.appendingFormat("/%@","articleList.sqlite")
        
        print(articleDBPath)
        /* 结果是创建了一个文件夹
        if !FileManager.default.fileExists(atPath: articleDBPath!){
            
//           try? FileManager.default.createDirectory(atPath: articleDBPath!, withIntermediateDirectories: true, attributes: nil)
             FileManager.default.createFile(atPath: articleDBPath!, contents: nil, attributes: nil)
        }
        */
//        let articleDB = FMDatabase.init(path: articleDBPath)
         dataBase = FMDatabase(path:articleDBPath) as FMDatabase
//        let mbHuD : MBProgressHUD = MBProgressHUD.init()
        if !dataBase.open() {
            
            let alert =
                UIAlertController.init(title: "提示", message: "数据库未打开,初始化失败", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            
            self.present(alert, animated:true, completion: nil)
            

            print("======Unable to open database========")
            return
        }else{
            
            print("=============== open database=================")

            
            if !dataBase.tableExists("articleList") {
                
                if dataBase.executeUpdate("create table articleList(articleID integer UNIQUE,moduleID integer,replyNum integer,subClass text,thumbnail text,timestamp integer,title text,topFlag integer,author text,visitNum integer,canRead integer,type integer)", withArgumentsIn: nil){
                    
                    print("创建表成功*******************")
                }else{
                    print("表已存在,创建表失败===================")
                }
            }
            
            
            
//            dataBase.close()
        }
       
    }
    
    //MARK: 把 modal写入数据库
    
    func SQL_insertTableWithModal(modal:EassyModal) -> Void {
        
        
        if dataBase.open() {
            
            
            
            if dataBase.executeUpdate("insert into articleList(articleID ,moduleID ,replyNum ,subClass ,thumbnail ,timestamp ,title ,topFlag ,author ,visitNum ,canRead ,type ) values (?,?,?,?,?,?,?,?,?,?,?,?)", withArgumentsIn: [modal.articleID,modal.moduleID,modal.replyNum,modal.subClass,modal.thumbnail,modal.timestamp,modal.title,modal.topFlag,modal.author,modal.visitNum,modal.canRead,modal.type]){
                
                
                print("****************数据插入成功====================")
            }else{
                print("****************数据插入失败===failed: \(dataBase.lastErrorMessage())")
            }
            

            /*
            //先查询 表中是否有该条数据 有 则更新 ,无则 插入
            
            
             dataBase.executeQuery("select *from articleList where articleID = ?", withArgumentsIn: [modal.articleID])
            if let resulstSet = dataBase.executeQuery("select *from articleList where articleID = ?", withArgumentsIn: [modal.articleID]) {
                
                if resulstSet.next() {
                    let thumbnail = resulstSet.string(forColumn: "thumbnail")
                    let moduleID = resulstSet.int(forColumn: "moduleID")
//                    let z = resulstSet.bool(forColumn: <#T##String!#>)
//                    let dataMM = resulstSet.data(forColumn: <#T##String!#>)
//                    let dateMM = resulstSet.date(forColumn: <#T##String!#>)
//                    let MM = resulstSet.double(forColumn: <#T##String!#>)
//                    let MM = resulstSet.long(forColumn: <#T##String!#>)
                    let MM = resulstSet.resultDictionary()
                    
                    
                    
                    print("====搜索的什么鬼==\(thumbnail,moduleID),======\n 获取的字典===***\(MM)",MM?["articleID"] ?? 000000)
                }else
                {
                    
                    if dataBase.executeUpdate("insert into articleList(articleID ,moduleID ,replyNum ,subClass ,thumbnail ,timestamp ,title ,topFlag ,author ,visitNum ,canRead ,type ) values (?,?,?,?,?,?,?,?,?,?,?,?)", withArgumentsIn: [modal.articleID,modal.moduleID,modal.replyNum,modal.subClass,modal.thumbnail,modal.timestamp,modal.title,modal.topFlag,modal.author,modal.visitNum,modal.canRead,modal.type]){
                        
                        print("****************数据插入成功====================")
                    }else{
                        print("****************数据插入失败")
                    }

                    
                }
            }else
            {
                
                print("select failed: \(dataBase.lastErrorMessage())")
            }
            
            */
        }
        
    }
    
    //MARK: 断网时 从数据库中获取数据
    
//    func obtainDataFromDB() {
//        
//        if dataBase.open() {
//        
//        
//            if dataBase.executeQuery(<#T##sql: String!##String!#>, withArgumentsIn: <#T##[Any]!#>) {
//                <#code#>
//            }
//        
//        }
//    }
    
    
    //MARK:头部刷新
    
   
    override func headerRefreshAction(header: MJRefreshNormalHeader) {

        super.headerRefreshAction(header: header)
        paraDic2["timestamp"] = 0
       
        WMNetManager.sharedInstance.SucceedGET(urlString2, parameters: paraDic2) { (jsonValue) in
            
            header.endRefreshing()
            let articlesArr = jsonValue["articles"].array
            
            if (articlesArr?.count)! > 0{
                
                var tempArr = [EassyModal]()
                var tempTopArr = [EassyModal]()
                for arr in articlesArr!   {
                    let modal = EassyModal.init(articleID:arr[0].int!,
                                                moduleID: 19,
                                                replyNum: arr[4].int!,
                                                subClass: arr[17].string!,
                                                thumbnail: arr[7].string!,
                                                timestamp: arr[2].int!,
                                                title: arr[1].string!,
                                                topFlag: arr[9].int!,
                                                author: arr[14].string!,
                                                visitNum: arr[5].int!,
                                                canRead: arr[10].int!,
                                                type: arr[11].int!)
                    

                    
                    tempArr.append(modal)
                    
                    if modal.topFlag < 0{
                        tempTopArr.append(modal)
                    }
                }
                
                
                
                if tempArr.count > 0 {
                    
                    self.finalArr.removeAll()
                    self.topModalArr.removeAll()
                    
                    self.finalArr = tempArr
                    
                    self.topModalArr = tempTopArr
                    
                }
                DispatchQueue.main.async {
                    
                    self.rootTableView.reloadData()
                }
            }

        }
        
    }
    
    
    //MARK: 尾部上啦加载更多
    override func footerRefreshAction(footer: MJRefreshBackNormalFooter) {
        super.footerRefreshAction(footer: footer)
        
        if self.finalArr.count > 0 {
            
            let minModal : EassyModal = self.finalArr[self.finalArr.count - 1]
            
            minTimestamp = minModal.timestamp - 1
            
            paraDic2["timestamp"] = minTimestamp
            
            WMNetManager.sharedInstance.SucceedGET(urlString2, parameters: paraDic2) { (jsonValue) in
                
                footer.endRefreshing()
                let articlesArr = jsonValue["articles"].array
                
                if (articlesArr?.count)! > 0{
                    
                    var tempArr = [EassyModal]()
                    for arr in articlesArr!   {
                        let modal = EassyModal.init(articleID:arr[0].int!,
                                                    moduleID: 19,
                                                    replyNum: arr[4].int!,
                                                    subClass: arr[17].string!,
                                                    thumbnail: arr[7].string!,
                                                    timestamp: arr[2].int!,
                                                    title: arr[1].string!,
                                                    topFlag: arr[9].int!,
                                                    author: arr[14].string!,
                                                    visitNum: arr[5].int!,
                                                    canRead: arr[10].int!,
                                                    type: arr[11].int!)
                        
                        
                        
                        tempArr.append(modal)
                        
                    }
                    
                    self.finalArr += tempArr
                    DispatchQueue.main.async {
                        
                        self.rootTableView.reloadData()
                    }
                }
                
            }
        }
        

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
