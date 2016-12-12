//
//  RootViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/12.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

class RootViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var rootTableView : UITableView?
    
    var dataArr:NSMutableArray = NSMutableArray()
    var vcArr = NSMutableArray()
    
    
//    var rootTableView:UITableView = UITableView.init(frame: CGRect(x:0,y:0,width:screenWidth,height:screenHeight), style: UITableViewStyle.grouped) //在声明时不能调用之前声明的属性,必须在函数中调用才会识别
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        obtainDataArr()
        
    }
    func layoutUI() -> Void {
        rootTableView = UITableView.init(frame: CGRect(x:0,y:0,width:screenWidth,height:screenHeight), style: .plain)
        rootTableView?.delegate = self
        rootTableView?.dataSource = self
        rootTableView?.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        view.addSubview(rootTableView!)
        
    }
    
    func obtainDataArr() -> Void {

       dataArr = NSMutableArray.init(array: ["UI控件Test","数据类型Tset","TableView自定义Test"])
        vcArr = NSMutableArray.init(array: [XLP_UI_ViewController(),UI_tableable_VC(),UI_tableable_VC()])
    }
    
    //tableview的代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifierStr = "cell"
//        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierStr)!
//        if  cell == nil {
//            cell = UITableViewCell.init(style:.subtitle, reuseIdentifier: cellIdentifierStr)
//        }
        let cell:UITableViewCell = UITableViewCell.init(style:.subtitle, reuseIdentifier: cellIdentifierStr)
        let nameLable = UILabel.init(frame: CGRect(x:10,y:5,width:300,height:40))
        nameLable.font = UIFont.systemFont(ofSize: 16)
        nameLable.textColor = UIColor.magenta
        cell.contentView.addSubview(nameLable)
        
        nameLable.text = dataArr[indexPath.row] as? String
        cell.backgroundColor = UIColor.brown
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if indexPath.row == 0 {
            
            let jumpToVC = XLP_UI_ViewController()
            self.navigationController?.pushViewController(jumpToVC, animated: true)
            
        }
        if indexPath.row == 1 {
            let jumpToVC = XLP_UI_ViewController()
            self.navigationController?.pushViewController(jumpToVC, animated: true)
        }
        if indexPath.row == 2 {
            let jumpToVC = UI_tableable_VC()
            self.navigationController?.pushViewController(jumpToVC, animated: true)
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
