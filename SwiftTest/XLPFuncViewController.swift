//
//  XLPFuncViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/16.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

//MARK:一 函数语法
//主要介绍 swift 函数相关语法,主要内容包括 1:函数的定义和使用 2:函数参数与返回值 3:函数参数标签和参数名称 4:函数类型 5:嵌套函数


/**
 *  name      Swift函数
 *  define    函数是一段完成特定任务的独立代码片段.可通过给函数命名来标识某个函数的功能.
 *  @element  swift 统一的函数语法非常的灵活,包括从最简单的没有参数的C风格函数,到复杂的带局部和外部参数名的OC风格函数.
 *  @element  参数可以提供默认值,以简化函数调用.
 *  @element  参数可以既当做传入参数,也可以当做传出参数
 *  @element  在swift中,每个函数都有一个由函数的 参数值类型和返回值类型组成的  类型 .你可以把函数类型当做任何其他普通变量类型一样处理,这样就可以更简单地把函数 当做别的函数的参数,也可以从其他函数中返回函数.
 *  @element 函数的定义可以写在其他函数定义中,这样可以在嵌套函数范围内实现功能封装
 **/

/**
 *  name      函数的定义和调用
 *  define    参数可以是一个或多个 称为实参,当然可以有多个返回值 一般以元组的方式.
 *  @element  调用函数时,若有参数需传入匹配的参数值,且参数的顺序与参数列表的顺序一样.
 **/

protocol IWillPlayMusic {
    
    //代理方法
    func beginPalyMusic()
}

protocol CallMyNameProtocol {
    var fullName:String {get set}
}

protocol NewFuncProtocol {
    static func showMessage()
}

class XLPFuncViewController: UIViewController,IWillPlayMusic,UIGestureRecognizerDelegate {

    
    var panGesture = UIPanGestureRecognizer()
    var longPressGesture = UILongPressGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        print(sayHello(paraStr: "xlp"))
        print(sayHello())
        print(greet("John", "Wednesday"))
    
        calculate(c: add);// 执行函数 //从这个函数看出来 其参数为 函数类型 即add

        Iloveyou(mm: calculate1)
        
        //暂时还不知道怎么修改 暂时搁置 参考后面的 协议 章节
       // IWantYouDoSomething(something: IWillPlayMusic)
        
        
        let addFunc = generateFuncByFlag(flag: true)
        
        print(addFunc(1,10))
        
        let decreamFunc = generateFuncByFlag(flag: !true)
        print(decreamFunc(8,3))
        
        
        // inout关键字的用法 具体参看函数swapTwoInts
        //本函数的需求是  把 函数外部的变量  a b 的值交换一下
        var a = 30
        var b = 40
        swapTwoInts(a: &a, b: &b)
        print(a)
        print(b)
        //期望的输出应该是 40 30
        
        //若一个函数有返回值 ,则在调用该函数时 若未把该函数赋值给一个变量,则会有警告,大意是 未被使用...,那么怎么去除该警告呢 ,很简单 ,在该函数生成时 先使用关键字 @discardableResult修饰 则可达到目的
        //参看函数 sayHello(paraStr:String) -> String
        
        //***********
        
       getUserName()
        
       getFunctionName()
        
        //MARK: 二 闭包
        
        //闭包之余 swift,与block之余 OC 是一样的 ,所以我们可以类比着学习
        //MARK:2.1 闭包(closure) 的 声明方式:
        // 声明一个闭包(有两个整形参数，且返回值为整形的闭包)
        var sumClosure:((_ mm: Int, _ nn: Int) -> Int)
        
        // 实现闭包
        sumClosure = {  (mm: Int, nn: Int) -> Int in
            return mm + nn
        }
        
        // 调用
        let sum = sumClosure(10,20)
        print(sum)
        
        //由API得知:
        //1.闭包 是自包含的 函数代码块,与C 和 OC中的 block代码块和其他一些编程语言中的匿名函数比较类似.
        //2.闭包可以捕获和存储其所在上下文中任意常量和变量的引用.被称为 包裹常量和变量.且 swift会为你管理捕获过程中涉及到的所有内存操作.
        //MARK: 3.在函数章节中介绍的全局和嵌套函数 实际上也是特殊的闭包,他们的区别如下:
        //他们的区别如下:
        /*
         1 全局函数是一个有名字但不会捕获任何值的闭包.
         2.嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包.
         3.闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包.
        */
        //4.闭包表达式风格简洁,鼓励在常见场景中进行语法优化,主要优化如下:
        /*
         @1利用上下文推断参数和返回值类型,
         @2隐式返回单表达式闭包,即单表达式闭包可以省略 return 关键字,
         @3参数名称缩写,
         @4尾随闭包语法
       */
        
        //举例：数组的排序方法 ,最终实现 使用 sorted(by:)方法对一个String类型数组 进行按字母逆序排序。
        
        let names = ["Chris","Alex","Ewa","Barry","Daniella"]
        
        //sorted(by:) 方法接受一个 闭包,该闭包函数需要传入与数组元素类型相同的两个值,并返回一个布尔类型的值来表明当排序结束后传入的第一个参数排在第二个参数的前面还是后面,前面的 话 返回 true 否则返回false.
        //闭包表达式为  (string ,string)->Bool
        
        func backward(s1:String,s2:String)->Bool{
            return s1 > s2
        }
        
        let reversedNames = names.sorted(by:backward)
        print(reversedNames)
        
        //闭包表达式语法
        /*
         
         {(parameters) -> returnType in
           
           statements
         }
         */
        
        //则上面排序的对应的闭包表达式为
        
        let reversedNames1 = names.sorted(by: {(s1:String,s2:String) -> Bool in
        
            return s2 > s1
        })
        
        print(reversedNames1)
        
        //由上可得:闭包表达式 由 {}包括, 参数列表 返回值类型 ,关键字 in 后面是 闭包函数体 return  s2 > s1
        //根据上下文推断 闭包表达式 的参数 和返回值的 类型 ,可以将其省略掉 ,不过若是利于阅读代码 ,最好不省略
        /*
         let reversedNames1 = names.sorted(by: { s1,s2 in  return s2 > s1 })
         
         */
        
        //单表达式闭包隐式返回 ,即 return可以省略
        
         let reversedNames4 = names.sorted(by: { s1,s2 in  s2 > s1 })
        
        //参数名称也可以缩写
        let reversedNames2 = names.sorted(by: {$0 > $1})
        
        //运算符方法
        let reversedNames3 = names.sorted(by: >)
        
        //尾随闭包
        
        let reversedNames5 = names.sorted(){$0 > $1}
        
        //若函数 只有 闭包一个参数 时  则 函数末尾 ()  也可省略
        let reversedNames6 = names.sorted { $0 > $1}
        
        print(reversedNames4,reversedNames2,"====",reversedNames3,"==5",reversedNames5,"==6",reversedNames6)
        
        //值捕获
        
        //闭包可以在其呗定义的上下文中捕获常量和变量.即使定义这些常量和变量的原作用域已经不存在,闭包仍然可以在闭包函数体内引用和修改这些值.
        
        //swift中,可以捕获值 的 闭包的最简单形式是 嵌套函数,即定义在其他函数的函数体内的函数.嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量.
        
        //闭包是引用类型 ,函数也是引用类型
        
        //逃逸闭包 关键字 @escaping ,闭包在函数返回之后才被执行,我们称该闭包从函数中逃逸.
        
        
//        var functionInstance = Curry
       
//MARK: 手势练习
        panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(panHandle))
        panGesture.delegate = self
        
        view.addGestureRecognizer(panGesture)
        
        
        longPressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressHandle))
        longPressGesture.numberOfTouchesRequired = 1
        longPressGesture.minimumPressDuration = 1
        longPressGesture.delegate = self
        view.addGestureRecognizer(longPressGesture)
        
        
        
        
        
    }
    
//MARK: 手势添加的方法
    
    func panHandle() {
        if self.view.alpha > 0.1 {
            
            self.view.alpha -= 0.1
        }
    }
    func longPressHandle() {
        
        self.view.alpha += 0.1
        self.view.backgroundColor = KRandomColor()
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
//MARK:外部函数的具体实现方法
    
    //MARK: 三 函数的分类:
    //有参有返回值
    //@discardableResult
    func sayHello(paraStr:String) -> String {
        return "hello ,world"
    }
    //无参有返回值
    
    func sayHello() -> String {
        return "hello ,world"
    }
    
    //无参无返回值
    
    func syaHello() -> Void {
        
    }
    //无参无返回值 一般写为
    func syaHello1() {
        
    }
    
    
    // 实现代码
    func greet(_ person: String, _ day: String) -> String {
        return "Hello \(person), today is \(day)."
    }
    
    //MARK:四 函数进阶
    
    //参数的类型:对象,数组,字典,元组,可变数量的参数,函数,闭包函数,协议,结构体,枚举值
    
    //函数 闭包函数 类似OC的block 但是协议好像还真么见过 
    
    func add(a:Int,b:Int)->Int{// 作为函数参数的函数 add
        return a+b
    }
    
    func calculate(c:(Int,Int)->Int) ->Void{// 定义的参数为函数 add 的 函数
        print(c(2,1))// 执行函数
    }
    //我有点不明白的是 (Int,Int)->Int就表示 函数 add么  那其他的函数作为参数表示时 也可以这样表示么 去掉函数名 
    
    //那试一下 
    
    func calculate1(a:[String:Int]){
        for student in a {
            print("===",student.key)
            print("====",student.value)
        }
    }
    
    func Iloveyou(mm:([String :Int])->Void) -> Void {
        
          mm(["xlp":0])
    }
    
    //把这个函数作为参数时 与一般的函数的区别是 一般的函数在调用时 才对参数就行赋值; 若是参数为函数的函数 其赋值在以函数为参数的函数里面 赋值 ,在调用时 只是 声明. 参考函数 calculate(c: add); 和 函数Iloveyou(mm: calculate1)
    //在Iloveyou函数里面 后面参数的部分 需要把函数参数的参数部分括起来 即是参数函数的参数是一个也得括起来,但是其返回值可以不括起来 这个得记得
    
    //FIXME:参数为 协议 protical 暂时搁置
    
    func IWantYouDoSomething(something:IWillPlayMusic) -> Void {
        
            something.beginPalyMusic()
    }
    
    //协议的方法的实现
    func beginPalyMusic() {
        print("Lili please play music")
    }
    
    
    // 定义枚举值
    enum CarType:String{
        case Lincoln = "林肯"
        case MERCURY = "水星"
        case SUZUKI = "铃木"
    }
    // 参数为枚举的方法
    func describeCar(carType:CarType){
        print(carType.rawValue);
    }
    
    //参数为结构体
    struct Student{
        var name:String
        var age:Int
    };
    
    func getStudentDescription(student:Student){
        print(student.name)
        print(student.age)
    }
    
    
    //*************
    //定义一个函数 传入 一个 booL值 若真 则返回表示两个数的和的函数  否则 返回表示两个数的差的函数
    
    //这个函数的特别之处是 返回值 为 函数 
    //注意 该函数在调用时的处理
    func generateFuncByFlag(flag:Bool) -> (Int,Int)->Int {
        
        //和 
        
        func addMM(a:Int,b:Int) -> Int{
            
            
            
            let temmm = a
            
            let a = b
            
            let b = temmm
            
            print(a,b)
            
            return a + b
        }
        
        func descreamMM(a:Int,b:Int) -> Int{
            return a - b
        }
        
        switch flag {
        case true:
            return addMM
        default:
            return descreamMM
        }
        
    }
    
    //这里涉及到 关键字 inout
    //其作用类似 OC中 若想在block内部修改其外部变量的值 一般会用 __block修饰该变量
    //在swift中,要怎么处理呢 这里就用到了 inout关键字 但是 其修饰的是 函数的参数 而不是 函数外部的变量 
    //1.inout的位置 在: 后面,数据类型前面;2.inout 修饰的参数不能有默认值;3.inout 不能用于修饰多值(如a:Int...)
    
    func swapTwoInts(  a: inout Int, b:inout Int){
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    
    //**********
    //该函数的作用是 获取调用该函数的 函数的名字 以及在哪一行调用的 在哪个文件调用的
    func getFunctionName(name:String = #function,line:Int =   #line,file:String = #file){
        print(name)
        print(line)
        print(file)
    }
    // 比如我们要获取下面函数: getUserName 的信息,只需要将函数写入要获取信息函数的内部调用即可
    // 当函数: getUserName 被调用时,就会返回 该函数的名字  哪一行被调用 在哪个文件 
    // 可能会在 打印类名 时 调用 ,这样调试时知道当前进入的是哪个函数
    func  getUserName(){
        getFunctionName()
    }
    
    /******************协议**********************/
    //MARK: 五 协议语法
    //定义:定义了一个蓝图,规定了用来实现某一特定任务或者功能的 方法 或 属性 ,以及其他需要的东西.->协议可以是 方法 ,也可以是 属性  ,这与OC不一样,OC一般是代理方法
    
    //类 结构体 枚举都可以遵循协议 这与OC不一样 ,OC是只有 类可以 遵循协议
    
    //还可以对协议进行扩展,通过扩展来实现一部分要求或者实现一些附加功能,这样遵守协议的类型就能够使用这些功能.
    
    //**语法:
    //1.其余类 结构体 枚举的定义非常类似  以Protocol开头
    
    //2.特别的是 若拥有父类的类在遵循协议时,应该将父类名放在协议名之前,以逗号分割:如下所示
    /*
    class SomeClss: SomeSuperClass,firstProtocol,TwoProtocol {
        //这里是类的定义部分
    }
    */
    //3.协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性.协议不指定属性是存储型属性还是计算型属性,他只指定属性的名称和类型.此外协议还指定属性是可读的还是可读可写的.
    //由3可知 ,协议总是由 var 关键字来声明变量属性,在类型声明后加上 { set  get }来表示属性 是可读可写的,可读属性则用 {get} 来表示.
    
    /*
     protocol SomePorotocol {
     
        var mustBeSet1:Int {get set}
        var mustBeSet2:Int {get}
     }
     */
    
    //例子 协议内容为 属性
    //遵守协议的是 结构体
    
    struct Person:CallMyNameProtocol {
        var name:String
        var age :Int
        var weught: Double
        var fullName: String //最后一行 若是没有 则警告 该结构体没遵守协议
    }
    //遵守协议的是 类 参考 类 GirlFriend
    
    //遵守协议的是 枚举 自己写
    
    //协议的内容是 方法 即OC常见的 代理方法,我们看看有什么不同
    //协议可以要求遵循的类型实现某些 指定的 实例方法 或 类方法 OC (- +号的区别),swift则是 修饰关键字 class的区别
    //与普通方法不同的是,不需要大括号和方法体,而OC也是只声明,在 调用的.m文件里面 写具体实现方法
    //不支持为协议中的方法的参数提供默认值
    //在协议中定义类方法时,总是使用 static 关键字 作为前缀修饰,当然也可以使用class修饰
    //参加协议 NewFuncProtocol
    //协议 对比 OC中的代理 学习 以及 tableview的实现方法 类比学习
  /*
 
     這裡講的 optional 不是 Swift 的 optional ，Swift 中 protocol 預設的行為，在 conforming 的 class 中就是都要一定要實作所有的 methods 。
     
     如果真的要指定某個 method 是 optional 的話，宣告的前面就要掛上 @objc 才可以使用
     
     @objc protocol MyProtocol {
     optional func optionalMethod()
     }
 */
    
    //MARK: 闭包 
    
    //MARK: 六 先回忆下 ,block函数的用法
    //匿名函数 自动获取变量
    //可做属性变量 
    /*
     具体的写法如下
     声明为
    void (^myBlock)(NSString *) = ^(NSString *nameStr){
    
    NSLog(@"你的名字是 %@",nameStr);
    }
    
     调用
    myBlock(@"caojianjia")
    
     常见的操作为 (类型定义 舍弃定义单词的后几个 最后变为typedef ine),作为block属性,封装时调用
     
     在接口文件 即 .h文件的 接口函数外部 声明
     typedef void (^myBlock)(NSString *) 
     
     则可以声明为block属性, 即
     @property(nonatomic,copy)myBlock subMyBlock; 
     
     或者 直接使用 
     
     - (UIView *)subitemView:(BOOL)hasArrow
     labelType:(int)labelType
     text:(NSString *)text
     hasLine:(BOOL)hasLine
     superView:(UIView *)superView
     type:(int)type onClick:(HDFButtonBlock)callback {
     
     ....
     
     selectButton = [HDFUIMaker buttonWithImage:@"group_arrow" touchUp:callback];
     
     }
    */
    
    //MARK: 现在开始进入闭包的学习 参考之前的例子

    //闭包之余 swift,与block之余 OC 是一样的 ,所以我们可以类比着学习
    //闭包(closure) 的 声明方式:
    // 声明一个闭包(有两个整形参数，且返回值为整形的闭包)
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

/*
 
 //遵守协议的 类 要怎么写 待定 ,按照API上写 会出现问题报错
//FIXME: internal 该关键字怎么使用
class GirlFriend: NSObject,CallMyNameProtocol {
    
    /*
    internal var fullName: String {
        print("MYGirlFriend's fullName is \(herName),herSize is \(herSize)")
    }
    */

    
    var herName:String
    var herSize:String
    
    init(herNames:String,herSizes:String) {
        
        self.herName = herNames
        self.herSize = herSizes
    }
   /*
    var fullName: String{
        print("MYGirlFriend's fullName is \(herName),herSize is \(herSize)")
    }
   */
}
  */
    
