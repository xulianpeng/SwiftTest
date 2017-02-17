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
func RGB(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat)->UIColor{
    
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}
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
