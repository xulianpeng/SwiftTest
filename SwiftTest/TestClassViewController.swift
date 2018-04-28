//
//  TestClassViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/14.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
import SnapKit
class TestClassViewController: UIViewController {

    
    struct Range11 {  // 结构体 定义 存储属性
        let first:Int
        var length:Int
    }
    class Student{  // 类 定义 存储属性
        var name:String!
        var score:String!
    }
    
    class DataImporter {
        //假设该类负责将外部文件中的数据导入到类 其初始化会消耗不少时间
        
        var fileName = "data.text"
    }
    
    class DataManager {
        lazy var importor = DataImporter()
        var data = [String]()
        
    }
    /*
    extension Int {
        func repeatNum(task:() -> Void) {
            for _ in 0..<self {
                task()
            }
        }
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.green
        
        let range1 = Range11(first:6,length:3)
        //MARK:小结1:
        //如果一个结构体被实例化为 一个常量结构体 则其不能被修改 即是其内部是变量存储属性
        //说明 结构体 是一个值类型 当值类型的实例 被声明为 常量的时候,他的所有属性也就成了常量
        //相对 若是 应用类型 的 类 ,把一个引用类型的 实例 赋给 一个常量 后,仍然可以修改该实例的变量属性
//        range1 = Range11(first:6,length:4)
        print(range1,Range11(first:1,length:5))
        
        
        //MARK:延迟存储属性
        
        //延迟存储属性是指当第一次调用的时候才会计算其初始值的属性 在属性声明前使用 lazy 来标识一个延迟存储属性.
        //延迟存储属性必须声明为 var ,因为属性的初始值可能在实例构造完成之后才会得到
        //而let 常量 在构造过程完成之前必须要有初始值  let常量怎么办
        //使用延迟存储属性避免复杂类中不必要的初始化 
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //被标记为 lazy 的属性在没有初始化就被多个线程访问,则无法保证该属性只会被初始化一次 
        
        //MARK: 计算属性
        //其可以在 类 结构体 枚举 中定义 
        //计算属性不直接存储值,而是提供一个 getter 和 一个可选的 setter方法.来间接获取和设置 其他属性的值
        
        struct Point{
            var x = 0.0,y = 0.0
        }
        
        struct Size{
            var width = 0.0,height = 0.0
        }
        struct Rect{
            var origin = Point()
            var size = Size()
            var center :Point {
                
                get{
                    
                    let centerX = origin.x + (size.width/2)
                    let centerY = origin.x + (size.height/2)
                    
                    return Point(x:centerX,y:centerY)
                    
                }
                set(newCenter){
                    
                    origin.x = newCenter.x - (size.width/2)
                    origin.y = newCenter.y - (size.height/2)
                }
            }
        }
        
        var square = Rect(origin:Point(x:0.0,y:0.0),size:Size(width:20.0,height:20.0))
        
        let newCenter = square.center//访问 结构体中 计算属性 center ,该计算属性是由 该机构体中的 其他两个存储属性 计算得来的
        
        print(newCenter)
        //MARK: 小结2 计算属性之初步的了解和认识
        //只有getter的计算属性是只读属性 只读属性总是返回一个值,可以通过点运算符访问,但不能设置为新值
        //只读计算属性的声明 可以 去掉 get 关键字 和 花括号==>这个在实际开发中经常是这样做的,切记
        //setter方法 新值默认为 newValue ,也可以自定义
        
        //****************华丽分割线*************************
        //MARK: 属性观察器  听上去 有点像 OC上的观察者模式
        
        //属性观察器 监控 和  响应值的变化,每次属性被设置值的时候都会调用属性观察器,即是新值和当前值相等
        //可以为除了延迟存储属性之外的其他存储属性添加属性观察器
        // .willSet 在新的值 被设置之前调用  .didSet 在新的值被设置之后立即调用
        
        //willSet观察器会将新的属性值作为常量参数传入,在willSet的实现代码中可以为这个参数指定一个名称.如果不指定则参数仍然可以使用,这时使用默认名称 newValue表示
        //同理 didSet观察器会将旧的属性值作为参数传入,可以为该参数命名或者使用默认参数名 oldValue.如果在didSet方法中再次对该属性赋值,那么新值会覆盖旧的值.
        
        //父类的属性在子类的构造器中被赋值时,他在父类中的观察器会被调用,随后才会调用子类的观察器.在父类初始化方法调用之前,子类给属性赋值时,观察器不会被调用
        
        class StepCounter{
            var totalSteps:Int = 0 {
                willSet(newValue){
                    print("I will set newValue to \(newValue)")
                }
                didSet{
                    if totalSteps > oldValue {
                        print("i added \(totalSteps - oldValue) steps")
                    }
                }
            }
        }
        
        let stepNums = StepCounter()
        stepNums.totalSteps = 200
        
        stepNums.totalSteps = 300
        
        stepNums.totalSteps = 320
        
        //MARK: 与结构体作比较, 实例化一个 类 为 常量,其属性值 可以改变
        
        //全局变量 局部变量 和OC一样  在函数 方法 闭包 或任何类型 之外定义的变量 是全局变量
        //计算型变量 和 计算属性一样 返回一个计算结果而不是存储值,声明格式完全一样
        
        //*****************华丽分割线**********************
        
        //MARK: 类型变量
        
        //MARK:实例属性:实例的属性就是实例属性.
        //每创建一个实例,实例都有属于自己的一套属性值,即实例属性,实例之间的属性相互独立
        
        //MARK:类型属性:若无论创建多少个该类型的实例,某一属性都只有唯一的一份,则 该属性即为 类型属性.
        //由这句话 我们应该会想到 static这个关键字,正如我们所想 若用 static修饰 该属性即为 类型属性
        
        struct AudioChannel {
            static let soundLevel = 10
            static var maxSoundLevel = 0
            var currentLevel:Int = 0 {
                
                didSet {
                    
                    if currentLevel > AudioChannel.soundLevel {
                        currentLevel = AudioChannel.soundLevel
                    }
                    if currentLevel > AudioChannel.maxSoundLevel{
                        AudioChannel.maxSoundLevel = currentLevel
                    }
                }
            }
            
            
        }

        var leftSoundChannel = AudioChannel()
        var rightSoundChannel = AudioChannel()
        
        leftSoundChannel.currentLevel = 7
        rightSoundChannel.currentLevel = 30
        
        print(leftSoundChannel.currentLevel,AudioChannel.maxSoundLevel,rightSoundChannel.currentLevel,AudioChannel.maxSoundLevel)
        //MARK:
        
        
    
    }
    
    //制作一个标签view
    func initTagViews(titleArr:[String]) -> UIView {
        let rootView = UIView()
        
        for (index,tag) in titleArr.enumerated() {
            var subView:UILabel = UILabel()
            rootView.addSubview(subView)
            subView.snp.makeConstraints({ (make) in
                make.left.equalTo(0)
                make.top.equalTo(5)
                make.height.equalTo(30)
            })
        }
        
        
        
        return rootView
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
