
//
//  XLPSqliteManager.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/16.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import Foundation
import FMDB

class XLPSqliteManager {
    
    static let shareInstance = XLPSqliteManager()
    
    var dataBase :FMDatabase!
    
    
    /// 初始化数据库
    private init(){
    
        let path = kCreatFile("SwifTest.sqlite").0
        dataBase = FMDatabase.init(path: path)
        print("\(path)数据库已经初始化")
    }
    
    
    
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - table: 表名 类似coredata的 实体类
    ///   - sqlStr: 类似=="articleID integer UNIQUE,moduleID integer,replyNum integer,subClass text,thumbnail text,timestamp integer,title text,topFlag integer,author text,visitNum integer,canRead integer,type integer"
    func creatTable(_ table:String,sqlStr:String)   {
        
        if !dataBase!.open() {
            
            let hud = xlpHud.init(text: "亲,数据库未打开,初始化失败", constransY: 300)
            hud.show()
            hud.hideWhenAfter(time: 2)
            
            print("======Unable to open database========")
            
        }else{
            
            print("=============== open database=================")
            
            
            if dataBase.tableExists(table) {
                
                print("*********表已存在*******************")
                
            }else{
                
                let sql = "create table " + table + "(" + sqlStr + ")"
                
                if dataBase.executeUpdate(sql, withArgumentsIn: nil){
                    
                    print("******创建表成功*******************")
                }else{
                    print("********创建表失败===================")
                }
                dataBase.close()
            }
            
        }
        

    }
    
    @discardableResult
    func insertTable(_ table:String,sql:String,dic:[String:Any]) -> Bool {
        
        var bool = false
        if dataBase.open() {
            
            
            var valueArr = [Any]()
            var arr = [String]()
            
            for key in sql.components(separatedBy: ",") {
                
                valueArr.append(dic[key]!)
                arr.append("?")
            }
            
            let arrString = (arr as NSArray).componentsJoined(by: ",")
            let newSql = "insert into " + table + "(" + sql + ")" + "values" + "(" + arrString + ")"
            print("========插入时的语句为\(newSql)")
            bool = dataBase.executeUpdate(newSql, withArgumentsIn: valueArr)
    
            if bool {
                print("****************数据插入成功====================")
            }else{
                print("****************数据插入失败===failed: \(dataBase.lastErrorMessage())")
            }

            dataBase.close()
        }
        return bool
        
    }
    
    /// 查询 
    /// desc 逆序  asc 顺序
    /// - Parameters:
    ///   - table: <#table description#>
    ///   - sql: <#sql description#>
    ///   - id: <#id description#>
    /// - Returns: <#return value description#>
    func queryTable(_ table:String,sql:String,id:[Any]?) -> [Any] {
        
        var resultArr = [Any]()
        
        if dataBase.open() {
            
//            let resultSet:FMResultSet = dataBase.executeQuery(sql, withArgumentsIn: id)
            let resultSet:FMResultSet = try! dataBase.executeQuery(sql, values: id)

//            let resultSet:FMResultSet = try! dataBase.executeQuery(sql, withVAList: <#T##CVaListPointer#>)//-> 此方法暂时未查到相关用法


            while resultSet.next() {
                
                print("=====查询结果为\(resultSet.string(forColumn: "icon")),\(resultSet.int(forColumn: "moduleID")),\(resultSet.string(forColumn: "tiny"))")
                resultArr.append("一个结果啦啦啦")
                
            }
        }
        
        print("===========查询结果为\(resultArr.count)")
        return resultArr
    }
    
    func dropTable(_ table:String) -> Bool {
        
        var dropSucceed = false
        if dataBase.open() {
            let sql = "drop from \(table)"
            dropSucceed = dataBase.executeUpdate(sql, withArgumentsIn: nil)
        }
        return dropSucceed
    }
    
    func deleteTable(_ table:String, sql:String ,atWhere:[Any]?) -> Bool {
        
        var deleteSucceed = false
        if dataBase.open() {
            
//            deleteSucceed = dataBase.executeUpdate(<#T##sql: String!##String!#>, withArgumentsIn: <#T##[Any]!#>)
//            deleteSucceed = dataBase.executeUpdate(sql, withParameterDictionary: <#T##[AnyHashable : Any]!#>)
            deleteSucceed = dataBase.executeUpdate(sql, withArgumentsIn: atWhere)
        }
        return deleteSucceed
    }
}
