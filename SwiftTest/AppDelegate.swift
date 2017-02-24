//
//  AppDelegate.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/9.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isIOS9orLater = true
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let rootVC = RootViewController()
        
        let rootVC = RootTabBarViewController()
        
//        let naVC = UINavigationController.init(rootViewController: rootVC)
        window?.rootViewController = rootVC
        
        //FIXME:全局键盘管理 键盘收回,只有点击键盘上的 done,添加 touchview方法后,整个页面向上偏移的距离没有返回
        let keyBoardManager = IQKeyboardManager.sharedManager()
        keyBoardManager.enable = true
        keyBoardManager.keyboardDistanceFromTextField = 20
        
        //MARK:微信支付注册
        
//        WXApi.registerApp(<#T##appid: String!##String!#>)
        
        if !IS_iOS9orLater() {
            
            isIOS9orLater = false
            
        }
        debugPrint("asdad哇哈哈哈")
       printLog(message: "这是一条输出")
        return true
    
    }
    
    func printLog<T>(message: T,
                  file: String = #file,
                  method: String = #function,
                  line: Int = #line)
    {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK:支付回调处理 支付宝 微信
    //条件判断 只能是bool值  不能是有返回值的函数  #if  #endif  成对出现
    #if isIOS9orLater
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    
    
        return true
    }
    #else
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    
    if (url.host == "safepay") {
    //跳转支付宝钱包进行支付，处理支付结果
    AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
    print(resultDic ?? "")
    })
    }
    return true
    }
    #endif
    
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SwiftTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

