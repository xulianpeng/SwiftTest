//
//  YingdiToolViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/27.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import FMDB
class YingdiToolViewController: XLPBaseViewController {

    var cardBt = UIButton()
    var cardManagerBt = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        obtainData()
        initViews()
    }

    /*
     * 获取数据
     */
    
    func initData() {
        
        xlpSqliteManager.creatTable(kTableToolSeriesHearthStone, sqlStr:"abbr text,clazz text,created integer,id integer,name text,pubTime integer,scored integer,size integer,standard integer,updated integer,visible integer,wild integer")
        xlpSqliteManager.creatTable(kTableToolPackageHearthStone, sqlStr: "clazz text,created integer,id integer,remark text,series integer,size integer,tag text,updated integer,url text,weight integer")
        
    }
    
    /*
     * 
     */
    func obtainData() {
        let para = ["timestamp":0,"version":510,"tags":"标准模式,狂野模式,衍生物数据包","token":kToken] as [String : Any]
        MyManager.sharedInstance.SucceedPOST(urlGetToolHearthStone, parameters: para) { (json) in
            let wildArr = json["狂野模式"].array
            let standardArr = json["标准模式"].array
            let derivativeArr = json["衍生物数据包"].array
            
            for  arr in [wildArr,standardArr,derivativeArr]{
                
                for dic in arr!{
                    let seriesDic = dic["series"].dictionary
                    let packageDic = dic["package"].dictionary
                    
                    let resultset:FMResultSet = xlpSqliteManager.queryTable(kTableToolSeriesHearthStone, sql: "select *from \(kTableToolSeriesHearthStone) where id = ?", id: [seriesDic?["id"]!.int ?? "-1000"])
                    if !resultset.next(){
                        
                        xlpSqliteManager.insertTable(kTableToolSeriesHearthStone, sql: "abbr,clazz,created,id,name,pubTime,scored,size,standard,updated,visible,wild", dic: seriesDic!)
                    }
                    
                    let resultset2:FMResultSet = xlpSqliteManager.queryTable(kTableToolPackageHearthStone, sql: "select *from \(kTableToolPackageHearthStone) where id = ?", id: [packageDic?["id"]!.int ?? "-1000"])
                    if !resultset2.next(){
                        
                        xlpSqliteManager.insertTable(kTableToolPackageHearthStone, sql: "clazz,created,id,remark,series,size,tag,updated,url,weight", dic: packageDic!)
                    }

                   
                }
            }
            
        }
        
    }
    func initViews() {
        
        let width = kSCREENWIDTH/3 - 10
        cardBt.xlpInitButton(nil, titleColor: nil, fontSize: nil, imageStr: "单卡查询点击前", backgroundImageStr: nil, cornerRedius: 0, superView: self.view, snpMaker: { (make) in
            make.left.equalTo(20)
            make.top.equalTo(150)
            make.width.equalTo(width)
            make.height.equalTo(width * 1.1)
        }) { (bt) in
            
        }
        cardManagerBt.xlpInitButton(nil, titleColor: nil, fontSize: nil, imageStr: "数据管理前", backgroundImageStr: nil, cornerRedius: 0, superView: self.view, snpMaker: { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(150)
            make.width.equalTo(width)
            make.height.equalTo(width * 1.1)
        }) { (bt) in
            self.navigationController?.pushViewController(YDToolDataManagerController(), animated: true)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
