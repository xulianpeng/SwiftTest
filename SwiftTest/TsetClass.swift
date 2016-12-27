//
//  TsetClass.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/14.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

//MARK:属性
//MARK:概述分类:包括 <存储属性>  <计算属性> <类型属性> 以及 <全局变量和局部变量>
// 在OC中使用关键字property声明属性 存储数据和传递数据 最终构成运行时runtime 
// 在swift没有了这一关键字,在类中 声明存储属性 和 其他声明变量和常量一样
// 属性的全部信息(包括命名 类型 和 内存管理特征)都在唯一一个地方定义了
// MARK:属性将 值 与 类 结构 或枚举 关联. 在oc中 常用的是类
//MARK:存储属性 存储 常量或变量作为实例的一部分,而计算属性计算一个值.
//MARK:计算属性可以用于类 结构体 枚举 , 存储属性 只有 前两者
//存储属性和计算属性 通常与 特定的类型的实例关联 但是属性也可以直接作用于类型本身,这种属性称为 类型属性
//还可以定义属性观察器来监控属性值的变化,以此来触发一个自定义的操作.
//MARK:属性观察器 可以添加到自己定义的存储属性上 也可以添加到从父类继承的属性上

//存储属性:
//一个存储属性就是存储在特定类 或结构体 实例里的 一个常量var 或 变量let
//可以在定义存储属性的时候 指定 默认值 
//也可以在构造过程中 设置或修改 存储属性的值 甚至修改常量存储属性的值 

class TsetClass: NSObject {
    
    var area : Double?
    var rrr : Double?
    
    
    init(area11:Double, rrr11:Double) {
        
        super.init()
        self.area = area11
        self.rrr = rrr11
    }
    

}
