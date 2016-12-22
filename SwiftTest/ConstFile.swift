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
