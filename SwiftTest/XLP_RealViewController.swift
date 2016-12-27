//
//  XLP_RealViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/15.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

//使用扩展 extension

extension Int{
    var squared :Int{
        return self * self
    }
    
}
/// swift 进阶例子
class XLP_RealViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: 进阶一: 函数式编程 初探
        //方法一 和方法二 达到的目的是一样 ,但是 使用的策略是两种,第一种是普通的命令式编程,会产生很多的中间变量,但是第二个是函数式编程,不产生中间变量
        //好好研究一下 函数式编程 的思想 和用法 是swift开发进阶的必备之路
        //加油吧骚年!!!!
        //方法一
        let numbers = [8, 2, 1, 0, 3]
        let indexes = [2, 0, 3, 2, 4, 0, 1, 3, 2, 3, 3]
        var temp = [Int]()
        for i in indexes {
            temp.append(numbers[i])
        }
        var result = ""
        for n in temp {
            result += String(n)
        }
        
        print(result)
    
        //方法二
        print(indexes.map({ "\(numbers[$0])" }).reduce("") { $0 + $1 })
        
        //MARK: 进阶二:扩展的使用
        
        //需求:求一个数的平方
        //方法1:
        func square1(x:Int) -> Int{
            return x * x
        }
        
        //方法2:使用扩展 extension
        print(square1(x: 5),square1(x: square1(x: 5)))
        print(5.squared,5.squared.squared)
        //MARK: 进阶三:泛型的使用
        
        //需求:打印数组中的元素
        var stringArr = ["么么哒","大么么","么大么"]
        var intArr = [1,3,4,6,5]
        var doubleArr = [2.3,4.3,5.8,8.9]
        
        //菜鸟版 分情况 写函数
        func printStingArr(a:[String]){
            for s in a {
                print(s)
            }
        }
        func printIntArray(I:[Int]){
            for i in I {
                print(i)
            }
        }
        func printDoubleArray(D:[Double]){
            for d in D {
                print(d)
            }
        }
        //大神版
        
        func printElementFromArr<T>(a:[T]){
            
            for elment in a {
                print(elment)
            }
        }
        print(printStingArr(a: stringArr),printIntArray(I: intArr),printDoubleArray(D: doubleArr))
        
        printElementFromArr(a: stringArr)
        printElementFromArr(a: intArr)
        printElementFromArr(a: doubleArr)
        //泛型 了解一下:
        
        
        //MARK: 进阶四: for遍历 VS while遍历
        //需求打印5遍陆家嘴
        //方法1
        var i = 0;
        while 5 > i {
            print("陆家嘴")
            i += 1
        }
        
        //方法2for循环
        
        for _ in 0...5 {
            print("陆家嘴")
            
        }
        //小结:中间变量越多,风险越大
        
        //MARK: 进阶五: Guard let vs if let
        //需求:让我们写个欢迎用户
        var userName :String?
        var userPassword :String?
        
        func userLogin() {
            if let newUserName = userName {
                if let _ = userPassword {
                    print("方法一欢迎你\(newUserName)!!!")
                }
            }
        }
        //嵌套函数 不能忍,但其相对于OC还是简练了好多
        //方法二
        func userLogin2(){
            
            guard let newUserName = userName,let _ = userPassword else { return }
            print("方法二欢迎你\(newUserName)!!!")
        }
        
        userName = "xlp"
        userPassword = "123456"
        userLogin()
        userLogin2()
        //小结:如果函数的参数 ,没有被引用,可以使用 _ 代替 进一步简化函数.
        //guard let 使用时,条件可以多个串联,从而不用函数嵌套判断
        
        //MARK:进阶六 :计算属性 VS 函数
        //需求:参数为半径(radius)或直径(diameter),获取圆的直径或半径
        
        //方法一:
        func obtainDiameter(radius:Double)->Double{
            return radius * 2
        }
        func obtainRadius(diamater:Double)->Double{
            return diamater / 2
        }
        //方法二
        var radius: Double = 10
        var diameter: Double {
            get {
                return radius * 2
            }
            set {
                radius = newValue / 2
            }
        }
//        radius = 10 // 10
//        print(diameter)
        
        diameter  = 1000// 20
//        diameter = 1000
        print(radius) // 500
        
        //方法一是建立2个没关系的函数
        //方法二 实际上 半径和直径是有关系的 所以采用方法二回更好
        
        //MARK:进阶七 : 枚举和类型安全
        //需求:卖门票
        
        switch "mm" {
        case "Adult":
            print("请付50元")
        case "child":
            print("请付20元")
        default :print("你是僵尸么?哥们")
        }
        
        
        enum People{
            case adult, child, senior
        }
        switch People.adult {
        case .adult:print("请付50元")
        case .child:print("请付20元")
        default:
            print("你是僵尸么?哥们")
        }
        //“Adult”, “Child”, “Senior” 这里都是硬编码，你每次需要输入手动输入这些字符，记得我们上面讲到的吗？ 手动键入越少，错误越少，生活越美好。
        
        //MARK:进阶八 :空和运算符
        //需求:用户选择主题颜色
        //方法1
        var chosedColor :String?
        var defaultColor = "white"
        var colorToUse = ""
        if let myColor = chosedColor {
            colorToUse = myColor
        }else{
            colorToUse = defaultColor
        }
        print(colorToUse)
        chosedColor = "blue"
        //方法2
        var colorToUse1 = chosedColor ?? defaultColor
       
        print(colorToUse1)
        
        //MARK:进阶九 :函数式编程
        //需求:获取偶数
        // 方法一:菜鸟版
        var newEvens = [Int]()
        for i in 1...10 {
            
            if i % 2 == 0 {
                
                newEvens.append(i)
                
            } 
        }
        print(newEvens) // [2, 4, 6, 8, 10]
        //方法二:
        let evens = Array(1...10).filter { $0 % 2 == 0 }
        
        print(evens)
        
        //MARK: 进阶十 :闭包
        //生活: 求和公式
        //方法1
        func sumWith(var1:Int,var2:Int)->Int{
            return var1 + var2
        }
        //方法2
        let sumWithclosure:(Int,Int)->(Int) = {$0 + $1}
        
        print(sumWith(var1: 5, var2: 6),sumWithclosure(5,6))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
