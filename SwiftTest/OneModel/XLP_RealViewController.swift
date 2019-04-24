//
//  XLP_RealViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/15.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

//MARK:扩展的功能:
/*
 扩展的功能:
 1.为已有类型添加计算型实例属性和计算型类型属性,切记存储属性不可以
 2.为已有类添加 新的便利构造器
 3.为已有类添加新的实例方法和类型方法
 4.为已有类型添加新下标
 5.为已有类 结构体 枚举 添加新的嵌套类型
 
 下面我们逐条验证
 
 */
//Extension
//MARK:1.为已有类型添加新的计算型属性,包括计算型实例属性和计算型类型属性,后者我有点小疑惑,是加个static修饰符

//假设此时其单位是 毫米
extension Double{
    
    var cm :Double {
        return self / 10
    }
    var m :Double{
        return self / 100.0
    }
    static var myCount = 1000.0
    
}
//MARK:2.为已有类型添加新的便利构造器,但不能添加新的指定构造器和析构器
//MARK:那么问题来了, 指定构造器 和 析构器 是什么呢?
struct Point{
    var x = 0.0
    var y = 0.0
}
struct Size {
    var width = 0.0
    var height = 0.0
}
struct MyRect {
    var orgin :Point
    var size  :Size
}

extension MyRect{
    
    init(center:Point,size:Size) {
        let orginX = center.x - size.width/2
        let orginY = center.y - size.height/2
        self.init(orgin:Point(x: orginX,y: orginY),size:size)
    }
    //第一次自己尝试的时候,生成的变量是centerX centerY,
    /*
     let centerX = orgin.x + size.width/2
     let centerY = orgin.y + size.height/2
     self.init(orgin:Point(x: centerX,y: centerY),size:size)
     */
    //回头来看,确实写的很傻比,根本就没思考
    //类比OC,生成新的便利构造器时肯定要调用原始的初始化方法
    
    //MARK:2.1析构器:参考笔记[030]swift析构过程,类比dealloc,内存管理时,有一部分对象需要手动管理其内存.
    //析构器只适用于<类>，当一个类的实例 被释放之前，析构器会被立即调用。析构器用deinit关键字来标示。
    //swift会自动释放不需要的实例以释放资源。在swift中通过自动引用计数(ARC)处理实例的内存管理。一般情况释放时不需要手动清理，但是当使用自己的资源时，可能就需要进行额外的清理。例如，创建了一个自定义的类类打开一个文件，并写入一些数据，当类释放前可能需要手动去关闭该文件。
    //析构器是在实例释放发生前被自动调用，另外析构器是不允许被主动调用的。当子类继承了父类的析构器，子类有析构器，父类的析构器也会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
}
//MARK:3.为已有类型扩展 新的 <实例方法> 和 <类型方法>
extension Int{
    
    func repeatInt(task:() -> Void) {
        for _ in 0..<self { //0...m ,表示 m+1次,是闭区间; 0..<m,是开区间,不包括最右端
            task()
        }
    }
    //输出 数的平方 有返回值
    func squaredFunc1() -> Int {
//        let mmm :Int = self * self
//        return mmm
        return self * self
    }
    
    mutating func squaredFunc2() -> Void {
        self = self * self
    }
    
    mutating func squaredFunc3() -> Int {
        self = self * 3
        return self
    }
    //输出 数的n次方 cannot convert return expression of type () to return type int
     func squaredFunc(num:Int) -> Int {
       
        /* while实现for 循环
        var temVar : Int = self
        var i = 0
        while  i <= num  {
            if num == 0{
                
                return  self * 0
            }
            if num == 1 {
                
                return temVar
            }
            if i > 1 {
                temVar = temVar * self
            }
            i = i + 1
        }
        return temVar
        */
        //for循环 怎么实现 一种是快速遍历  一种就是for循环
        
        var temVar : Int = self
        for i  in 0 ... num {
            if i == 0{
                
                temVar = self * 0
            }
            if i == 1 {
                
                temVar = self
            }
            if i > 1 {
                temVar = temVar * self
            }

        }
        return temVar
    }
    //小结:mutating 关键字 当所扩展的内容为已有类添加 实例方法 或 类型方法,函数中出现了 修改了自身,即出现 self = self *mm或者任何赋值给 self的语句,都需要使用  mutating 修饰该函数;
    //在调用该扩展时,也需要做特殊处理,参见 //MARK: 扩展3 小结 调用时的特殊处理
}
/*
//MARK: 扩展4 为已有类型添加下标
extension Int {
    subscript(digitIndex: Int) -> Int { // 返回从右往左第N位的数字
        var decimalBase = 1
        for _ in 0..< digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
 */
//MARK: 扩展5 为已有类型(类 结构体 枚举)添加新的嵌套类型
extension Int {
    enum Kind {                         // Kind三种类型,负数,零,正数
        case Negative, Zero, Positive
    }
    var kind: Kind {                    // 根据实际值,返回Kind类型
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

//使用扩展 extension
extension Int{
    var squared :Int{
        return self * self
    }
    
}



struct Matrix {
    var rows: Int, columns: Int
    subscript(row: Int, column: Int) -> Int {
        // 二维下标 
        get {
            return rows + columns
        }
        set (mm){
            // 默认参数newValue
            rows += mm    // 2+= 8  -> rows = 10
            columns += mm // 3+= 8  -> colums = 11
            rows += row         //  10 + = 6 == 16
            columns += column   //   11 += 5 == 16
        }
    }
}


/// swift 进阶例子
class XLP_RealViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        var matrix = Matrix(rows: 2, columns: 3) //这个是 初始化  这个 结构体
        matrix[6, 5] = 8 //这个是下标语法  newvalue = 8
        // 调用下标的set和get方法
        print(matrix.columns)
        // 13
        print(matrix.rows)
        
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
        
        //MARK:扩展的学习
        var yourCount :Double = 10000
        
        
//        print(yourCount.cm,yourCount.m,yourCount.myCount)
        //为什么为其定义的类型属性 不能 .出来呢?
        print(yourCount.cm,yourCount.m)

        //MARK: 为已有类型扩展新的便利构造器,但不能指定构造器或 析构器
        
        let testRect = MyRect.init(center: Point(x:4.0,y:6.0), size: Size(width:4.0,height:4.0))
        
        print("扩展之于 新的便利构造器==\(testRect.orgin.x,testRect.orgin.y)")
        
        //3
        3.repeatInt { 
            print("打印输出3次")
        }
        
        //MARK: 扩展3 小结 调用时的特殊处理
         /*
//        var mm = 2 as? Int//如果类/结构体 扩展新添加的实例方法 或类型方法 有 mutating修饰时,该类/结构体 需做个可选判断 ,否则会报错
        //print(mm.squared,mm.squaredFunc(),mm.squaredFunc(num: 3))
        */
        var mm = 6 
        print(3.squared,4.squaredFunc1(),mm.squaredFunc2(),mm.squaredFunc3(),5.squaredFunc(num: 3))
        //结果分析:输出为 9 16 () 108 125 
        // mm.squaredFunc2()没有返回值,但是因为其用了mutating修饰,所以self此时已被该函数修改为36
        //当mm.squaredFunc2()函数启动时,self = self * 3 ,self = 108.
        //函数四则不受影响.说明 若函数M被mutating修饰,无返回值时,其本身self会被修改,在紧接着的函数中self会取该值使用.若M有返回值,则不受该原则影响.
        //MARK: 扩展5 的例子
        
        func printIntegerKinds(numbers: [Int]) { // 接收一个数组,打印每个元素的Kind类型
            for number in numbers {
                switch number.kind {
                case .Negative:
                    print("-", terminator: " ") // terminator: " " 表示不换行,并添加一个空格
                case .Zero:
                    print("0", terminator: " ")
                case .Positive:
                    print("+", terminator: " ")
                }
            }
            print("")                          // 换行
        }
        
        printIntegerKinds(numbers: [12, -4, 0, 32, -74, 2, 0, 12])

        /*
        print(<#T##items: Any...##Any#>)
        print(<#T##items: Any...##Any#>, to: &<#T##Target#>)
        print(<#T##items: Any...##Any#>, separator: <#T##String#>, terminator: <#T##String#>, to: &<#T##Target#>)
        */
        
        let mm1 = "123"
        let nn1 = 456
        let zz1 = [1256,3478,2345]
        let dic1 = ["aa":123,"bb":456,"cc":6789]
        
        
        let bb = 1...5
        print(mm1,nn1,zz1,dic1,bb)
        print(mm1,nn1,zz1,dic1,bb, separator: "==", terminator: "打印输出的终止符 一般是 \n (换行符)")
        //MARK: 关于print的一些知识点
        //separator:分隔符,terminator:终止符
        //to: &Target 暂时还未找到用法
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
