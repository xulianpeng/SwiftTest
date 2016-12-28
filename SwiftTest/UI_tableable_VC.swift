//
//  UI_tableable_VC.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/10.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

class UI_tableable_VC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    var dataArr = NSMutableArray()
    var myTableView = UITableView.init(frame: CGRect(x:0,y:0,width:SCREENWIDTH,height:SCREENHEIGHT), style:UITableViewStyle.plain)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "自定义Cell"
        initArray()
        initUI()
        
    }

    func initArray(){
        
        //重点来了 控制流 
        
        for index1 in 1...20 {
            
            let indexString1:String = String(format:"%d_title",index1)
            let indexString2:String = String(format:"%d_subTitle",index1)
            let modal1 = OneModal.init(name1: indexString1, name2: indexString2)
            dataArr.add(modal1)
        }
    }
    func initUI() {
        /*
        myTableView.backgroundColor = UIColor.white
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        view.addSubview(myTableView)
        myTableView .reloadData()
        */
        myTableView.initTableView(delegate: self, superView: view)
        myTableView .register(OneCell.self, forCellReuseIdentifier: "mmcell")//可舍弃
        
        
    }
    
    //tableview的代理方法
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    private func numberOfSectionsInTableView(tableView:UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "mmcell") as? OneCell
        if cell1 == nil {
            cell1 = OneCell.init(style: .default, reuseIdentifier: "mmCell")
        }
        let xlpCellModal:OneModal = dataArr[indexPath.row] as! OneModal
        cell1?.showViewWithModal(modal: xlpCellModal)
        cell1?.backgroundColor = UIColor.clear
        
        //button 的点击事件
        
        cell1?.clickBt .addTarget(self, action: #selector(handleAction1(btn:)), for: UIControlEvents.touchUpInside)
        
        return cell1!
    }

    func handleAction1(btn:UIButton) -> Void {
        myTableView.backgroundColor = randomColor()
        
    }
    
    func randomColor() -> UIColor {
        
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
