//
//  ConstFile.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/21.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import Foundation
import UIKit

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
let kToken = "E1BB0782CF8E65F29356A8DE7D86A28B"


//func kWeakSelf(_ any:Any) -> Any {
//     weak var weakSelf = any
//    return weakSelf
//}
//MARK:iOS系统的判断
func IS_iOS8() -> Bool{
    
    let systemVersion = Double(UIDevice.current.systemVersion)!
    if systemVersion < 9.0 {
        return true
    }
    return false
}
func IS_iOS8orLater() -> Bool{
    
    let systemVersion = Double(UIDevice.current.systemVersion)!
    if systemVersion >= 8.0 {
        return true
    }
    return false
}
func IS_iOS9() -> Bool{
    
    let systemVersion = Double(UIDevice.current.systemVersion)!
    if systemVersion < 10.0 {
        return true
    }
    return false
}
func IS_iOS9orLater() -> Bool{
    
    let systemVersion = Double(UIDevice.current.systemVersion)!
    if systemVersion >= 9.0 {
        return true
    }
    return false
}
func IS_iOS10orLater() -> Bool{
    
    let systemVersion = Double(UIDevice.current.systemVersion)!
    if systemVersion >= 10.0 {
        return true
    }
    return false
}


let xlpCoredataManager = XLPCoreDataManager.shareInstance

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
func RGB(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat)->UIColor{
    
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}
//MARK:时间戳转时间
func obtainTimeWith(timestamp:Int) -> String {
    
    /*
    var formatter : DateFormatter = DateFormatter()
    formatter.dateStyle = DateFormatter.Style.medium
    formatter.timeStyle = DateFormatter.Style.short
    formatter.dateStyle = "yyyy/MM/dd HH:mm"
    let timezone:NSTimeZone = NSTimeZone()
    timezone.name = "Asia/Shanghai"
    formatter.timeZone = timezone as TimeZone!
    
    let date:Date = Date.init(timeIntervalSinceNow: (timestamp as? Double)!)
    date.timeIntervalSince1970
    
    timeStr = formatter.string(from: date)
    */
    
    //转换为时间
    let timeInterval:TimeInterval = TimeInterval(timestamp)
    let date = NSDate(timeIntervalSince1970: timeInterval)
    
    //格式话输出
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
    
    
    return dateformatter.string(from: date as Date)
    
}
//MARK:随机颜色
func XLPRandomColor() -> UIColor {
    
    let red = CGFloat(arc4random()%256)/255.0
    let green = CGFloat(arc4random()%256)/255.0
    let blue = CGFloat(arc4random()%256)/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
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
//MARK: 正则判断是否是电话号码
func isTelNumber(_ num:String)->Bool{
    
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
func kUserDefaultsValue(_ key:String) -> Any{
    
    return UserDefaults.standard.value(forKey: key)!
    
}

//let WMkeyWindow: UIWindow {
//    
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    
//    return appDelegate.window!
//}
//MARK:获取主Window
func wmKeyWindow() -> UIWindow {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    return appDelegate.window!
}
//MARK:font方法简写
func kXLPFontSize(_ size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}
//MARK:沙盒相关的方法
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

/// 获取创建指定文件夹的路径
///
/// - Parameter name: 创建的文件夹
/// - Returns: 创建指定文件夹的路径
func kCreateDocDirectoryWith(_ name:String) -> String{
    
    let docPath:NSString = kGetDocumentPath()
    let fileManager = FileManager.default
    let finalPath = docPath.appendingPathComponent(name)
    try! fileManager.createDirectory(atPath: finalPath, withIntermediateDirectories: true, attributes: nil)
    print("===创建的文件夹的路径==\(finalPath)")
    return finalPath
}

/// 创建文件
///
/// - Parameter name: 文件名 比如 ios.text
/// - Returns: 是否创建成功
func kCreatFile(_ name:String) -> (String,Bool){
    let docPath:NSString = kGetDocumentPath()
    let fileManager = FileManager.default
    let finalPath = docPath.appendingPathComponent(name)
    let isSuccesed:Bool = fileManager.createFile(atPath: finalPath, contents: nil, attributes: nil)
    return (finalPath,isSuccesed)
}

/// 写入文件内容 接上面这个方法
///
/// - Parameters:
///   - content: 写入的内容
///   - path: 文件所在路径 即kCreatFile的返回结果的第一个
func kWriteToFile(_ content:String,at path:String)  {
    
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

//#if DEBUG
//#else
//#endif
