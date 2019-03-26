//
//  RootViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/12.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

class RootViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    
    
    var rootTableView : UITableView?
    
    var dataArr:NSMutableArray = NSMutableArray()
    var vcArr = NSMutableArray()
    
    
//    var rootTableView:UITableView = UITableView.init(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT), style: UITableViewStyle.grouped) //在声明时不能调用之前声明的属性,必须在函数中调用才会识别
    
    init(title:String,backColor:UIColor) {
       super.init(nibName: nil, bundle: nil)
        self.title = title
        self.view.backgroundColor = backColor
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        obtainDataArr()
        
    }
    func layoutUI() -> Void {
        rootTableView = UITableView.init(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT), style: .plain)
        rootTableView?.delegate = self
        rootTableView?.dataSource = self
        rootTableView?.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        view.addSubview(rootTableView!)
        
    }
    
    func obtainDataArr() -> Void {

       dataArr = NSMutableArray.init(array: ["UI控件/数据类型Test","基本运算符Tset","TableView自定义Test","对象/属性","函数与闭包","Swift与OC混编","Scrollview与SnapKit的爱情","Swift进阶之路","refresh练习","知乎日报","视频大综合","CoreData封装","获取相册图片","CollectionView的实现","ATUlogin","验证码输入框","泛型"])
        vcArr = NSMutableArray.init(array: [XLP_UI_ViewController(),XLP_OperatorsVController(),UI_tableable_VC(),TestClassViewController(),XLPFuncViewController(),XLPClosuresViewController(),ScrollViewSnapKitVController(),XLP_RealViewController(),RefreshViewController(),ZhiHuNewsViewController(),videoRootViewController(),CoreDataViewController(),CameraViewController(),CollectionViewController(),ATULoginVController(),CodeViewController(),TAllVController()])
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
      
        var jumpToVC = UIViewController()
        if indexPath.row == 0 {
            
            jumpToVC = XLP_UI_ViewController()
//            jumpToVC.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(jumpToVC, animated: true)
            
        }
        if indexPath.row == 1 {
            jumpToVC = XLP_OperatorsVController()
//            self.navigationController?.pushViewController(jumpToVC, animated: true)
        }
        if indexPath.row == 2 {
            jumpToVC = UI_tableable_VC()
//            self.navigationController?.pushViewController(jumpToVC, animated: true)
        }
        if indexPath.row == 3 {
            jumpToVC = TestClassViewController()
//            self.navigationController?.pushViewController(jumpToVC, animated: true)
        }
        if indexPath.row == 4 {
            jumpToVC = XLPFuncViewController()
//            self.navigationController?.pushViewController(jumpToVC, animated: true)
        }
        if indexPath.row == 5 {
            jumpToVC = XLPClosuresViewController()
//            self.navigationController?.pushViewController(jumpToVC, animated: true)
        }
        if indexPath.row == 6 {
            jumpToVC = ScrollViewSnapKitVController()
//            self.navigationController?.pushViewController(jumpToVC, animated: true)
        }
        if indexPath.row == 7 {
            jumpToVC = XLP_RealViewController()
//            self.navigationController?.pushViewController(jumpToVC, animated: true)
        }
        if indexPath.row == 8 {
            jumpToVC = RefreshViewController()
//            self.navigationController?.pushViewController(jumpToVC, animated: true)
        }
        if indexPath.row == 9 {
            jumpToVC = ZhiHuNewsViewController()
//            self.navigationController?.pushViewController(jumpToVC, animated: true)
        }

        
        if indexPath.row == 10 {
            jumpToVC = videoRootViewController()
        }
        if indexPath.row == 11 {
            jumpToVC = CoreDataViewController()
        }
        if indexPath.row == 12 {
            jumpToVC = CameraViewController()
        }
        if indexPath.row == 13 {
            jumpToVC = CollectionViewController()
        }
        if indexPath.row == 14 {
            jumpToVC = ATULoginVController()
        }
        if indexPath.row == 15 {
            jumpToVC = CodeViewController()
        }
        if indexPath.row == 16 {
            jumpToVC = TAllVController()
        }
        jumpToVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(jumpToVC, animated: true)
       
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
