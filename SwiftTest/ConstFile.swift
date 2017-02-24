//
//  ConstFile.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/21.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import Foundation
import UIKit

let SCREENWIDTH = UIScreen.main.bounds.width
let SCREENHEIGHT = UIScreen.main.bounds.height

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
//#if DEBUG
//#else
//#endif
