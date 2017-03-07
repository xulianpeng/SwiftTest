//
//  XLPCoreDataManager.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/9.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import CoreData
//class XLPCoreDataManager: NSObject {
//
//}


class XLPCoreDataManager {
    
    var xlpContent : NSManagedObjectContext?;
    
    

    // 方法一
    static let shareInstance = XLPCoreDataManager()
    private init(){} //这是将系统的初始化方法 私有化,防止 误调用 系统的初始化方法 而未调用 自定义的单利生成方法
     
     //此方法的缺点是 每次调用还得 调用 下面的obtainContext() 方法  初始化xlpContent
     /*
     xlpCoredataManager.obtainContext()
     
     //            let top_stroies = json["top_stroies"].array
     //            let stories = json["stories"].array
     
     
     let dic = ["id":9134014,"title":"为什么国产电视剧看起来那么「假」？","type":0,"images":"http://pic2.zhimg.com//e79233a292a18b351079110a4a245d65.jpg","ga_prefix":"010914"] as [String : Any]
     xlpCoredataManager.insertData(entyName: "ZhiHuEntity", dic: dic as NSDictionary)
     */
     //为了解决此问题 尝试 在单例方法方法里面 即调用 该方法 采用方法二
     
 
    
    /*
    //方法二 
    class func shareInstance()->XLPCoreDataManager{
        let myXLPCoreDataManager = XLPCoreDataManager();
        obtainContext()
        return myXLPCoreDataManager;
    }
     此方法 暂时不行
    */
    
    func obtainContext()  {
        
        //拿到资源文件
        let filePath = Bundle.main.url(forResource: "SwiftTest", withExtension: "momd");
        
        if filePath == nil{
            
            return
        }
        
        
        //读取数据模型
        let model = NSManagedObjectModel.init(contentsOf: filePath!)!;
        
        //根据model初始化数据助理
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: model);
        //将数据模型存储到沙盒路径下
        let path = kGetDocumentPath().appendingPathComponent("SwiftTestCoreData.sqlite")
        //准尉url类型的路径
//        let url = URL.init(string: path)
        let url = URL.init(fileURLWithPath: path)
        let options =  [ NSMigratePersistentStoresAutomaticallyOption : true,
          NSInferMappingModelAutomaticallyOption : true ]
//        try let store:NSPersistentStore = try! coordinator.addPersistentStore(ofType:NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        var mmm : Any?
        
        do {
            let store = try coordinator.addPersistentStore(ofType:NSSQLiteStoreType, configurationName: nil, at: url, options: options)
            mmm = store
        } catch  {
            print("创建store出现问题\(Error.self)")
        }
        
        if mmm == nil {
            //数据库存储异常
            print("数据存储异常");
        }else
        {
            print("============coredata数据库的文件路径\(path)====================")
        }
        
        xlpContent = NSManagedObjectContext.init(concurrencyType:NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType);
        xlpContent?.persistentStoreCoordinator = coordinator;
        
    }
    
    /**添加数据
     *
     */
    func insertData(_ entyName:String,dic:NSDictionary) {
        
        let object = NSEntityDescription.insertNewObject(forEntityName: entyName, into: xlpContent!);
        let keyArr = dic.allKeys;
        for i in 0 ..< keyArr.count {
            
            let key = keyArr[i];
            let value = dic.object(forKey: key);
            object.setValue(value, forKey: key as! String);
        }
        xlpContent?.insert(object);
        
        
        
    
    
        print("===将要存储的实体为=\(object)=====")
        if xlpContent!.hasChanges {
    
            try!xlpContent?.save()
            print("*************coredata数据保存成功****************")
        }else{
            print("=============coredata数据保存貌似失败了===============")

        }
    
    
    
    }
    
    /**
     *  查询数据
      **/
    
    func fetchData(_ entityName:String) -> [NSManagedObject]{
        
        let request = NSFetchRequest<NSFetchRequestResult>.init()
        request.entity = NSEntityDescription.entity(forEntityName: entityName, in: xlpContent!)
//        let predicate = NSPredicate.init()
        
        
        
        let searchResults = try! xlpContent?.fetch(request)
        
        print(searchResults?.count)
        
        return searchResults as![NSManagedObject]
        }
}


/// 这个是最终版
class XLPCoreDataManager1 {
    
    var xlpContent : NSManagedObjectContext?;
    
    
    
    // 方法一
    static let shareInstance = XLPCoreDataManager1()
    private init(){} //这是将系统的初始化方法 私有化,防止 误调用 系统的初始化方法 而未调用 自定义的单利生成方法
    
    
    ///这个方法是初始化系统的coredata环境.类似SQ部署相关环境.appdelegate里面相关的coredata方法 则不再使用. 切记切记
    func obtainContext()  {
        
        //读取数据模型
        let model = NSManagedObjectModel.mergedModel(from: nil)
        
        //根据model初始化数据助理
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: model!);
        //将数据模型存储到沙盒路径下
        let path = kGetDocumentPath().appendingPathComponent("SwiftTestCoreData.sqlite")
        //准尉url类型的路径
        let url = URL.init(fileURLWithPath: path)
        
//        let options =  [ NSMigratePersistentStoresAutomaticallyOption : true,
//                         NSInferMappingModelAutomaticallyOption : true ]
       
        try! coordinator.addPersistentStore(ofType:NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        xlpContent = NSManagedObjectContext.init(concurrencyType:NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        xlpContent?.persistentStoreCoordinator = coordinator ;
        
        print("============coredata数据库的文件路径\(path)====================")
        
    }
    
    /**添加数据
     *
     */
    func insertData(_ entyName:String,dic:NSDictionary) {
        
        let object = NSEntityDescription.insertNewObject(forEntityName: entyName, into: xlpContent!);
        let keyArr = dic.allKeys;
        for i in 0 ..< keyArr.count {
            
            let key = keyArr[i];
            let value = dic.object(forKey: key);
            object.setValue(value, forKey: key as! String);
        }
        xlpContent?.insert(object)
        print("===将要存储的实体为=\(object)=====")
        if xlpContent!.hasChanges {
            
            try!xlpContent?.save()
            print("*************coredata数据保存成功****************")
        }else{
            print("=============coredata数据保存貌似失败了===============")
            
        }
    }
    
    /// 删除数据
    ///
    /// - Parameters:
    ///   - entityName: 实体名
    ///   - predicatStr: 约束条件
    func deleteData(_ entityName:String,predicatStr:String) {
        //构建查询请求 NSFetchRequestResult
        let request = NSFetchRequest<NSManagedObject>.init();
        //设置查询请求，查询模型
        request.entity = NSEntityDescription.entity(forEntityName: entityName, in: xlpContent!);
        //设置查询条件
        let predicate = NSPredicate.init(format: predicatStr);
        request.predicate = predicate;
        //执行查询请求
        let objectArr = try?xlpContent?.fetch(request);
        
        
        for object in objectArr!! {
            
            xlpContent?.delete(object);
        }
        
    }
    
    /// 更新数据
    ///
    /// - Parameters:
    ///   - entityName: 实体名
    ///   - predicatStr: 约束条件 -> 确定为哪一个数据  //id=120 数字类型的可以直接这样写,即使你的id类型是string类型,若是name='徐联朋',则必须加上单引号
    ///   - newValueDic: 新值字典
    func updateData(_ entityName:String,predicatStr:String,newValueDic:NSDictionary) -> Void {
        
        //构建查询请求 NSFetchRequestResult
        let request = NSFetchRequest<NSManagedObject>.init();
        //设置查询请求，查询模型
        request.entity = NSEntityDescription.entity(forEntityName: entityName, in: xlpContent!);
        //设置查询条件
        let predicate = NSPredicate.init(format: predicatStr);
        request.predicate = predicate;
        //执行查询请求
        let objectArr = try?xlpContent?.fetch(request);
        
        for object in objectArr!! {
           
            let keyArr = newValueDic.allKeys;
            for i in 0 ..< keyArr.count {
                
                let key = keyArr[i];
                let value = newValueDic.object(forKey: key);
                object.setValue(value, forKey: key as! String);
            }
            
        }
        
        if xlpContent!.hasChanges {
            
            try!xlpContent?.save()
            print("*************coredata数据更新成功****************")
        }else{
            print("=============coredata数据更新貌似失败了===============")
            
        }
        
        
    }
    /**
     *  查询所有数据
     **/
    
    func fetchData(_ entityName:String) -> [NSManagedObject]{
        
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        let searchResults = try! xlpContent?.fetch(request)
        let arr = searchResults as![NSManagedObject]
        return arr
    }
}
