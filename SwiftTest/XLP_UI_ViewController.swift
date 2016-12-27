//
//  XLP_UI_ViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/12.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

class XLP_UI_ViewController: UIViewController {

    //MARK: - ww
    //FIXME: qqq
    //TODO: 

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
     //声明实例变量
     
     let tag1 = 100
     let tag2 = 101
    
    let tag3:Int = 300 
    var tag4:Double = 12.3
     
    
     var titleLabel = UILabel()
     var button1 = UIButton.init(type:.custom)
     var button2 = UIButton.init(type: UIButtonType.custom)
     
     var text = "akfjskjfksjfkjfkjsdkfjSSJAFDSJFKJ假的就分手就放开手的说的是交房卡萨就放开手的FSDKJFS大姐夫发几十块地方是使肌肤 的设计费水电费是打飞机 ;束带结发;说多了几分;是打飞机;了圣诞节饭;是打飞机;胜多负少;来得及发两款;阿萨德分类的设计费啥的放假洛杉矶的附件为符合你怎么能重新买,  放假;啥的方式;方式;打飞机;"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        //类比 viewdidload方法 可以调用函数
        
        
        //生成马赛克背景
        
        let mskWidth = 10.0
        
//        let widthNum  = Int (screenWidth)/mskWidth
//        let heightNum  = Int(screenHeight)/mskWidth
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
            print("\(nnNumber) can not be converted to an Integer")
        }
        
        
        
        
         //        initLabel(titleLabel)
         initLabel2()
         initButton1()
         initButton2()
 
        
        
    }

    //具体函数的实现
    
    
     //UILabel 的具体实现方法
    
    
     func initLabel(_: UILabel) -> Void {
     titleLabel.frame = CGRect(x:10,y:100,width:screenWidth - 20,height: 0);
     self.view.addSubview(titleLabel)
     titleLabel.backgroundColor = UIColor.blue
     titleLabel.text = text
     titleLabel.numberOfLines = 0
     titleLabel.textColor = UIColor.magenta
     titleLabel.sizeToFit()
     //坑点:若自适应高度的话 必须先赋值 再设置自适应高度,否则无效
     
     }
     
     func initLabel2() -> Void {
     
     titleLabel.frame = CGRect(x:10,y:150,width:screenWidth - 20,height: 0);
     view.addSubview(titleLabel)
     titleLabel.backgroundColor = UIColor.blue
     titleLabel.text = text
     titleLabel.numberOfLines = 0
     titleLabel.textColor = UIColor.purple
     titleLabel.sizeToFit()
     
     }
     
     func initButton1() -> Void {
     button1.frame = CGRect(x:20 ,y:70,width:(screenWidth - 40)/2,height:40)
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
        
        button2.frame = CGRect(x:screenWidth/2,y:70,width:button1.frame.width,height:button1.frame.height)
        WMUIMaker.creatButton(button: button2, title: "按钮222", titleColor: .green, imageStr:"" , backgroundImageStr: "", cornerRedius: 4, superView: view)
        button2.tag = tag2
        button2.addTarget(self, action: #selector(handleAction2(btn:)), for: .touchUpInside)

     }
    
    
    
     /// 按钮的点击事件
     ///
     /// - Parameter btn: 按钮1
     func handleAction1(btn:UIButton) -> Void {
     if btn.tag == tag1{
     titleLabel.textColor = UIColor.yellow
     titleLabel.backgroundColor = UIColor.black
     titleLabel.transform = CGAffineTransform.init(rotationAngle: -0.5)
     }
     }
     
     func handleAction2(btn:UIButton) -> Void {
     if btn.tag == tag2 {
     titleLabel.backgroundColor = UIColor.purple
     titleLabel.textColor = UIColor.brown
     titleLabel.transform = CGAffineTransform.init(rotationAngle: 0.5)
     }
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
