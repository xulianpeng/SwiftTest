//
//  ViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/9.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
  
    
    var myTableView = UITableView()
    
    let nameArray = NSArray.init(array: ["2333","5555","asdf","xxfa","ddd","123"])
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //类比 viewdidload方法 可以调用函数
        /*
//        initLabel(titleLabel)
        initLabel2()
        initButton1()
        initButton2()
        */
        myTableView = UITableView.init(frame: CGRect(x:0,y:0,width:screenWidth,height:screenHeight), style: .grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
        myTableView.backgroundColor = UIColor.gray
        
    }

    //具体函数的实现
    
    /*
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
        button2.addTarget(self, action: #selector(handleAction2(btn:)), for: .touchUpInside)
        button2 .setTitle("按钮222", for: .normal)
        button2 .setTitleColor(UIColor.green, for: .normal)
        button2.tag = tag2
        button2.backgroundColor = UIColor.darkGray
        button2.layer.cornerRadius = 4;
        button2.layer.masksToBounds = true
        view.addSubview(button2)
    }
    
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
    */
    
    //tableview的代理方法
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 40.0
    }
    private func numberOfSectionsInTableView(tableView:UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell1 = UITableViewCell.init(style: .subtitle, reuseIdentifier: "mmCell")
        
        let nameLable = UILabel.init(frame: CGRect(x:0,y:5,width:40,height:15))
        nameLable.backgroundColor = UIColor.magenta
        cell1.contentView.addSubview(nameLable)
        
        nameLable.text = nameArray[indexPath.row] as? String

        return cell1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oneTableView = UI_tableable_VC()
        oneTableView.title = indexPath.row as? String
        self.navigationController? .pushViewController(oneTableView, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

