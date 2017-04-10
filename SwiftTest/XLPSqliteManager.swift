
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
    
    
    /// 增 即插入新的数据
    ///
    /// - Parameters:
    ///   - table: 表名
    ///   - sql: sql语句
    ///   - dic: <#dic description#>
    /// - Returns: 返回bool值
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
    
    @discardableResult
    func insertTable(_ table:String,sql:String,limitArr:[Any]?) -> Bool {
        
        var bool = false
        if dataBase.open() {
            var arr = [String]()
            
            for _ in sql.components(separatedBy: ",") {
                
                arr.append("?")
            }
            
            let arrString = (arr as NSArray).componentsJoined(by: ",")
            let newSql = "insert into " + table + "(" + sql + ")" + "values" + "(" + arrString + ")"
            print("========插入时的语句为\(newSql)")
            bool = dataBase.executeUpdate(newSql, withArgumentsIn: limitArr)
            
            if bool {
                print("****************数据插入成功====================")
            }else{
                print("****************数据插入失败===failed: \(dataBase.lastErrorMessage())")
            }
            
            dataBase.close()
        }
        return bool
        
    }
    
    func insertTable(_ table:String,sql:String,dic:[String:Any],limitTag:[String]) -> Bool {
        
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
            
//            dataBase.executeQuery("select *from \(table) where ", withArgumentsIn: <#T##[Any]!#>)
            
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
    func queryTable(_ table:String,sql:String,id:[Any]?) -> FMResultSet {
        
        var resultSet = FMResultSet()
        
        if dataBase.open() {
            
//            let resultSet:FMResultSet = dataBase.executeQuery(sql, withArgumentsIn: id)
            resultSet = try! dataBase.executeQuery(sql, values: id)

//            let resultSet:FMResultSet = try! dataBase.executeQuery(sql, withVAList: <#T##CVaListPointer#>)//-> 此方法暂时未查到相关用法

           /*
            while resultSet.next() {
                
                print("=====查询结果为\(resultSet.string(forColumn: "icon")),\(resultSet.int(forColumn: "moduleID")),\(resultSet.string(forColumn: "tiny"))")
                resultArr.append("一个结果啦啦啦")
                
            }
            */
        }
        
        return resultSet
    }
    
    /// 销毁表
    ///
    /// - Parameter table: 表名
    /// - Returns: bool值
    @discardableResult
    func dropTable(_ table:String) -> Bool {
        
        var dropSucceed = false
        if dataBase.open() {
//            let sql = "drop from table \(table)" //句法错误
            
            let sql = "drop table \(table)"
            dropSucceed = dataBase.executeUpdate(sql, withArgumentsIn: nil)
            if !dropSucceed {
                print("======删除表失败\(dataBase.lastErrorMessage())")
            }
        }
        return dropSucceed
    }
    
    
    /// 删-删除表中数据
    ///
    /// - Parameters:
    ///   - table: 表名
    ///   - sql: 删除语句
    ///   - atWhere: 条件
    /// - Returns: bool值
    @discardableResult
    func deleteTable(_ table:String, sql:String ,atWhere:[Any]?) -> Bool {
        
        var deleteSucceed = false
        if dataBase.open() {
            
//            deleteSucceed = dataBase.executeUpdate(<#T##sql: String!##String!#>, withArgumentsIn: <#T##[Any]!#>)
//            deleteSucceed = dataBase.executeUpdate(sql, withParameterDictionary: <#T##[AnyHashable : Any]!#>)
//            try? dataBase.executeUpdate(sql, values: atWhere)
            deleteSucceed = dataBase.executeUpdate(sql, withArgumentsIn: atWhere)
            
//            let sql1 = "delete table titleArr where tiny = ?" //错误的
//            let sql2 = "delete from titleArr where tiny = ?"  //正确的 不能添加 * 号

//            let sql3 = "delete titleArr where tiny = ?" //错误的

            if !deleteSucceed {
                print("======删除数据失败\(dataBase.lastErrorMessage())")
            }
        }
        return deleteSucceed
    }
    
    
    /// 改 更新表中的数据
    ///
    /// - Parameters:
    ///   - table: <#table description#>
    ///   - sql: <#sql description#>
    ///   - atWhere: <#atWhere description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func updateTable(_ table:String,sql:String,atWhere:[Any]?) -> Bool {
        
        var updateSucceed = false
        
        if dataBase.open() {
            
            updateSucceed = dataBase.executeUpdate(sql, withArgumentsIn: atWhere)
            if !updateSucceed {
                print("======更新数据失败\(dataBase.lastErrorMessage())")

            }
            
        }
        dataBase.close()
        return updateSucceed
    }
    
    
    /// 给已经创建的表 添加字段
    ///
    /// - Parameters:
    ///   - column: 添加的字段名
    ///   - columnType: 添加的字段的数据类型 比如 text integer bool 等
    ///   - table: 被添加的表
    func addColumnToTable(_ column:String,columnType:String,table:String) {
        
        if dataBase.open(){
            
            if !dataBase.columnExists(column, inTableWithName: table){
                
                let sql:String = "ALTER TABLE \(table) ADD \(column) \(columnType)"
                let addSuccess = dataBase.executeUpdate(sql, withArgumentsIn: nil)
                if addSuccess {
                    print("====新增字段\(column)成功了==")
                }else{
                    print("====新增字段\(column)失败了==")
                }
                
            }else
            {
                print("====新增字段\(column)已经存在了")

            }
        }
    }
    
    
}
