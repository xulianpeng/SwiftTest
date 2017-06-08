//
//  XLP_UI_ViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/12.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class XLP_UI_ViewController: UIViewController,UITextViewDelegate {

    //MARK: - ww
    //FIXME: qqq
    //TODO: 

    
     //声明实例变量
     
     let tag1 = 100
     let tag2 = 101
    
    let tag3:Int = 300 
    var tag4:Double = 12.3
     
     var titleLabel2 = UILabel()
     var titleLabel = UILabel()
     var button1 = UIButton.init(type:.custom)
     var button2 = UIButton.init(type: UIButtonType.custom)
     
     var text = "akfjskjfksjfkjfkjsdkfjSSJAFDSJFKJ假的就分手就放开手的说的是交房卡萨就放开手的FSDKJFS大姐夫发几十块地方是使肌肤 的设计费水电费是打飞机 ;束带结发;说多了几分;是打飞机;了圣诞节饭;是打飞机;胜多负少;来得及发两款;阿萨德分类的设计费啥的放假洛杉矶的附件为符合你怎么能重新买,  放假;啥的方式;方式;打飞机;"

    //MARK: textfieldDemo
    
    var testTextfield = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        //类比 viewdidload方法 可以调用函数
        //我们都是一个价  名字叫中国
        //兄弟姐妹都很多景色也不错
        
        
        var testArr = [Any]()
        var testBarr = [String]()
        testBarr.append("123")
        print(testBarr)
        
        testArr = ["C","ddd","asda2sd","asas123d","asdasqwd","asda12","umnlknjkk","asd8908767"]
        
        print(testArr.popLast() ?? "默认")
        
        
        print(testArr.distance(from: 0, to: 3),testArr.endIndex,testArr.reserveCapacity(2))
        //生成马赛克背景
        
        let mskWidth = 10.0
        
//        let widthNum  = Int (kSCREENWIDTH)/mskWidth
//        let heightNum  = Int(kSCREENHEIGHT)/mskWidth
        let widthNum:Int8  = 1
        let heightNum:Int16  = 500
        let mySum = heightNum + Int16(widthNum)
        
        //输出的四种表达方式
        print(mskWidth,widthNum,heightNum,mySum)
        
        
        let mmNum = 10
        let nnNum = mskWidth + Double(mmNum)
        
        let aaNum = 10.3
        let bbNum = 3.9
        
        print(nnNum,Int(aaNum),mmNum + Int(bbNum))
        //输出结果为 20.0 10 13 取整时 是舍弃小数部分,不存在四舍五入这一说
        
        
//        print(mskWidth, to: &self)
//        print(widthNum, separator: "111", terminator: "222", to: &self)
//        
//        print(heightNum, separator: "333", terminator: "444")
//        for i in 320 {
//            for j in 500 {
//                let item = UIView(frame: CGRect(x: i*mskWidth, y: j*mskWidth,
//                                                width: mskWidth, height: mskWidth))
//                
//                item.backgroundColor = UIColor.green
//                self.view.addSubview(item)
//            }
        
            
//        }
        
        //元组练习
        let httpErrorMessage = (404,"Not Found")
        print("\(httpErrorMessage.0)",httpErrorMessage.1)
        let (statusCode,statusMessage) = httpErrorMessage
        print("\(statusCode)","====",statusMessage)
        
        let (justStatusCode,_) = httpErrorMessage
        print(justStatusCode)
        
        let http2016Status = (status:2016,message:"OK")
        print(http2016Status.status,http2016Status.message)
        
        
        let stringNum = "1245"
        let num = Int(stringNum)
        print(num ?? 0)
        
//        if num! == nil {
//            print(<#T##items: Any...##Any#>)
//        }
        
        //可选绑定
        let nnNumber = "1234String"
        if let mmNumber = Int(nnNumber){
            print(mmNumber,nnNumber)
        }else{
            print("\(nnNumber) can not be converted to an Integer多撒谎  swift要怎么转为image呢")
        }
        
        
        
        
//         initLabel(titleLabel)
//         initLabel2()
        //使用扩展来创建UILabel
        initLabel3()
        initLabel4()
        
        
//         initButton1()
//         initButton2()
         //使用扩展创建 UIButton
        initButton3()
        initButton4()
        
        //MARK: textfielddemo
        
        testTextfield.initTextfield(.red, fontSize: 14, placeholder: "什么情况", delegate: self, superView: view) { (make) in
            make.left.equalTo(30)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.right.equalTo(-30)
            make.height.equalTo(30)
        }
       
        
        //MARK: button runtime 测试
        /*
        let button3 = UIButton.init(type:UIButtonType.custom)
        button3.initButton5("按钮888", titleColor: .blue, fontSize: 14, imageStr: nil, backgroundImageStr: nil, cornerRedius: 6, target: self, snpMaker: { (make) in
            
//            make.left.equalTo(30)
//            make.top.equalTo(testTextfield.snp.bottom).offset(30)
//            make.right.equalTo(-30)
//            make.height.equalTo(30)
        }) {
            
//            self.testTextfield.text = "我爱你中国,亲爱的母亲"
        }
        
        */
//        @discardableResult
        let myBt = BaseUIButton.button(frame: CGRect(x:100,y:400,width:100,height:30), title: "崴泥中国", fontFloat: 14, image: nil, color: nil,target:self,superVtew:view) { (bt) in
            print("asdasdasd")
        }
        view.addSubview(myBt)
        
        let mybt1 = BaseUIButton.button(frame: CGRect(x:250,y:300,width:100,height:30), title: "请点我啊", fontFloat: 15, image: nil, color: .blue, target: self,superVtew:view) { (btn) in
            
            print("什么鬼啊啊啊啊 啊啊啊 啊啊啊啊啊啊啊 啊啊")
        }
       
        
        let loadBt = UIButton()
        loadBt.xlpInitButton("点击重载", titleColor: .red, fontSize: 15, imageStr: nil, backgroundImageStr: nil, cornerRedius: 4, superView: view, snpMaker: { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(40)
            make.top.equalTo(testTextfield.snp.bottom).offset(20)
        }) { (btn) in
            
            print("=======================点击重载=========================")
            self.view.backgroundColor = UIColor.yellow
        }
        
    
        //
        let testTextView = UITextView()
        self.view.addSubview(testTextView)
        testTextView.snp.makeConstraints { (make) in
            
            make.height.equalTo(100)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-10)
        }
        testTextView.backgroundColor = .yellow
        testTextView.xlpPlaceholder("你好未来的自己你好未来的自己你好未来的自己你好未来的自己你好未来的自己你好未来的自己你好未来的自己你好未来的自己", fontSize: 18)
        testTextView.delegate = self
        
        
        
        
        
        
        
    
    }

    //具体函数的实现
    
    
     //UILabel 的具体实现方法
    
    
     func initLabel(_: UILabel) -> Void {
     titleLabel2.frame = CGRect(x:10,y:130,width:kSCREENWIDTH - 20,height: 0);
     self.view.addSubview(titleLabel2)
     titleLabel2.backgroundColor = UIColor.green
     titleLabel2.text = text
     titleLabel2.numberOfLines = 0
     titleLabel2.textColor = UIColor.cyan
     titleLabel2.sizeToFit()
     //坑点:若自适应高度的话 必须先赋值 再设置自适应高度,否则无效
        
        //方法2 使用扩展
        
     }
    
    func initLabel3() {
        titleLabel2.creatLabel(text, aligenment: .left, fontSize: 16, textColor: .black, backgroundColor: .green, superView: self.view)
        
    }
    func initLabel4() {
        titleLabel.creatLabel(text, aligenment: .right, fontSize: 12, textColor: .red, backgroundColor: .gray, superView: view)
        
        titleLabel2.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(120)
            make.right.equalTo(-20)
            make.bottom.equalTo(titleLabel.snp.top).offset(-30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel2)
            make.right.equalTo(titleLabel2)
            make.top.equalTo(titleLabel2.snp.bottom).offset(30)
            
        }
    }
     func initLabel2() -> Void {
     
     titleLabel.frame = CGRect(x:10,y:kSCREENHEIGHT - 200,width:kSCREENWIDTH - 20,height: 0);
     view.addSubview(titleLabel)
     titleLabel.backgroundColor = UIColor.blue
     titleLabel.text = text
     titleLabel.numberOfLines = 0
     titleLabel.textColor = UIColor.purple
     titleLabel.sizeToFit()
     
     }
     /*
     func initButton1() -> Void {
     button1.frame = CGRect(x:20 ,y:70,width:(kSCREENWIDTH - 40)/2,height:40)
     button1 .addTarget(self, action:#selector(handleAction1(btn:)), for:.touchUpInside)
     //        button1.titleLabel?.text = "按钮111";
     //        button1.titleLabel?.textColor = UIColor.red
     //坑点:该属性无效
        
     
     button1 .setTitle("按钮111", for: .normal)
     
     button1.tag = tag1;
     button1.backgroundColor = UIColor.blue
     button1.layer.cornerRadius = 20
     view.addSubview(button1)
     }
     
     func initButton2() -> Void {
        
        button2.frame = CGRect(x:kSCREENWIDTH/2,y:70,width:button1.frame.width,height:button1.frame.height)
        WMUIMaker.creatButton(button: button2, title: "按钮222", titleColor: .green, imageStr:"" , backgroundImageStr: "", cornerRedius: 4, superView: view)
        button2.tag = tag2
        button2.addTarget(self, action: #selector(handleAction2(btn:)), for: .touchUpInside)

        
     }
    */
    func initButton3() -> Void {
        button1.creatButton("按钮333", titleColor: .red, imageStr: "", backgroundImageStr: "", cornerRedius: 5, superView: view) { (bt) in
            
           
        }
        button1.addTarget(self, action: #selector(handleAction1(btn:)), for: .touchUpInside)
        button1.tag = tag1
        button1.snp.makeConstraints({ (make) in
            make.top.equalTo(70)
            make.left.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        })
    }

    func initButton4() -> Void {
//        button2.creatButton("按钮444", titleColor: .green, imageStr: "", backgroundImageStr: "", cornerRedius: 5, superView: view) { (bt) in
////            bt.snp.makeConstraints({ (make) in
////                make.top.equalTo(70)
////                make.right.equalTo(-20)
////                make.width.equalTo(100)
////                make.height.equalTo(30)
////            })
////            bt.addTarget(self, action: #selector(handleAction2(btn:)), for: .touchUpInside)
//        }
        
        /*
        button2.creatButton("按钮444", titleColor: .gray, imageStr: "", backgroundImageStr: "", cornerRedius: 6, superView: view, myAction: #selector(handleAction2(btn:)))
        button2.tag = tag2
        button2.snp.makeConstraints({ (make) in
                            make.top.equalTo(70)
                            make.right.equalTo(-20)
                            make.width.equalTo(100)
                            make.height.equalTo(30)
                        })
        
        */
        
        /*
        button2.creatButton("按钮444", titleColor: .gray, imageStr:nil, backgroundImageStr: "", cornerRedius: 6, target:self, myAction: #selector(handleAction2(btn:)))
        button2.tag = tag2
        button2.snp.makeConstraints({ (make) in
            make.top.equalTo(70)
            make.right.equalTo(-20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        })
        */
        /*
        button2.xlpInit("按钮555", titleColor: .red, fontSize: 13, imageStr: nil, backgroundImageStr: nil, cornerRedius: 4, target: self, myAction: #selector(handleAction2(btn:)) , snpMaker: { (make) in
            make.top.equalTo(70)
            make.right.equalTo(-20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        })
        */
        button2.initButton("按钮666", titleColor: .blue, target: self, myAction: #selector(handleAction2(btn:))) { (make) in
            make.top.equalTo(70)
            make.right.equalTo(-20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        button2.tag = tag2
    }
     /// 按钮的点击事件
     /// - Parameter btn: 按钮1
     func handleAction1(btn:UIButton) -> Void {
        
        titleLabel.textColor = UIColor.yellow
        titleLabel.backgroundColor = UIColor.black
        titleLabel.transform = CGAffineTransform.init(rotationAngle: -0.5)
     if btn.tag == tag1{
     
     }
     }
     
     func handleAction2(btn:UIButton) -> Void {
     if btn.tag == tag2 {
     titleLabel.backgroundColor = UIColor.purple
     titleLabel.textColor = UIColor.brown
     titleLabel.transform = CGAffineTransform.init(rotationAngle: 0.5)
    
    titleLabel.text = "sadkhsjhajkhjasjdf"
     }
     }
 

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let keyBoardManager = IQKeyboardManager.sharedManager()
//        keyBoardManager.enable = false
//        keyBoardManager.keyboardDistanceFromTextField = -20
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //swift did uibutton hahaha you are my teacher  w will texach
        // Dispose of any resources that can be recreated.
    }
    

  
}
