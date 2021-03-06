
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
import Alamofire
import SDWebImage
import SwiftyJSON
import FMDB
import YYModel
import Meiqia

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var rootIndex = 0
    var lastRootIndex = 0
    let pageCount = 3
    var conVIDArr = [123,456,789,110,220,330,440,550,660,770,880,990]
    
    
    var window: UIWindow?
    var isIOS9orLater = true
    
    var dataBase : FMDatabase?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let url = URL.init(string: "www.baidu.com")
        
//        let url2 = URL.init(string: "http:// baidu.com")
        

//        print("============网址为\(url!)===\(url2!)")
        
        let str11 = OCTool.kObtainDeviceVersion()
        print("====s设备的型号为 ===\(str11!)")
        
        
        let rootVC = RootTabBarViewController()
        self.window = UIWindow.init(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT))
        self.window!.rootViewController = rootVC
        self.window!.makeKeyAndVisible()
        
        //测试其他window
        
//        var windowStatus = UIWindow.init(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT/2))
//        windowStatus.windowLevel = UIWindowLevelStatusBar
//        windowStatus.backgroundColor = UIColor.red
////        windowStatus.isHidden = false
//
//        windowStatus.makeKeyAndVisible()
//        
//        var windowAlert = UIWindow.init(frame: CGRect(x:0,y:kSCREENHEIGHT/2,width:kSCREENWIDTH,height:kSCREENHEIGHT/2 - 100))
//        windowAlert.windowLevel = UIWindowLevelAlert
//        windowAlert.backgroundColor = UIColor.green
////        windowAlert.isHidden = false
//        windowAlert.makeKeyAndVisible()

        
        downAD()
        
        //FIXME:全局键盘管理 键盘收回,只有点击键盘上的 done,添加 touchview方法后,整个页面向上偏移的距离没有返回
        let keyBoardManager = IQKeyboardManager.sharedManager()
        keyBoardManager.enable = true
        keyBoardManager.keyboardDistanceFromTextField = 20
        
        //MARK:微信支付注册
        
//        WXApi.registerApp(<#T##appid: String!##String!#>)
        
//        if !IS_iOS9orLater() {
//            
//            isIOS9orLater = false
//            
//        }
        debugPrint("asdad哇哈哈哈")
        ///这个只能做调试用 如果想实现进入一个视图控制器 打印输出控制器的名字 则在XLPBaseViewController里面 viewDidLoad里面添加代码如下: print("====当前将要进入视图====\(self.description)")//MARK:这个告诉我们当前所在的视图控制器的名字
       printLog(message: "这是一条输出")
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(netChanged), name: NSNotification.Name(rawValue: "netStatusChanged"), object: nil)
        
        ///userdefaults
        
        UserDefaults.standard.setValue("测试一下", forKey: "测试Demo")
        UserDefaults.standard.synchronize()
        
        let arr = ["asda","12331","ajkaljskljkj","ahgasuydg"]
        
        UserDefaults.standard.setValue(arr, forKey: "测试数组")
        UserDefaults.standard.synchronize()
        
        kUserDefaults("asas", key: "什么")
        
        print(kUserDefaultsValue("什么"))
        let zzz = UserDefaults.standard.value(forKey: "测试Demo")
        
        kUserDefaults("我当时这样子想的哈哈哈", key: "测试自定义1")
        print(zzz!,"======\(UserDefaults.standard.value(forKey:"测试数组")!)","\(UserDefaults.standard.value(forKey: "测试自定义1"))","======\(kUserDefaultsValue("测试自定义1"))=======")
        
        
        
        SDWebImageManager.shared().imageCache.maxCacheSize = 1024 * 30
        print(SDWebImageManager.shared().imageCache.getSize())
        let sdCachePath = kCreateDocDirectoryWith("xlp")
        
        SDWebImageManager.shared().imageCache.defaultCachePath(forKey: sdCachePath)
        
        print(SDWebImageManager.shared().imageCache.getSize()/(1024 * 1024))
        
        
        
        
        let lastPath = kCreatFile("ios.text").0
        print(kCreatFile("ios.text"))
        
        kWriteStringToFile("万哥哥擦擦擦擦擦擦擦擦擦擦万哥哥擦擦擦擦擦擦擦擦擦擦万哥哥擦擦擦擦擦擦擦擦擦擦万哥哥擦擦擦擦擦擦擦擦擦擦万哥哥擦擦擦擦擦擦擦擦擦擦", at: lastPath)
        
        print(kGetFileSizeMBAtPath(lastPath))

        //MARK:关于除法的心得
        ///除法 0.被除数和除数 必须类型一致; 
        ///1.整数相除,则结果取整;
        ///2.浮点数相除,结果为对应的类型浮点数 所以计算缓存时强制转为 浮点数 最后取精度
        print(4/2,1/3,7/3,7.01/3,7.01/2.3)
        
        obtainTitleArr()
        
        let mm = kCreatFile("mm.text", inPath: kCreateDocDirectoryWith("xlp"))
        kWriteStringToFile("万哥哥擦擦擦擦擦擦擦擦擦擦万哥哥擦擦擦擦擦擦擦擦擦擦万哥哥擦擦擦擦擦擦擦擦擦擦万哥哥擦擦擦擦擦擦擦擦擦擦万哥哥擦擦擦擦擦擦擦擦擦擦", at: mm.0)
        
        obtainTitleArrFromDB()
        
//        print(kCreateDocDirectoryWith("Magic/Card"))
//        xlpSqliteManager.creatTable("test", sqlStr: "icon text,moduleID integer UNIQUE,oldTitle text,remark text,tiny text,title text,version text,visible integer,weight integer")

        XlpFMDB.init(dbName: "xlpTest.sqlite").creatTable("mmm", sqlStr:  "icon text,moduleID integer UNIQUE,oldTitle text,remark text,tiny text,title text,version text,visible integer,weight integer")
        
        XlpFMDB.init(dbName: "xlpTest11.db").creatTable("mmm", sqlStr:  "icon text,moduleID integer UNIQUE,oldTitle text,remark text,tiny text,title text,version text,visible integer,weight integer")

        XlpFMDB.init(dbName: "xlpTest12.db1").creatTable("mmm", sqlStr:  "icon text,moduleID integer UNIQUE,oldTitle text,remark text,tiny text,title text,version text,visible integer,weight integer")
        XlpFMDB.init(dbName: "xlpTest13.mmm").creatTable("mmm", sqlStr:  "icon text,moduleID integer UNIQUE,oldTitle text,remark text,tiny text,title text,version text,visible integer,weight integer")
        
        

        //表添加字段
        xlpSqliteManager.addColumnInTable("testColumn",columnType:"text",table: kTableToolPackageHearthStone)
        
        let str123 = "1231412"
        let str1234 = "1231412.12345678"

        let int123 = 3123
        let int1234 = 213123123123.12376787679

        
        //坑点:浮点数转字符串 使用 String()方法 会自动在小数点后第三位 四舍五入
        print(Int(str123)!,Double(str1234)!,String(int123),String(int1234))
        
//        XlpFMDB.init(dbName: "mechat.sqlite").creatTable("QuickReply", sqlStr:  "content text,content_type text,created_on text,enterprise_id integer,group_id integer,id integer,knowledge_converted integer,last_updated text,rank integer,rich_content text,title text")

        
        displayAD()

        XLPSqliteManager.shareInstance.creatTable("QuickReply", sqlStr:"content text,content_type text,created_on text,enterprise_id integer,group_id integer,id integer,knowledge_converted integer,last_updated text,rank integer,rich_content text,title text" )
        
        XLPSqliteManager.shareInstance.insertTable("test", sql:
            "icon,moduleID,oldTitle,remark,tiny,title,version,visible,weight", limitArr: [["key0":"ceshiurl","key1":"ceshiurl","key2":"ceshiurl"],123,"你好啊","打招呼","你好","你好1","3.4.9",1,3])
        XLPSqliteManager.shareInstance.insertTable("test", sql:
            "icon,moduleID,oldTitle,remark,tiny,title,version,visible,weight", limitArr: ["111111",123,"你好啊","打招呼","你好","你好1","3.4.9",1,3])
        
//        XLPSqliteManager.shareInstance.insertTable("QuickReply", sql: "INSERT INTO QuickReply (content,knowledge_converted,rich_content,id,group_id,enterprise_id,created_on,title,rank,content_type,last_updated) VALUES ('<DIV class=operatorfont style="MARGIN-LEFT: 5px"><SPAN style='FONT-SIZE: 9pt; FONT-FAMILY: 宋体; mso-font-kerning: 1.0000pt; mso-spacerun: "yes"'><?xml:namespace prefix = "o" ns = "urn:schemas-microsoft-com:office:office" /><o:p><FONT face=微软雅黑 size=3><!--StartFragment -->
//            <DIV>我们11年以来的地址是在：解放碑纽约纽约大厦3.4.5楼（太平洋百货对面金夫人影楼的楼上）。第一次来咨询的顾客，可以先到3楼接待大厅，我们有专业的导诊为您安排咨询服务。</DIV></FONT></o:p></SPAN><!--EndFragment--></DIV>',1,'',449400,65986,5869,'2016-11-10T07:49:13.643512','医院地址',400000,'text','2016-11-18T10:39:01.191339')", limitArr: nil)

//            xlpSqliteManager.insertTable(kTableModuleList, sql: "moduleID,tiny,title,weight", limitArr:arr)

//        var str:String = "<DIV class=operatorfont style="MARGIN-LEFT: 5px"><SPAN style='FONT-SIZE: 9pt; FONT-FAMILY: 宋体; mso-font-kerning: 1.0000pt; mso-spacerun: "yes"'><?xml:namespace prefix = "o" ns = "urn:schemas-microsoft-com:office:office" /><o:p><FONT face=微软雅黑 size=3><!--StartFragment -->
//        <DIV>我们11年以来的地址是在：解放碑纽约纽约大厦3.4.5楼（太平洋百货对面金夫人影楼的楼上）。第一次来咨询的顾客，可以先到3楼接待大厅，我们有专业的导诊为您安排咨询服务。</DIV></FONT></o:p></SPAN><!--EndFragment--></DIV>"
//        
//        var contentData: Data = "<DIV class=operatorfont style="MARGIN-LEFT: 5px"><SPAN style='FONT-SIZE: 9pt; FONT-FAMILY: 宋体; mso-font-kerning: 1.0000pt; mso-spacerun: "yes"'><?xml:namespace prefix = "o" ns = "urn:schemas-microsoft-com:office:office" /><o:p><FONT face=微软雅黑 size=3><!--StartFragment -->
//        <DIV>我们11年以来的地址是在：解放碑纽约纽约大厦3.4.5楼（太平洋百货对面金夫人影楼的楼上）。第一次来咨询的顾客，可以先到3楼接待大厅，我们有专业的导诊为您安排咨询服务。</DIV></FONT></o:p></SPAN><!--EndFragment--></DIV>".data(using: .utf8)!//Data.ini//NSData.init(contentsOfFile: "asdasdasdasdabadshfj附近撒发生sad返回键阿斯蒂芬12313123")
//        
//        var str:String = String.init(data: contentData, encoding: .utf8)!
//        
//        print("最终的输出字符转为===",str,"===")
        
//        xlpSqliteManager.insertTable("QuickReply", sql: "content,content_type,created_on,enterprise_id,group_id,id,knowledge_converted,last_updated,rank,rich_content,title", limitArr:['<DIV class=operatorfont style="MARGIN-LEFT: 5px"><SPAN style='FONT-SIZE: 9pt; FONT-FAMILY: 宋体; mso-font-kerning: 1.0000pt; mso-spacerun: "yes"'><?xml:namespace prefix = "o" ns = "urn:schemas-microsoft-com:office:office" /><o:p><FONT face=微软雅黑 size=3><!--StartFragment --><DIV>我们11年以来的地址是在：解放碑纽约纽约大厦3.4.5楼（太平洋百货对面金夫人影楼的楼上）。第一次来咨询的顾客，可以先到3楼接待大厅，我们有专业的导诊为您安排咨询服务。</DIV></FONT></o:p></SPAN><!--EndFragment--></DIV>'",1,'',449400,65986,5869,'2016-11-10T07:49:13.643512','医院地址',400000,'text','2016-11-18T10:39:01.191339'])
//        let str = "  http://表情❤️屎  asdhjhasdasdasd\n你好啊骚年    "
    
//        var mmm = kStringContainEmotion(str)
        
//        print(kStringRemoveWhitespaces(str),"\n\(kStringRemoveWhitespacesAndNewlines(str))","\n\(kStringRemoveAllWhitespaces(str))","\n\(kStringRemoveAllWhitespacesAndNewlines(str))")
        
        
        let dic :[String:Any] = ["name":"xlp","sex":"man"]
        
        var model = XlpModel.yy_model(with: dic)
        
//        "<DIV class=operatorfont style=\"MARGIN-LEFT: 5px\"><SPAN style=\'FONT-SIZE: 9pt; FONT-FAMILY: 宋体; mso-font-kerning: 1.0000pt; mso-spacerun: \"yes\"\'><?xml:namespace prefix = \"o\" ns = \"urn:schemas-microsoft-com:office:office\" /><o:p><FONT face=微软雅黑 size=3><!--StartFragment -->
//        <DIV>我们11年以来的地址是在：解放碑纽约纽约大厦3.4.5楼（太平洋百货对面金夫人影楼的楼上）。第一次来咨询的顾客，可以先到3楼接待大厅，我们有专业的导诊为您安排咨询服务。</DIV></FONT></o:p></SPAN><!--EndFragment--></DIV>"
        
        
        
        print(model)
        
        
        
        print("=====现在是 海外版的APP 啦啦啦啦========xlp分支啦啦啦  =====")
        
        print("======啦啦啦啦啦啦xlp11======")
        
       
        
        self.rootIndex = conVIDArr.index(of: 880)!
        
        lastRootIndex = self.rootIndex
        
        var FirstArr = obtainFistArr(theIndex: self.rootIndex)
        
        var newArr11 = obtainLastIDArr(theIndex: lastRootIndex)
        var newArr22 = obtainLastIDArr(theIndex: lastRootIndex )
        var newArr333 = obtainLastIDArr(theIndex: lastRootIndex)
        
        var newArr1 = obtainNextIDArr(theIndex: self.rootIndex+1)
        var newArr2 = obtainNextIDArr(theIndex: self.rootIndex+1)
        var newArr33 = obtainNextIDArr(theIndex: self.rootIndex+1)
        
       

        print(self.rootIndex,newArr1,newArr2,newArr33)
        
        MQManager.initWithAppkey("4fa38cc3e75af7bd2b99c9e986baac64") { (clientId, error) in
         print(clientId)
            
        }
        
    
        let dict = ["27":"w","15":"t","36":"b"]
        
        let keys = dict.sorted(by: {$0.0 < $1.0})
        
        let values = dict.sorted(by: {$0.1 < $1.1})
        
        print(keys)
        
        print(values)
        
        
        var newArr = conVIDArr.filter { (mm1) -> Bool in
            mm1 > 300
        }
      print("最终的结果为",newArr)
        
        print("最终的结果为111",newArr)
        print("最终的结果为222",newArr)
        
        
        
        
        
        
        
        
        
        
        
        print(anyToString(123 as AnyObject))
        print(anyToString(12.345 as AnyObject))
        print(anyToString(0.123 as AnyObject))
        print(anyToString("null" as AnyObject))
        print(anyToString(nil))
        print(anyToString(NSNumber.init(value: 0.3)))
        print(anyToString(NSNull.init()))
        print(anyToString("123" as AnyObject))
        print(anyToString("你好啊" as AnyObject))
        
        print(anyToString0(123 ))
        print(anyToString0(12.3489))
        print(anyToString0(0.123))
        print(anyToString0("null" ))
        print(anyToString0(nil))
        print(anyToString0(NSNumber.init(value: 0.3)))
        print(anyToString0(NSNumber.init(value: 12.3)))
        print(anyToString0(NSNumber.init(value: 123)))
        print(anyToString0(NSNull.init()))
        print(anyToString0("123"))
        print(anyToString0("你好啊"))

        
//        var allsteps = climbStairs(mm: 50)
//        print("=====123",allsteps)
        
        
        print("=====1234",obtainStr(str: "adadssssaaaalllssdasss"))
        
        
        let arr111 = ["123","345","456","567","123","345","456","567"]
        
        let lastStr = arr111.reduce(String()) { (string1, str) -> String in
//                return string1 == "" ? str : string1 + "、" + str
            if string1 == "" {
                return str
            }else{
                return string1 + "、" + str
            }
        }
        print("数组reduce的最终结果为",lastStr)
        
        
//        let uniArr = arr111.reduce(Set()) { (set0, str) in
//             set0.insert(str)
//        }
//        let uniArr = arr111.reduce(Set<String>()) { (aSet, str) -> Set<String> in
////            print(aSet,str)
//            aSet.insert(str)
//            return Set<String>()
//        }
        
        
        let uniArr = arr111.reduce(into: Set<String>()) { (aSet, str) in
            aSet.insert(str)
            }.map { $0 }
        //数组去重的应用场景, 先转为 集合set 再通过map函数转为 数组.
        print("数组reduce的最终结果为",uniArr)
         print("=====是否包含呢==",self.testArrcontainEmptyStr())
        
        return true
    
    }
    
    //下拉 获取上一组数据
    func obtainLastIDArr(theIndex:Int) -> [Int] {
        var resultArr = [Int]()
        if theIndex  - pageCount >= 0{
            resultArr = (self.conVIDArr as NSArray).subarray(with: NSMakeRange(theIndex  - pageCount, pageCount)) as! [Int]
            if resultArr.count > 0{
                self.lastRootIndex = theIndex  - pageCount
            }
        }else{
            resultArr = (self.conVIDArr as NSArray).subarray(with: NSMakeRange(0, theIndex))  as! [Int]
            if resultArr.count > 0{
                self.lastRootIndex = 0
            }
        }
        return resultArr
    }
    //上拉 获取下一组数据
    
    func obtainNextIDArr(theIndex:Int) -> [Int] {
        var resultArr = [Int]()
        if self.conVIDArr.count - (theIndex  + pageCount) >= 0{
            resultArr = (self.conVIDArr as NSArray).subarray(with: NSMakeRange(theIndex, pageCount)) as! [Int]
            if resultArr.count > 0{
                self.rootIndex = theIndex + pageCount - 1
            }
            
        }else{
            //获取最后的
            resultArr = (self.conVIDArr as NSArray).subarray(with: NSMakeRange(theIndex, self.conVIDArr.count - theIndex)) as! [Int]
            if resultArr.count > 0{
                self.rootIndex = self.conVIDArr.count-1
            }
        }
        return resultArr
    }
    
    //下拉 获取上一组数据
    func obtainLastIDArr11(theIndex:Int) -> [Int] {
        var resultArr = [Int]()
        if theIndex  - pageCount >= 0{
            resultArr = (self.conVIDArr as NSArray).subarray(with: NSMakeRange(theIndex  - pageCount, pageCount)) as! [Int]
            if resultArr.count > 0{
                self.lastRootIndex = theIndex  - pageCount
            }
        }else{
            
            //下拉获取最后一组 不满足 pagecount
            
            resultArr = (self.conVIDArr as NSArray).subarray(with: NSMakeRange(0, theIndex))  as! [Int]
            if resultArr.count > 0{
                self.lastRootIndex = 0
            }
        }
        return resultArr
    }
    //上拉 获取下一组数据
    
    func obtainNextIDArr11(theIndex:Int) -> [Int] {
        var resultArr = [Int]()
        if self.conVIDArr.count - (theIndex  + pageCount) >= 0{
            resultArr = (self.conVIDArr as NSArray).subarray(with: NSMakeRange(theIndex, pageCount)) as! [Int]
            if resultArr.count > 0{
                self.rootIndex = theIndex + pageCount - 1
            }
            
        }else{
            //上拉 获取最后的一组 不满足 pagecount
            resultArr = (self.conVIDArr as NSArray).subarray(with: NSMakeRange(theIndex, self.conVIDArr.count - theIndex)) as! [Int]
            if resultArr.count > 0{
                self.rootIndex = self.conVIDArr.count-1
            }
        }
        return resultArr
    }
    
    func obtainFistArr(theIndex:Int) -> [Int] {
        
        var resultArr = [Int]()
        if self.conVIDArr.count <= pageCount {
            
            return self.conVIDArr
            
        }else{
            
            if self.conVIDArr.count - (theIndex  + pageCount) >= 0{
                resultArr = (self.conVIDArr as NSArray).subarray(with: NSMakeRange(theIndex, pageCount)) as! [Int]
                if resultArr.count > 0{
                    self.rootIndex = theIndex + pageCount - 1
                }
            }else
            {
                resultArr = (self.conVIDArr as NSArray).subarray(with: NSMakeRange(self.conVIDArr.count - pageCount, pageCount)) as! [Int]
                if resultArr.count > 0{
                    self.rootIndex = self.conVIDArr.count-1
                    self.lastRootIndex = self.conVIDArr.count - pageCount
                }
            }
        }
        return resultArr
        
    }
    
    
    @objc func netChanged(notification:NotificationCenter) {

        let netStatusManager = NetworkReachabilityManager()

        if (netStatusManager?.isReachable)!{
            
            showHud(text: "网络链接已成功", yHeight: 200)
        }else{
            showHud(text: "网络链接已失败", yHeight: 200)
        }
        
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
        
        downAD()
        displayAD()
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
    func initDataBase() {
        
//        let path = kCreatFile("SwifTest.sqlite").0
        
        
        let pathArr = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docPath:NSString = pathArr[0] as NSString
        let path = docPath.strings(byAppendingPaths: ["SwifTest.sqlite"]).last
        
        if dataBase == nil {
            dataBase = FMDatabase.init(path: path)
        }else{
            print("\(path)数据库已经初始化")
        }

        
    }
    
    func creatTable(_ table:String,sqlStr:String)  {
        if !dataBase!.open() {
            
            let hud = xlpHud.init(text: "亲,数据库未打开,初始化失败", constransY: 300)
            hud.show()
            hud.hideWhenAfter(time: 2)
            
            print("======Unable to open database========")
            
        }else{
            
            print("=============== open database=================")
            
            
            
            if (dataBase?.tableExists(table))! {
                
                print("*********表已存在*******************")
                
            }else{
                
                let sql = "create table " + table + "(" + sqlStr + ")"
                
                if (dataBase?.executeUpdate(sql, withArgumentsIn: nil))!{
                    
                    print("******创建表成功*******************")
                }else{
                    print("********创建表失败===================")
                }
                dataBase?.close()
            }
            
        }
        
    }
    @discardableResult
    func insertTable(_ table:String,sql:String,dic:[String:Any])  -> Bool{
        
        var bool = false
        if dataBase!.open() {
            
            
            var valueArr = [Any]()
            var arr = [String]()
            
            for key in sql.components(separatedBy: ",") {
                
                valueArr.append(dic[key]!)
                arr.append("?")
            }
            
            let arrString = (arr as NSArray).componentsJoined(by: ",")
            let newSql = "insert into " + table + "(" + sql + ")" + "values" + "(" + arrString + ")"
            print("========插入时的语句为\(newSql)")
            bool = dataBase!.executeUpdate(newSql, withArgumentsIn: valueArr)
            
            if bool {
                print("****************数据插入成功====================")
            }else{
                print("****************数据插入失败===failed: \(dataBase!.lastErrorMessage())")
            }
            
            dataBase!.close()
        }
        return bool

    }
    func obtainTitleArr()  {
        
        
//        initDataBase()
//        creatTable("titleArr", sqlStr: "icon text,moduleID integer UNIQUE,oldTitle text,remark text,tiny text,title text,version text,visible integer,weight integer")
        
        
        
        ///获得标题数组
        xlpSqliteManager.creatTable("test", sqlStr: "icon text,moduleID integer UNIQUE,oldTitle text,remark text,tiny text,title text,version text,visible integer,weight integer")
        xlpSqliteManager.creatTable("titleArr", sqlStr: "icon text,moduleID integer UNIQUE,oldTitle text,remark text,tiny text,title text,version text,visible integer,weight integer")
        MyManager.sharedInstance.SucceedGETFull2(xlpNetGetTitleModel, parameters: [:]) { (json, error) in
            
            if error == nil,let modules = json?["modules"].array{
                
                
                for dic in modules{
                    
                    
                    var newDic = [String:Any]()
                    
                    newDic["icon"] = dic["icon"].string!
                    newDic["moduleID"] = dic["id"].int!
                    newDic["oldTitle"] = dic["oldTitle"].string!
                    newDic["remark"] = dic["remark"].string!
                    newDic["tiny"] = dic["tiny"].string!
                    newDic["title"] = dic["title"].string!
                    newDic["version"] = dic["version"].int!
                    newDic["visible"] = dic["visible"].int!
                    newDic["weight"] = dic["weight"].int!
                    
                    
//                    self.insertTable("titleArr", sql: "icon,moduleID,oldTitle,remark,tiny,title,version,visible,weight", dic: newDic)
                    xlpSqliteManager.insertTable("titleArr", sql: "icon,moduleID,oldTitle,remark,tiny,title,version,visible,weight", dic: newDic)
                    
                }
            }else{
                
//                print(error ?? NSError.init() as? Error )
            }
            
            
        }
    }
    func obtainTitleArrFromDB(){
        
        
        ///全部查询
//        let sqlStr = "select * from titleArr order by moduleID desc"
//        let titleArr = xlpSqliteManager.queryTable("titleArr", sql: sqlStr, id: nil)
        
//        let sqlStr = "select * from titleArr where moduleID > 20 order by moduleID desc "//->排序需放到最后
        ///尝试二
//        let sqlStr = "select * from titleArr where moduleID > ? and moduleID <= ? order by moduleID desc "
//        let titleArr = xlpSqliteManager.queryTable("titleArr", sql:sqlStr , id: [20,30]) //-> oc里面 20需转为nsnumber 在这里不需要
        
        ///尝试三
        let sqlStr = "select * from titleArr where tiny = ? order by moduleID desc "
        let titleArr = xlpSqliteManager.queryTable("titleArr", sql:sqlStr , id: ["头条","炉石"])//-> ,默认只查询头条 第二个没有查询
        
//        let deleteSucceed = xlpSqliteManager.deleteTable("titleArr", sql: "delete from titleArr where tiny = ?", atWhere: ["炉石"])
        let titleArr1 = xlpSqliteManager.queryTable("titleArr", sql:sqlStr , id: ["头条"])//-> ,默认只查询头条 第二个没有查询

//        let dropTag = xlpSqliteManager.dropTable("titleArr")
        
        let updateSql = "update titleArr set weight = ?,title = ? where tiny = ? "
        let updateSucceed = xlpSqliteManager.updateTable("titleArr", sql: updateSql ,atWhere:[-100,"头痛啊啊啊","头条"] )
        
        print(titleArr,titleArr1,updateSucceed)
    }
    
    
    // MARK: - Core Data stack
    @available(iOS 10.0, *)
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
        if #available(iOS 10.0, *) {
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
        } else {
            // Fallback on earlier versions
        }
    }
    
    /// 获取广告数据 保存到本地
    func downAD() {
        
        let downADOperation = DownADOperation.init()
        let queue = OperationQueue.current
        queue?.addOperation(downADOperation)
        
    }
    
    /// 展示广告
    func displayAD() {
        
        let dataPath = kGetDocumentPath().appendingPathComponent("/AD/adData")
        let adImage = UIImage.init(contentsOfFile: dataPath)
        if adImage != nil {
            
            let adView = ADView.init(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT))
            //        kKeyWindow().isHidden = false
            kKeyWindow().addSubview(adView)
        }
        
    }
    
    
    //object转string  偶尔会出现转换失败 故最终舍弃掉
    func anyToString(_ object: AnyObject?) -> String {
        var s = ""
        if object != nil {
            if object is NSNumber {
                s = "\((object as! NSNumber).int64Value)"
            }else if object is String {
                s = object as! String
            }else if object is NSNull {
                s = ""
            }else{
                s = "\(String(describing: object))"
            }
        }else{
            s = ""
        }
        if s == "<null>" || s == "null" {
            s = ""
        }
        return s
    }
    func anyToString0(_ object: Any?) -> String {
        var s = ""
        if object != nil {
            if object is Float{
                s = "\(String(describing: object))"
                
            }else if object is Double{
                s = "\(String(describing: object))"
            }else if object is Int{
                s = "\(String(describing: object))"
            }else if object is NSNumber {
                s = "\((object as! NSNumber).int64Value)"
            }else if object is String {
                s = object as! String
            }else if object is NSNull {
                s = ""
            }else{
                s = "\(String(describing: object))"
            }
        }else{
            s = ""
        }
        if s == "<null>" || s == "null" {
            s = ""
        }
        return s
    }
    
    
}

extension AppDelegate{
    
    
    
    func climbStairs(mm:Int) -> Int {
        
        if mm == 0 || mm == 1{
            return 1
        }
        return climbStairs(mm:mm-1) + climbStairs(mm:mm-2)
        
    }
    
    
    func obtainStr(str:String) -> String {
     
        var strArr:[Character] = [Character]()
        var lastStr:String = ""
        for (_,mm) in str.enumerated(){
            if strArr.count > 0{
                if strArr.first == mm{
                    strArr.append(mm)
                }else{
                    lastStr.append(strArr.first!)
                    lastStr = lastStr + "\(strArr.count)"
                    strArr.removeAll()
                }
            }else{
                strArr.append(mm)
            }
        }
        return lastStr
    }
    
    
    func testArrcontainEmptyStr() -> Bool {
        let arr = ["asdas","asddfgdfg","2134weqwe"]
        return arr.contains(" ")
    }
    
}
