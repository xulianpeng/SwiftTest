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
        let path = NSHomeDirectory().appending("/Documents/SwiftTestCoreData.sqlite")
        //准尉url类型的路径
        let url = URL.init(fileURLWithPath: path);
        
        let store = try?coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: "", at: url, options: nil);
        if store == nil {
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
    func insertData(entyName:String,dic:NSDictionary) {
        
        let object = NSEntityDescription.insertNewObject(forEntityName: entyName, into: xlpContent!);
        let keyArr = dic.allKeys;
        for i in 0 ..< keyArr.count {
            
            let key = keyArr[i];
            let value = dic.object(forKey: key);
            object.setValue(value, forKey: key as! String);
            
            
        }
        
        xlpContent?.insert(object);
        if xlpContent!.hasChanges {
            
            print("*************coredata数据保存成功****************")
        }else{
            print("=============coredata数据保存貌似失败了===============")

        }
        
        
        
    }
    
    /**
     *  查询数据
      **/
    
    func fetchData(){
        
        let request = NSFetchRequest<NSFetchRequestResult>.init()
        
        request.entity = NSEntityDescription.entity(forEntityName: "ZhiHuEntity", in: xlpContent!)
        
        let arr = try? xlpContent?.fetch(request)
        print(arr ?? ["aaaaaaaa"])
        }
}

