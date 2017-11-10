//
//  YDToolDataManagerController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/28.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import FMDB
import Alamofire
class YDToolDataManagerController: XLPBaseViewController,UITableViewDelegate,UITableViewDataSource {

    var rootTableView = UITableView.init(frame: CGRect(x:0,y:64,width:kSCREENWIDTH,height:kSCREENHEIGHT - 64), style: .grouped)
    var dataArr = [Any]()
    
    var dataWildArr = [Any]()
    var dataStandArr = [Any]()
    var dataLastArr = [Any]()

    var showDetailBool0:Bool = false
    var showDetailBool1:Bool = false
    var showDetailBool2:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        showDetailBool0 = false
        showDetailBool1 = false
        showDetailBool2 = false
        getData()
        rootTableView.reloadData()
    }
    func initViews() {
        rootTableView.xlpInitTableViewEnd(delegate: self, superView: self.view, cellClass: [DataManagerCell.self,DataManagerSubCell.self])
    }
    func getData()  {
        let resultSet:FMResultSet = XLPSqliteManager.shareInstance.queryTable(kTableToolSeriesHearthStone, sql: "select *from \(kTableToolSeriesHearthStone)", id: nil)
        let dic11 = resultSet.resultDictionary()
        //print(dic11)
        while resultSet.next() {
            
            var dic = [String:Any]()
            /*
            dic["abbr"] = resultSet.string(forColumn: "abbr")
            dic["clazz"] = resultSet.string(forColumn: "clazz")
            dic["created"] = resultSet.int(forColumn: "created")
            dic["id"] = resultSet.int(forColumn: "id")
            dic["name"] = resultSet.string(forColumn: "name")
            dic["pubTime"] = resultSet.int(forColumn: "pubTime")
            dic["scored"] = resultSet.int(forColumn: "scored")
            dic["size"] = Int(resultSet.int(forColumn: "size"))
            dic["standard"] = resultSet.int(forColumn: "standard")
            dic["updated"] = resultSet.int(forColumn: "updated")
            dic["visible"] = resultSet.int(forColumn: "visible")
            dic["wild"] = IntFor(resultSet, column: "wild")
            */
            dic["abbr"] = resultSet.string(forColumn: "abbr")
            dic["clazz"] = resultSet.string(forColumn: "clazz")
            dic["created"] = IntFor(resultSet, column: "created")
            dic["id"] = IntFor(resultSet, column: "id")
            dic["name"] = resultSet.string(forColumn: "name")
            dic["pubTime"] = IntFor(resultSet, column: "pubTime")
            dic["scored"] = IntFor(resultSet, column: "scored")
            dic["size"] = IntFor(resultSet, column: "size")
            dic["standard"] = IntFor(resultSet, column: "standard")
            dic["updated"] = IntFor(resultSet, column: "updated")
            dic["visible"] = IntFor(resultSet, column: "visible")
            dic["wild"] = IntFor(resultSet, column: "wild")
            
            let seriesHearthStone = SeriesHearthStone.init(dic)
            
            if resultSet.string(forColumn: "name") != "衍生物" {
                if resultSet.int(forColumn: "standard") > 0 {
                    dataStandArr.append(seriesHearthStone)
                }else{
                    dataWildArr.append(seriesHearthStone)
                }
            }else{
                dataLastArr.append(seriesHearthStone)
            }
        }
        
        
        
        rootTableView.reloadData()
        
    }
    //MARK:tableview的代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            
            if (showDetailBool0) {
                return 1 + dataWildArr.count;
            }else{
                return 1
            }
        }else if(section == 1){
            if (showDetailBool1) {
                return 1 + dataStandArr.count;
            }else{
                return 1
            }
        }else if(section == 2){
            if (showDetailBool2) {
                return 1 + dataLastArr.count;
            }else{
                return 1
            }
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DataManagerCell") as! DataManagerCell
                cell.titleLabel.text = "狂野模式"
                cell.dataCountLabel.text = "100"
                cell.lookBt.tag = 100 + indexPath.section
                cell.lookBt.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DataManagerSubCell") as! DataManagerSubCell
                let series = dataWildArr[indexPath.row - 1] as! SeriesHearthStone
                cell.showWithSeries(series)
                cell.downBt.addTarget(self, action: #selector(downHandle), for: .touchUpInside)

                return cell
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DataManagerCell") as! DataManagerCell
                cell.titleLabel.text = "标准模式"
                cell.dataCountLabel.text = "101"
                cell.lookBt.tag = 100 + indexPath.section
                cell.lookBt.addTarget(self, action: #selector(showDetail), for: .touchUpInside)

                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DataManagerSubCell") as! DataManagerSubCell
                let series = dataStandArr[indexPath.row - 1] as! SeriesHearthStone
                cell.showWithSeries(series)
                cell.downBt.addTarget(self, action: #selector(downHandle(sender:)), for: .touchUpInside)
                return cell
            }
        }
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DataManagerCell") as! DataManagerCell
                cell.titleLabel.text = "衍生物"
                cell.dataCountLabel.text = "102"
                cell.lookBt.tag = 100 + indexPath.section
                cell.lookBt.addTarget(self, action: #selector(showDetail), for: .touchUpInside)

                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DataManagerSubCell") as! DataManagerSubCell
                let series = dataLastArr[indexPath.row - 1] as! SeriesHearthStone
                cell.showWithSeries(series)
                
//                let mmm = "\(indexPath.row * 10) + \(indexPath.section)"
                cell.downBt.tag = (indexPath.section + 1) * 10 + indexPath.row
                cell.downBt.addTarget(self, action: #selector(downHandle(sender:)), for: .touchUpInside)
                return cell
            }
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section == 0) {
            
            if (showDetailBool0) {
                return 40
            }
        }else if(indexPath.section == 1){
            if (showDetailBool1) {
                return 40
            }
        }else if(indexPath.section == 2){
            if (showDetailBool2) {
                return 40
            }
        }
        return 15 + kFontWithSize(16).lineHeight + kFontWithSize(12).lineHeight
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    /// cell的展开与删除的实现
    ///
    /// - Parameter sender: 按钮
    @objc func showDetail(_ sender:UIButton)  {
        
        let section = sender.tag - 100
        var rowsArray = [IndexPath]()
        if (section == 0) {
            showDetailBool0 = !showDetailBool0
            var i = 0
            for _ in dataWildArr {
                let index = NSIndexPath.init(row: i + 1, section: section)
                i += 1
                rowsArray.append(index as IndexPath)
            }
            sender.isSelected = showDetailBool0;
        }else if(section == 1){
            
            showDetailBool1 = !showDetailBool1;
            
            var i = 0
            for _ in dataStandArr {
                let index = NSIndexPath.init(row: i + 1, section: section) as IndexPath
                i += 1
                rowsArray.append(index)
            }
            sender.isSelected = showDetailBool1;
        }else if(section == 2){
            
            showDetailBool2 = !showDetailBool2;
            
            var i = 0
            for _ in dataLastArr {
                let index = NSIndexPath.init(row: i + 1, section: section) as IndexPath
                i += 1
                rowsArray.append(index)
            }
            sender.isSelected = showDetailBool2;
        }
        rootTableView.beginUpdates()
        if (sender.isSelected) {
            rootTableView.insertRows(at:rowsArray , with: .automatic)
        }else {
            
            rootTableView.deleteRows(at:rowsArray, with: .automatic)
        }
        rootTableView.endUpdates()
        
    }
    
    /// <#Description#>
    ///
    /// - Parameter sender: <#sender description#>
    @objc func downHandle(sender:UIButton){
        
        //给旧表添加字段 
        
        //前提是  section始终是个位数
        var row = 0
        var section = 0
        let mmm = "\(sender.tag)" as NSString
        if mmm.length >= 2 {
            
            let sectionStr = mmm.substring(to: 1)
            let rowStr = mmm.substring(from: 1)
            section = Int(sectionStr)! - 1
            row = Int(rowStr)!
            
            var series:SeriesHearthStone
            if section == 0 {
                
                series = dataWildArr[row - 1] as! SeriesHearthStone
            }else if section == 1{
                series = dataStandArr[row - 1] as! SeriesHearthStone
                
            }else{
                series = dataLastArr[row - 1] as! SeriesHearthStone
                
            }
            
            //根据series处理
            var imageUrl = ""
            let resultSet = xlpSqliteManager.queryTable(kTableToolPackageHearthStone, sql: "select * from \(kTableToolPackageHearthStone) where series = ?", id: [series.id!])
            while resultSet.next() {
                imageUrl = resultSet.string(forColumn: "url")
            }
            
            //下载图片解压到本地
            
            //let customQueue2 = DispatchQueue.init(label: "custom",attributes:.concurrent)
            
            
            let myQueue = DispatchQueue.global()
            myQueue.sync {
                
                MyManager.sharedInstance.GetData(imageUrl, parameters: [:], succeed: { (data11) in
                    
                    let path = kCreateDocDirectoryWith("CardData");
                    let outPath = kCreateDocDirectoryWith("Card/HearthStone");
                    let pathStr = kCreatFileLast("cardData", inPath: path)
                    
                    do {
                        try data11.write(to: URL.init(fileURLWithPath: pathStr), options: .atomic)
                        
                    } catch {
                        print(error)
                        
                        
                    }
                    
                    do{
                        try SSZipArchive.unzipFile(atPath: pathStr, toDestination: outPath, overwrite: true, password: nil);
                        
                        DispatchQueue.main.async {            
                            sender.setTitle("完成", for: .normal)
                        }
                        
                    }catch{
                        print(error)
                    }
                    
                })
                
            }
            
            
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
