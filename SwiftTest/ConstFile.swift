//
//  ConstFile.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/21.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import Foundation
import UIKit
import FMDB

/// 包括相关默认属性 常用设置 宏等 工具类方法 一些系统方法的简写
/// APP相关的密匙之类的相关属性
/// 一般k开头
let kSCREENWIDTH = UIScreen.main.bounds.width
let kSCREENHEIGHT = UIScreen.main.bounds.height


//MARK: UIButton 相关的默认属性

let kBtFontSize:CGFloat = 14
let kBtCornerRadius:CGFloat = 5

//MARK: UILabel 相关的默认属性
let kLabelTextColor = UIColor.lightGray
let kLabelFontSize:CGFloat = 14.0

//MARK: UILabel 相关的默认属性
let kTFPlaceholderColor = UIColor.lightGray


//MARK: 营地token
let kToken = "1B1521EA04DC430A5654FAAC6DA6075E"


func kXlpColor(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat)->UIColor{
    
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}

//func kWeakSelf(_ any:Any) -> Any {
//     weak var weakSelf = any
//    return weakSelf
//}
//MARK:iOS系统的判断
func kIS_iOS8() -> Bool{
    
    let systemVersion = Double(UIDevice.current.systemVersion)!
    if systemVersion < 9.0 {
        return true
    }
    return false
}
func kIS_iOS8orLater() -> Bool{
    
    let systemVersion = Double(UIDevice.current.systemVersion)!
    if systemVersion >= 8.0 {
        return true
    }
    return false
}
func kIS_iOS9() -> Bool{
    
    let systemVersion = Double(UIDevice.current.systemVersion)!
    if systemVersion < 10.0 {
        return true
    }
    return false
}
func kIS_iOS9orLater() -> Bool{
    
    let systemVersion = Double(UIDevice.current.systemVersion)!
    if systemVersion >= 9.0 {
        return true
    }
    return false
}
func kIS_iOS10orLater() -> Bool{
    
    let systemVersion = Double(UIDevice.current.systemVersion)!
    if systemVersion >= 10.0 {
        return true
    }
    return false
}
func kIS_iOS11orLater() -> Bool{
    
    if let systemVersion = Double(UIDevice.current.systemVersion){
        if systemVersion >= 11.0 {
            return true
        }
    }
   
    return false
}

let xlpCoredataManager = XLPCoreDataManager.shareInstance

let xlpCoredataManager1 = XLPCoreDataManager1.shareInstance

let xlpSqliteManager = XLPSqliteManager.shareInstance

/*
+(NSString *)obtainAllDateNowWithTimestamp:(NSNumber *)timestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSString * timeStr = [formatter stringFromDate:confromTimesp];
    return timeStr;
}
 */

//MARK:颜色的缩写
func kRGB(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat)->UIColor{
    
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}
//MARK:时间戳转时间
func kObtainTimeWith(timestamp:Int?) -> String {
    
    //转换为时间
    if timestamp == nil {
        return "暂无时间"
    }else{
        
        let timeInterval:TimeInterval = TimeInterval(timestamp!)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        //格式话输出
        let dateformatter = DateFormatter()
        //dateformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        dateformatter.dateFormat = "MM月dd日"

        return dateformatter.string(from: date as Date)
    }
    
}

func kTimeGetNow() -> Int {
    return Int(Date().timeIntervalSince1970)
}
func kTimeCpmpareWithNow(_ time:Int) -> String {
    let sub:Double = Double(kTimeGetNow() - time)
//    print("时间戳的差值为\(sub)",time,kTimeGetNow())
    var value = "";
    if (sub/60 < 1) {
        //        value= NSLocalizedStringFromTable(@"just", @"IHLibStrings", @"刚刚");//国际化处理
        value =  "刚刚";
    }else if (sub/3600 < 1) {
        let tmp = lrint(sub / 60.0)
        value = "\(tmp)" + "分钟前"
    }else if (sub/3600>1&&sub/86400<1){
        let tmp = lrint(sub / 3600.0)
        value = "\(tmp)" + "小时前"
        
    }
        //    else if (sub/86400>1 && sub/86400<5){
        //        int tmp = floor(sub/86400);
        //        value = [NSString stringWithFormat:@"%d%@",tmp, @"天前"];
        //    }
    else{
        value = kObtainTimeWith(timestamp: time)
    }
    
    return value
}

//MARK:随机颜色
func kRandomColor() -> UIColor {
    
    let red = CGFloat(arc4random()%256)/255.0
    let green = CGFloat(arc4random()%256)/255.0
    let blue = CGFloat(arc4random()%256)/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

/// 16进制颜色生成
///
/// - Parameter rgbValue: 16进制颜色值
/// - Returns: uicolor
func kColorWith16(_ rgbValue:Int) ->UIColor{
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
    let blue = CGFloat(rgbValue & 0xFF)/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

func kColorWith16HexString(_ hexString:String) ->UIColor {
    
    let newStr:NSString = hexString as NSString
    let removeSharpMarkhexString = newStr.replacingOccurrences(of: "#", with: "")
    let scanner: Scanner = Scanner(string: removeSharpMarkhexString)
    var result: UInt32 = 0
    scanner.scanHexInt32(&result)
    return kColorWith16(Int(result))
}

//func XLPRandomText() -> String {
//    
//    let  length =  (arc4random() % 50 + 5) as? Int;
//    
//      var str : String = "";
//    for i  in length {
//        
//        i += 1
//        str.append("测试数据很长，")
//        
//    }
//    
//    return str as String;
//}
/*
    - (NSString *)randomText {
        CGFloat length = arc4random() % 50 + 5;
        
        NSMutableString *str = [[NSMutableString alloc] init];
        for (NSUInteger i = 0; i < length; ++i) {
            [str appendString:@"测试数据很长，"];
        }
        
        return str;
}*/

func showHud(text:String,yHeight:CGFloat) -> Void {
    
//    xlpHud.init(frame: <#T##CGRect#>, text: <#T##String#>)
}



/// 通知 暂未发现好的解决办法
typealias NSNotificationBlock = (_ sender:Notification) -> Void

func kNotificationAddObserver(_ observer:String,notificationName:String,object:Any?,selector:NSNotificationBlock){
    
//    NotificationCenter.default.addObserver(observer, selector: #selector(notificationHandle), name: NSNotification.Name(rawValue: notificationName), object: object)
    
//    NotificationCenter.default.addObserver(<#T##observer: Any##Any#>, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
//    NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationName), object: object, queue: OperationQueue.main, using: NSNotificationBlock)
    
//    NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"mmm"), object: nil, queue: nil) { (notification) in
//        self.navigationController?.navigationBar.barTintColor = UIColor.purple
//    }
}
//func notificationHandle(<#parameters#>) -> <#return type#> {
//    <#function body#>
//}


/// UserDefaults的简单封装
///
/// - Parameters:
///   - value: <#value description#>
///   - key: <#key description#>
func kUserDefaults(_ value:Any?,key:String) {
    
    UserDefaults.standard.setValue(value, forKey:key)
    UserDefaults.standard.synchronize()
}
func kUserDefaultsValue(_ key:String) -> Any?{
    
    return UserDefaults.standard.value(forKey: key)
    
}
func kUserDefaultsValueInt(_ key:String) -> Int{
    
    return UserDefaults.standard.integer(forKey: key)
    
}
func kUserDefaultsValueFloat(_ key:String) -> Float{
    
    return UserDefaults.standard.float(forKey: key)
    
}
func kUserDefaultsValueString(_ key:String) -> String?{
    
    return UserDefaults.standard.string(forKey: key)
    
}
func kUserDefaultsValueArr(_ key:String) -> [String]?{
    
    return UserDefaults.standard.stringArray(forKey: key)
}

//MARK:获取主Window
func kKeyWindow() -> UIWindow {
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    return appDelegate.window!
    return UIApplication.shared.keyWindow!
}
//MARK:font方法简写
func kFontWithSize(_ size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}
//MARK:沙盒相关的方法

/// 获取沙盒Library的路径
///
/// - Returns: 路径
func kGetLibraryPath() ->NSString{
    
    let pathArr = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    let libPath = pathArr[0]
    return libPath as NSString
    
}
/// 获取沙盒Document的路径
///
/// - Returns: 获取沙盒Document的路径
func kGetDocumentPath() -> NSString{
    
    let pathArr = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    let docPath:NSString = pathArr[0] as NSString
    return docPath
}

/// 在doc下创建文件夹,并返回该文件夹的路径
///
/// - Parameter name: 创建的文件夹,可以是 "card"或者拼接的"magic/card"
/// - Returns: 文件夹的路径
func kCreateDocDirectoryWith(_ name:String) -> String{
    
    let docPath:NSString = kGetDocumentPath()
    let fileManager = FileManager.default
    let finalPath = docPath.appendingPathComponent(name)
    
    if !fileManager.fileExists(atPath: finalPath) {
        
        try! fileManager.createDirectory(atPath: finalPath, withIntermediateDirectories: true, attributes: nil)
    }
    print("===创建的文件夹的路径==\(finalPath)")
    return finalPath
}

/// 创建文件 在指定的路径下
///
/// - Parameters:
///   - name: 文件的名字
///   - inPath: 指定的路径
/// - Returns: 返回 创建文件的路径,成功与否
func kCreatFile(_ name:String, inPath:String) -> (String,Bool){

    
    let fileManager = FileManager.default
    var finalPath:String?
    var isSuccesed:Bool = false
    finalPath = (inPath as NSString).strings(byAppendingPaths: [name]).last
    if !fileManager.fileExists(atPath: finalPath!) {
        isSuccesed = fileManager.createFile(atPath: finalPath!, contents: nil, attributes: nil)
        
    }
    print("====文件的路径为\(finalPath!)")
    return (finalPath!,isSuccesed)
}
func kCreatFileLast(_ name:String, inPath:String) -> String{
    
    
    let fileManager = FileManager.default
    var finalPath:String?
    finalPath = (inPath as NSString).strings(byAppendingPaths: [name]).last
    if !fileManager.fileExists(atPath: finalPath!) {
        fileManager.createFile(atPath: finalPath!, contents: nil, attributes: nil)
        
    }
    print("====文件的路径为\(finalPath!)")
    return finalPath!
}
/// 创建文件在doc里面
///
/// - Parameter name: 文件名 比如 ios.text, mmm,...
/// - Returns: 是否创建成功
func kCreatFile(_ name:String) -> (String,Bool){
    let docPath:NSString = kGetDocumentPath()
    let fileManager = FileManager.default
    let finalPath = docPath.strings(byAppendingPaths: [name]).last
    var isSuccesed:Bool = false
    if !fileManager.fileExists(atPath: finalPath!) {
        isSuccesed = fileManager.createFile(atPath: finalPath!, contents: nil, attributes: nil)

    }
    print("====文件的路径为\(finalPath!)")
    return (finalPath!,isSuccesed)
}


/// 把String写入文件
///
/// - Parameters:
///   - content: 写入的内容
///   - path: 文件所在路径 即kCreatFile的返回结果的第一个
func kWriteStringToFile(_ content:String,at path:String)  {
    
    let mm = content
    try! mm.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
    
}

/// 计算文件的大小 单位为MB  暂时结果取小数点后5位
///
/// - Parameter path: 文件所在路径
/// - Returns: 文件大小
func kGetFileSizeMBAtPath(_ path:String) -> Double{
    
    let fileManager = FileManager.default
    let isExist = fileManager.fileExists(atPath: path)
    if isExist {
        
        let attr = try! fileManager.attributesOfItem(atPath: path)
//        let fileSize = attr[FileAttributeKey.size] as! Double //这个方法也可以
        let dict = attr as NSDictionary
        //单位为bit 最终转为 MB
        let fileSize = dict.fileSize()
        let lastSize = Double(fileSize) / Double(8 * 1024 * 1024)
        let lastStr = String.init(format: "%.5f", lastSize)
        print("文件的大小为\( (lastStr as NSString).doubleValue)MB")
       return (lastStr as NSString).doubleValue
    }
    return 0.0
}
func kGetFolderSizeMBAtPath(_ path:String) -> Double{
    let fileManager = FileManager.default
    let isExist = fileManager.fileExists(atPath: path)
    if (isExist){
        
        print(try! fileManager.subpathsOfDirectory(atPath: path),try! fileManager.subpathsOfDirectory(atPath: path).enumerated())
//        var childFileEnumerator :NSEnumerator = fileManager.subpathsOfDirectory(atPath: path).enumerated()
//        
//            [[fileManager subpathsAtPath:folderPath] objectEnumerator];
//        unsigned long long folderSize = 0;
//        NSString *fileName = @"";
//        while ((fileName = [childFileEnumerator nextObject]) != nil){
//            NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
//            folderSize += [self fileSizeAtPath:fileAbsolutePath];
//        }
//        return folderSize / (1024.0 * 1024.0);
//    } else {
//        NSLog(@"file is not exist");
//        return 0;
    }
    
    return 0.003
}
typealias alertBlock = (UIAlertAction)-> Void

//MARK: alertController 简单封装
/// alertController 简单封装
///
/// - Parameters:
///   - superView: 父试图
///   - title: title
///   - message: 提示信息
///   - first: 取消按钮的文案
///   - second: 确定按钮的文案
///   - firstBlock: 点击取消的block
///   - secondBlock: 点击确定的block
func kInitAlert(_ superView:UIViewController, title:String,message:String,first:String,second:String,firstBlock: @escaping alertBlock,secondBlock:@escaping alertBlock){
    
    let alertView = UIAlertController.init(title: title, message:message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction.init(title: first, style: .cancel, handler: firstBlock))
    alertView.addAction(UIAlertAction.init(title: second, style: .destructive, handler:secondBlock))
    superView.present(alertView, animated: true, completion: nil)
}

/// 有提示的laert
///
/// - Parameters:
///   - superView: <#superView description#>
///   - title: <#title description#>
///   - message: <#message description#>
///   - second: <#second description#>
///   - secondBlock: <#secondBlock description#>
func kInitAlertEassy(_ superView:UIViewController, title:String,message:String,second:String,secondBlock:@escaping alertBlock){
    
    let alertView = UIAlertController.init(title: title, message:message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler:nil ))
    alertView.addAction(UIAlertAction.init(title: second, style: .destructive, handler:secondBlock))
    superView.present(alertView, animated: true, completion: nil)
}

/// 无提示alert
///
/// - Parameters:
///   - superView: <#superView description#>
///   - message: <#message description#>
///   - second: <#second description#>
///   - secondBlock: <#secondBlock description#>
func kInitAlertFinal(_ superView:UIViewController,message:String,second:String,secondBlock:@escaping alertBlock){
    
    let alertView = UIAlertController.init(title: nil, message:message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler:nil))
    alertView.addAction(UIAlertAction.init(title: second, style: .destructive, handler:secondBlock))
    superView.present(alertView, animated: true, completion: nil)
}

//MARK: actionSheet的简单封装 ,默认有取消按钮 ,一共3个选项
/// actionSheet
///
/// - Parameters:
///   - superView: <#superView description#>
///   - message: <#message description#>
///   - first: <#first description#>
///   - second: <#second description#>
///   - firstBlock: <#firstBlock description#>
///   - secondBlock: <#secondBlock description#>
func kInitActionSheetFinal(_ superView:UIViewController,message:String,first:String,second:String,firstBlock:@escaping alertBlock,secondBlock:@escaping alertBlock){
    
    let alertView = UIAlertController.init(title: nil, message:message, preferredStyle: .actionSheet)
    alertView.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
    alertView.addAction(UIAlertAction.init(title: first, style: .default, handler: firstBlock))
    alertView.addAction(UIAlertAction.init(title: second, style: .default, handler:secondBlock))
    superView.present(alertView, animated: true, completion: nil)
}

func kImageWithName(_ name:String)-> UIImage?{
    return UIImage.init(named:name)
}

//MARK: String相关的方法
/// 计算字符串的尺寸
///为很么要+3 实际算出来的宽度 会少这么多 否则会以省略号出现
func kStringGetSize(_ string:String?,font:UIFont,maxSize:CGSize) -> CGSize {
    
    var lastSize = CGSize.zero
    
    if string != nil {
        lastSize = string!.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin,.truncatesLastVisibleLine,.usesDeviceMetrics],attributes:[NSAttributedString.Key.font:font],context: nil).size
        
    }
    lastSize  = CGSize(width:lastSize.width + 3,height:lastSize.height)
    return lastSize
}
//MARK: 对字符串进行空值判断
/// 对字符串进行空值判断
///
/// - Parameter string: 输入的字符
func kStringIsEmpty(_ string:String?) -> Bool{
    var bool = false
    var str:String?
    if string != nil  {
        str = string?.trimmingCharacters(in: CharacterSet.whitespaces)
         bool = str!.isEmpty
    }
    return bool
}
//MARK:去除字符串头尾的空格
func kStringRemoveWhitespaces(_ string:String?) -> String{
    var str = ""
    if string != nil  {
        str = string!.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    return str
}
//MARK:去除字符串头尾的空格和换行
func kStringRemoveWhitespacesAndNewlines(_ string:String?) -> String{
    var str = ""
    if string != nil  {
        str = string!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    return str
}
//MARK:去除字符串头尾的空格和换行
func kStringRemoveAllWhitespacesAndNewlines(_ string:String?) -> String{
    var str = ""
    if string != nil  {
        str = string!.replacingOccurrences(of: " ", with: "")
        str = str.replacingOccurrences(of: "\n", with: "")
    }
    return str
}
//MARK:去除字符串中所有的空格
func kStringRemoveAllWhitespaces(_ string:String?) -> String{
    var str = ""
    if string != nil  {
        str = string!.replacingOccurrences(of: " ", with: "")
    }
    return str
}
//MARK: 对字符串是否可以转为URL做简单判断
/// 对字符串是否可以转为URL做简单判断
///
/// - Parameter string: 网址url
/// - Returns: bool
func kStringIsUrl(_ string:String?) ->Bool{
    var bool = false
    if !kStringIsEmpty(string) {
        let str = string?.trimmingCharacters(in: CharacterSet.whitespaces)
        if (str?.contains("://"))! {
            bool = true
        }
    }
    return bool
}
//MARK: 判断字符串是否是数字
/// 判断字符串是否是数字
///
/// - Parameter string: <#string description#>
/// - Returns: <#return value description#>
func kStringIsNumber(_ string:String) -> Bool {
    if let _ = NumberFormatter().number(from: string) {
        return true
    }
    
    return false
}
//MARK: 正则判断 手机号码 邮箱 网址合法 用户名
enum checkZhengZe {
    case phone
    case email
    case url
    case userName
    case IP
    case htmlFlag
}

func kStringZZJudge(_ str:String,type:checkZhengZe) ->Bool {
    if !str.isEmpty {
        
       
        var limitStr = ""
        switch type {
        case .phone:
            limitStr = "^1[34578][0-9]{9}$"
        case .email:
            limitStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        case .url:
            limitStr = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?"
        case .userName:
            limitStr = "^[a-z0-9_-]{3,16}$"
        default: break
        }
        let regextestpn:NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", argumentArray: [limitStr])
        return regextestpn.evaluate(with: str)
    }
    return false
}
//MARK: 正则判断是否是电话号码  两者结合一下
func kIsTelNumber(_ num:String)->Bool{
    
    if !kStringZZJudge(num, type: .phone) {
        
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$"
        let  CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
        let  CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        let  CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }else{
        return true
    }
}

//MARK: 判断是否包含表情 xcode里面直接输入表情是识别不了的
/// 判断是否包含表情 xcode里面直接输入表情是识别不了的
///
/// - Parameter string: <#string description#>
/// - Returns: <#return value description#>
func kStringContainEmotion(_ string:String) -> Bool {
    let strLength = (string as NSString).length
    
    for i in 0...strLength {
        let c:unichar = (string as NSString).character(at: i)
        if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
            return true
        }
    }
    return false
}

/// 初始化tableview
///
/// - Parameters:
///   - height: 距离底部的距离
///   - style: <#style description#>
/// - Returns: <#return value description#>
func kXlpInitTableViewBegin(_ height:CGFloat,style:UITableView.Style) -> UITableView{
    return UITableView.init(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT - 64 - height), style: style) as UITableView
    
}


/// FMDB的坑点
///   integer 在查询时 其结果类型为 Int32, 须先转为Int,才能做其他类型的转换,否则最终结果会为nil
/// - Parameters:
///   - resultSet: 目标
///   - column: 字段
/// - Returns: 字段对应的value值
func IntFor(_ resultSet:FMResultSet,column:String ) -> Int {
    return Int(resultSet.int(forColumn: column))
}

func kXlpCheckArr(_ arr:Array<Any>?) -> Bool {
    
    if arr != nil && arr!.count > 0 {
        return true
    }else{
        print("=======数组为空")
        return false
    }
}
//#if DEBUG
//#else
//#endif


/*
+ (UIColor *)colorWithHexWithLong:(long)hexColor
{
    return [self colorWithHexWithLong:hexColor alpha:1.0];
    }
    
 */


//        + (UIColor *)getDarkerColorFromColor1:(UIColor *)color1 color2:(UIColor *)color2 {
//            if ([color1 colorNumber] > [color2 colorNumber]) {
//                return color2;
//            } else {
//                return color1;
//            }
//            }
//
//            - (float)colorNumber {
//                double r,g,b,a;
//                [self getRed:&r green:&g blue:&b alpha:&a];
//                return r + g + b + a;
//}

