//
//  XLP_OperatorsVController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/13.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

/**
 
 ## 基本的操作运算符
 
 - 运算符分为 一元 二元  三元运算符.
 - 一元运算符分为前置运算符 和 后置运算符 ,例如 !a  b!
 - 二元运算符常见的有 = + - * / %
 - 三元运算符操作三个对象,目前只有 三目运算符 a?b:c  (如果a为真 则输出b 否则输出c)
 
 2 赋值运算符 
  = 和OC一样,但 赋值操作此时不返回值,所以无法作为if语句的条件
 */

class XLP_OperatorsVController: UIViewController {

    //枚举 跟OC的写法不太一样 注意两者的区别
    enum TestResult{
        
        case pass
        case NoPass
    }
    //enum testResult{
    //     passing,
    //     nopassing
    //}
    
    var studentScoreDic = [String:Double]()
    
    let testView = UIView()
    var toastView = UIView()
    
    var popButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "基本运算符"
        self.view.backgroundColor = UIColor.yellow

        //2 赋值运算符
        
        let a = 100
        var b = a
        
        
//        if b = a {
//            print(a,b)
//        }
        
        print(a,b)
        //如果赋值的右边是多元组,则其元素可马上分解为多个常量或变量
        let (x,y) = (3,4)
        print(x,y)
        
        //四则运算 +-*/
        
        //swift默认情况下是不允许在数值运算中出现溢出的情况,但可使用swift的溢出运算符来实现溢出运算????该情况待定
        // + 也可用于String的拼接
        
        let c = 6
        
        let d = a/c
        let m = -c
        let g = a/m
        print(d,g)
    
        //一元负号运算符 切换数值的正负
        //一元正号运算符 不做任何改变
        
        //组合赋值运算符
        
        var f = 10
        f += 2
        print(f)
        
//        mm = f += 2
//        print(mm)
        //组合赋值运算符没有返回值 所以 无法赋值给 mm 
        
        //比较运算符
        //和c一样 == != > < >= <=
        
        //比较运算符常用于条件语句 ,如下
        
        let name = "world"
        if name == "world" {
            print("hello")
        }else
        {
            print("i am sorry")
        }
        
        //元组也可以做大小比较,其元素按照从左到右,逐值比较的方式,直到发现有两个值不等时停止,然后这两个元素的大小决定了元组的大小关系
        
        //来了 来了  空合运算符
        //a ?? b 解释:a 必须为可选类型,如果 a 包含一个值就进行解封,否则就返回一个默认的 b. b 的类型必须要和 a 存储值的类型保持一致.
        
        let defaultColor = "red"
        var userdefaultColor :String?  //默认值为 nil 类型为可选类型
        
        let colorNow = userdefaultColor ?? defaultColor
        
        userdefaultColor = "green"
        
        let colorNow2 = userdefaultColor ?? defaultColor
        
        print(colorNow,colorNow2)
        
        //区间运算符 ... 闭合的
        
        for index in 0...8 {
            print("\(index) * 5 = \(index * 5)")
        }
        //半开区间运算符
        
        for index in 0 ..< 5 {
             print("\(index) * 5 = \(index * 5)")
        }
        
        //逻辑运算符  && || 同OC一样
        //两者的组合计算 计算原则是 左结合
        
        //使用括号来明确优先级
        
        //***************华丽分割线*****************
        
        
        //字符串与字符
        
        
        
        
        
        //***************华丽分割线*****************
        
        //字典
        
        //1 创建
        
        let testDic = [Int:String]()
        
        let stringDic :[String :String] = ["asd":"123s","zxc":"234d"]
        
        var stringDic2 = ["asd":"123s","zxc":"234d","jkl":"9897"]
        
        
        
        print(testDic,stringDic,stringDic2)
        //字典是无序的
        //添加新的键值对 修改某一键值
        stringDic2["mama"] = "iloveyou"
        print(stringDic2)
        stringDic2["asd"] = "dasini"
        print(stringDic2)
        
        
        if let oldValue = stringDic2.updateValue("newValue", forKey: "zxc") {
            print(oldValue)
        }
        
        //这个方法 更新字典的同时 又返回该key所对应的老的 value值
        let oldValue1 = stringDic2.updateValue("newValue", forKey: "jkl")
        print(oldValue1 ?? "noValue")

        /*
        //清空
        stringDic2 = [:]
        print(stringDic2)
        
        if stringDic2.isEmpty {
            print("字典为空")
        }
 
        //移除值
        stringDic2["asd"] = nil
        print(stringDic2)
//        stringDic2.remove(at: "zxc")
        stringDic2.removeValue(forKey: "jkl")
        print(stringDic2)
        
        */
        
        //遍历字典
        
//        for (dicKey,dicValue) in stringDic2 {
//            print("\(dicKey),===\(dicValue)")
//        }
        
        for dicKey in stringDic2.keys {
            print(dicKey)
        }
        for dicValue in stringDic2.values {
            print(dicValue)
        }
        
        
        //中级删除
        print(stringDic2)

        //从第几个位置开始偏移几位删除
        stringDic2.remove(at: stringDic2.index(stringDic2.startIndex, offsetBy: 2))
        
        print(stringDic2)
        
        //将 key值 或value值 存入数组
        let keysArr = [String](stringDic2.keys)
        let valuesArr = [String](stringDic2.values)
        
        print(keysArr,valuesArr)
        //***************华丽分割线*****************
        
        //流控制
        //哗啦啦来了来了来了,当里个当...
        
        //if ... else ...
        if true {
            //
        }else{
            //
        }
        
        //这点和OC不同,必须是 true,否则会提示错误,其他非nil对象不可以 ,切记切记
        
        //三目运算符 ? :
        // ??
        //范围操作符 ..<  即for循环  右端不包括  若是右端包括 则需要用 ...
        
        for mm in 0...6 {
            print("===\(mm)")
        }
        //多种逻辑操作符  && ||  ! 左结合
        
        //for ... in  这个是遍历 遍历数组 字典 
        
        //while
        //大坑点来了  如果是 >0 就会报错 如果  > 0 就没问题  我那个擦
        var ii = 100
        while ii > 0 {
            ii = ii - 1
            print(ii)
        }
        
        //repeat ... while
        
        var jj = 10
        repeat {
            jj -= 1
            print(jj)
        }while jj >= 0
        
        //switch  case   来了来了 做好准备啦
        print(inputStudentScore(score: 89))
        
        //需求二: 输入一个顶点 判断是否在X轴上,或者Y轴上,或者既不在x轴,也不再Y轴上
        //感受一下3种方法的差异
        //元组法  绑定值  混合法
        
        surePointIsWhere(point: (2.9,0))
        inputPoint2(point: (0,5))
        inputPoint3(point: (2,8))
        
        //continue
        let puzzleInput = "great minds think alike"
        var puzzleOutput = ""
        for character in puzzleInput.characters {
            switch character {
            case "a", "e", "i", "o", "u", " ":
                continue
            default:
                puzzleOutput.append(character)
                print(puzzleOutput)
            }
        }
        
        //break  一般与switch连用 跳出循环
        let numberSymbol: Character = "三"  // Chinese symbol for the number 3
        var possibleIntegerValue: Int?
        switch numberSymbol {
        case "1", "١", "一", "๑":
            possibleIntegerValue = 1
        case "2", "٢", "二", "๒":
            possibleIntegerValue = 2
        case "3", "٣", "三", "๓":
            possibleIntegerValue = 3
        case "4", "٤", "四", "๔":
            possibleIntegerValue = 4
        default:
            break
        }
        
        print(possibleIntegerValue ?? 111)
        
        // fallthrough 其与 一般的区别是 满足条件时 也会执行default的语句 然后跳出循环
    
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
        fallthrough // 打穿继续向下执行
        default:
            description += " is an integer."
        }
        print(description)
        
        //return  没啥特别的
        
        //标签用法
        var start:Int = 0
        let final = 100
        whileLabel: while start != final {
            start += Int(arc4random_uniform(100)) // 随机增加一个数字
            switch start {
            case final:  // 如果== 最终值结束循环
                print(start)
                break whileLabel
            case let x where x > final: //如果值大于100 则初始化为0 继续开始循环
                start = 0
                continue whileLabel
            default:
                break
                  }
            
        }
        
        //需求: 输入学生姓名,查询学生成绩
        studentScoreDic = ["小明":30.0,"小摩纳哥":99.0]
        
        //重点来了 多看看后几种swift方法 跟OC有区别 且更方便
        print(getScoreByName1(name: "小李"),
              getScoreByName2(name: "小摩纳哥"),
              getScoreByName3(name: "小明"),
              getScoreByName4(name: "小明"),
              getScoreByName5(name: "小明"),
              getScoreByName6(name: "小明"))
        
        //中级用法
        
        //需求:输入两个数字,如果两个数字都小于100 并且第一个数字小于第二数字,按照顺序输出他们
        
        outputTwoNum(num1: "10", num2: "80")
        
        
        //注意可选值的判断逻辑
        
        /*
        let name1:String! = "酷走天涯" // 定义一个需要解封的可选值
        let name2:String? = "酷走天涯" // 定义可选值
        let name3:String = "酷走天涯"  // 定义非可选值
        
        if name1 != nil {
        } // 编译成功
        if let myName = name1{
        } // 编译错误
        
        if name2 != nil {
        } // 编译成功
        if let myName = name2{
        } // 编译错误
        
        if name3 != nil {
        } // 编译警告 - 总是成功
        if let myName1 = name3{
        } // 编译错误 - name3 不是可选值
        */
        
        //枚举
        //Swift 3.0 开始,定义枚举值,统一小写
        //多行写法
        enum MMEnum{
            
            case ss
            case aa
            case bb
        }
        //单行写法
        enum NNEnum{
            case zz,xx,cc
        }
        print(MMEnum.aa)
        
        //指定枚举类型的原始数据类型
        enum Rank: Int{ // Int 设置枚举值的类型
            // 定义枚举值设置值
            case ace
            // 可以case 后面一次定义多个枚举值
            case two, three, four, five, six, seven, eight, nine, ten
            case jack, queen, king
            
            // 定义函数 如果多人合作的时候,可以使用这个让别人更加了解你定义的属性的含义
            func simpleDescription() -> String {
                switch self { // self 就是这个枚举本身
                case .ace:
                    return "ace1"
                case .jack:
                    return "jack1"
                case .queen:
                    return "queen1"
                case .king:
                    return "king1"
                default:
                    return String(self.rawValue)
                }
            }
            
            
        }
        print(Rank.ace)
        
        //枚举还有好多 暂时先不考虑
        
        
        
        
        
        
        
        testViewGesture1()
        testViewGesture2()
        
        popButton.xlpInitEassyButton("添加", titleColor: UIColor.purple, fontSize: 13, backgroundColor: .yellow, cornerRedius: 4, superView: self.view, snpMaker: { (make) in
            make.top.equalTo(testView)
            make.width.equalTo(30)
            make.right.equalTo(self.view).offset(-10)
            make.height.equalTo(testView)
        }) { (bt) in
            
            self.showPopView(self.popButton)
        }
        
        showToastView()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    func inputStudentScore(score:Float) -> TestResult{
        switch score {
        case 0..<59:
            return .NoPass
        default:
            return .pass
        }
    }
    //元组法
    func surePointIsWhere(point:(Float,Float)) -> Void {
        switch point {
        case (_,0):
            print("点在x轴上")
        case(0,_):
            print("点在y轴上")
        case(_,_):
            print("既不在x轴上,又不在y轴上")
//        default:
//            print("还有特殊的么,实际上这一句可以删去")
        }
    }
    //值绑定法
    func inputPoint2(point : (Float,Float)) {
        switch point {
        case (let x ,0):
            print("在x轴上\(x)")
        case (0,let y):
            print("在y轴上\(y)")
        case let (x,y):
            print("既不在x轴,也不在y轴上\(x),\(y)")
        } 
    }
    
    //混合法
    func inputPoint3(point : (Float,Float)) {
        switch point {
        case (let x ,0),(0,let x):  // 注意必须每种模式类型相同
            print("在x轴或者y轴上\(x)")
        case let (x,y):
            print("既不在x轴,也不在y轴上\(x),\(y)")
        }
    }
    
    
    //需求: 输入学生姓名,查询学生成绩
    
    //方法1 是OC的写法
    func getScoreByName1(name:String!)->Double{ // 先检测姓名是否为空
        
        var score = 0.0
        
        if name != nil {
            
            if studentScoreDic.keys.contains(name) {
                score = studentScoreDic[name]!
                
                print("\(name)同学的成绩为\(score)")
                

            }
            /*
            if let score = studentScoreDic[name] {// 检测学生是否存在
                print("\(name)同学的成绩为\(score)")
                return score
            }
 */
        }else{
            
            print("该同学__\(name)不存在")
            
        }
        return score
    }
    
    //方法2 是swift的写法
    func getScoreByName2(name:String!)->Double{ // 先检测姓名是否为空
        if let n = name {
            if let score = studentScoreDic[n] {// 检测学生是否存在
                return score 
            }
        }
        return 0.0
    }
    //方法3  guard ... else
    func getScoreByName3(name:String!)->Double{
        // 检测姓名是否为空
        guard let n = name else {
            return 0.0
        }
        // 检测学生是否存在
        guard let score = studentScoreDic[n] else{
            return 0.0
        }
        return score
    }
    
    //使用?? 简化写法
    func getScoreByName4(name:String!)->Double{
        guard let n = name else {
            return 0.0
        }
        return studentScoreDic[n]  ?? 0.0
    }
    
    //多条件简化法- guard 版
    func getScoreByName5(name:String!)->Double{
        guard let n = name ,let score = studentScoreDic[n] else {
            return 0.0
        }
        return score
    }
    //多条件简化法- if 版
    func getScoreByName6(name:String!)->Double{
        if let n = name ,let score = studentScoreDic[n]{
            return score
        }
        return 0.0
    }
    
    //输入两个数字,如果两个数字都小于100 并且第一个数字小于第二数字,按照顺序输出他们

    //坑点 是 运算符 两端必须空格   ;然后函数的设计并没有真正的解决需求
    func outputTwoNum(num1:String,num2:String) -> Void {
        
        if let num11 = Int(num1) {
            if let num22 = Int(num2) {
                if num11 < num22 && num22 < 100 {
                    print("小的数为\(num11),较大的数为\(num22)")
                }
            }
        }
    
        if let num111 = Int(num1),let num222 = Int(num2),num111 < num222,num222 < 100 {
            print( "小的数为\(num111),较大的数为\(num222)")
        }
    }
    
    
    func testViewGesture1() {
        
    
        let testView = UIView()
        let aFrame = CGRect(x:100,y:100,width:100,height:100)
        testView.initView(frame: aFrame, superView: self.view, snpMaker: nil) { (tap) in
            
            self.view.backgroundColor = XLPRandomColor()
            self.showPopView(testView)
        }
        self.view.addSubview(testView)
        testView.backgroundColor = UIColor.red
        
        
        
    }
    
    func testViewGesture2() {
        
        
        
        testView.initView(superView: self.view, snpMaker: { (make) in
            make.width.height.equalTo(100)
            make.center.equalTo(self.view.center)
            
        }) { (tap) in
            self.view.backgroundColor = XLPRandomColor()
            self.showPopView(self.testView)
        }
        self.view.addSubview(testView)
        
        testView.backgroundColor = UIColor.blue
    }
    
    func showToastView()  {
        
        
        kCreateDocDirectoryWith("xlp")
        toastView.initView(superView: wmKeyWindow(), snpMaker: { (make) in
            make.left.top.equalTo(0)
            //            make.right.equalTo(0)
            make.width.equalTo(kSCREENWIDTH)
            make.height.equalTo(64)
            
        }, WMTapBlock: { (tap) in
            
//            self.view.backgroundColor = XLPRandomColor()
            UIView.animate(withDuration: 3) {
                
                //不能在自己的点击事件里面写updateConstraints动画,否则没有渐变的效果,最终是瞬时效果
                
//                self.toastView.snp.updateConstraints({ (make) in
//                    make.top.equalTo(64)
//                    make.left.equalTo(0)
//                    make.width.equalTo(kSCREENWIDTH)
//                    make.height.equalTo(64)
//                })
            
                //但是如果更新别的对象的约束  则具有渐变效果 
                //那么关于toast的初始化 再用 约束 的话 就够呛了 暂时还是先按照 frame进行初始化吧
                self.testView.snp.updateConstraints({ (make) in
                    make.width.height.equalTo(200)
                    make.center.equalTo(self.view.center)

                })
                
                 self.view.layoutIfNeeded()
            }
           
            
        })
        
        toastView.backgroundColor = UIColor.purple
        
        
        let label:UILabel = UILabel()
        label.initLabel("网络链接有问题,请重新设置", textColor: .black, fontSize: 16, isBold: false, aligenment: .left, backgroundColor: .clear, superView: toastView) { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(toastView.snp.bottom).offset(-5)
            make.right.equalTo(0)
            make.height.equalTo(kXLPFontSize(16).lineHeight)
        }
        
//        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 100, options: .allowUserInteraction, animations: { 
//                self.toastView.frame.origin.y = -64
//        }, completion: nil)
        
//        self.view.layoutIfNeeded()
//        UIView.animate(withDuration: 10) {
////            self.toastView.snp.makeConstraints({ (make) in
////                
////                make.top.equalTo(-64)
////            })
//            
//            self.toastView.snp.remakeConstraints({ (make) in
//                make.top.equalTo(-64)
//            })
//        }
        
    }
    
    func showPopView(_ pointView:UIView)  {
        
        let apopView = PopoverView.init()
        
        let action1 = PopoverAction.init(image: kImageWithName("right_menu_multichat@2x"), title: "发起多人聊天") { (action) in
            
        }
        let action2 = PopoverAction.init(image: kImageWithName("right_menu_addFri@2x"), title: "加好友") { (action) in
            
        }
        let action3 = PopoverAction.init(image: kImageWithName("right_menu_QR@2x"), title: "扫一扫") { (action) in
            
        }
        let action4 = PopoverAction.init(image: kImageWithName("right_menu_facetoface@2x"), title: "面对面快传") { (action) in
            
        }
        let action5 = PopoverAction.init(image: kImageWithName("right_menu_payMoney@2x"), title: "付款") { (action) in
            
        }
        //        apopView.show(to: testView, with: [action1,action2,action3,action4,action5])
        let arr = [action1!,action2!,action3!,action4!,action5!]
        apopView.show(to: pointView, with: arr)
        //        apopView.show(to: CGPoint(x:100,y:100), with: arr)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        toastView.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
