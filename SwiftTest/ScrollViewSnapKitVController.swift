//
//  ScrollViewSnapKitVController.swift
//  SwiftTest
//
//  Created by lianpeng on 2016/12/22.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
import MJRefresh
class ScrollViewSnapKitVController: XLPBaseViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    let scrollView  = UIScrollView()
//    let contentView = UIView()
    let label = UILabel()
    var label1 = UILabel()
    let label2 = UILabel()
    
    let labelStr = "上的非农数据开放的骄傲啥地方 水电Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqu pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laboa. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor . Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nullarum费圣诞节发顺丰快递是敬爱放水电费水电费水电费"
 
    
    var finalArr = NSMutableArray()
    let rootTableView = UITableView.init(frame: CGRect(x:0,y:0,width:kSCREENWIDTH,height:kSCREENHEIGHT), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //MARK://普通的布局写法
        /*
        view.backgroundColor = UIColor.red
        view.addSubview(scrollView)
        scrollView.frame = CGRect(x:10,y:64,width:200,height:200)
        scrollView.contentSize = CGSize(width:400 ,height:600)
        scrollView.backgroundColor = UIColor.magenta
        /*
        contentView.backgroundColor = UIColor.blue
        scrollView.addSubview(contentView)
        contentView.addSubview(label)
        */
        
        label.numberOfLines = 0
        label.frame = CGRect(x:10,y:20,width:200,height:100)
        //        label.lineBreakMode = .byClipping
        label.textColor = .white
        label.backgroundColor = UIColor.green
        label.text = labelStr
        scrollView.addSubview(label)
        */
 
        //MARK: SnapKit的用法布局scrollview
        
        //MARK:尝试一 暂时没有实现
        /*
        view.backgroundColor = UIColor.red
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.magenta
        
        label.numberOfLines = 0
        //        label.lineBreakMode = .byClipping
        label.textColor = .white
        label.backgroundColor = UIColor.green
        label.text = labelStr
        scrollView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(80)
            make.right.equalTo(-10)
        }
        
 
        scrollView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(self.view)
            make.bottom.equalTo(label.snp.bottom)
            
        }
        */
        
        //MARK:尝试二  创建 一个容器试图 把所有scrollview的子视图放在容器视图里面 
        
        let  containerView = UIView()
        
        view.backgroundColor = UIColor.red
        view.addSubview(scrollView)
        
        scrollView.backgroundColor = UIColor.magenta
        scrollView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(self.view)
            //            make.bottom.equalTo(label.snp.bottom)
            
        }
        
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(kSCREENWIDTH)
        }
        
        
       
        
        /*
         暂时不可以  对象复制对象会出现crash
        var lastLabel = UILabel()
        
        for i in 1...6 {
            
            var label1:UILabel = UILabel()
            label1.numberOfLines = 0
            label1.lineBreakMode = .byClipping
            label1.textColor = .white
            label1.backgroundColor = kRandomColor()
            label1.text = labelStr
            containerView.addSubview(label1)
            
            label1.snp.makeConstraints({ (make) in
                
                if i == 0 {
                    
                    make.left.equalTo(10)
                    make.top.equalTo(80)
                    make.right.equalTo(-10)
                    
                   
                }else {
                    
                    
                    make.left.equalTo(10)
                    make.top.equalTo(lastLabel.snp.bottom).offset(10)
                    make.right.equalTo(-10)
                    
                    if i == 6 {
                        make.bottom.equalTo(containerView).offset(-30)
                    }
//
                }
            })
            
            lastLabel = label1.copy() as! UILabel
            
        }
 
        */
        
        /* 方法二 的写法1
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = .white
        label.backgroundColor = UIColor.green
        label.text = labelStr
        containerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(80)
            make.right.equalTo(-10)
            
        }
        label1.numberOfLines = 0
        label1.lineBreakMode = .byClipping
        label1.textColor = .white
        label1.backgroundColor = UIColor.blue
        label1.text = labelStr
        containerView.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.right.equalTo(-10)
            
        }

        label2.numberOfLines = 0
        label2.lineBreakMode = .byClipping
        label2.textColor = .white
        label2.backgroundColor = UIColor.red
        label2.text = labelStr
        containerView.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(label1.snp.bottom).offset(20)
            make.right.equalTo(-10)
            make.bottom.equalTo(containerView).offset(-30)
            
        }
      */
        
        
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = .white
        label.backgroundColor = UIColor.green
        label.text = labelStr
        containerView.addSubview(label)
        
        
        
//        label1.numberOfLines = 0
//        label1.lineBreakMode = .byClipping
//        label1.textColor = .white
//        label1.backgroundColor = UIColor.blue
//        label1.text = labelStr
//        containerView.addSubview(label1)
        
        WMUIMaker.creatLabel(label:label1 ,text: labelStr, aligenment: .left, fontSize: 16, textColor: .red, backgroundColor: .cyan,superView:containerView)
        
        
        label.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(80)
            make.right.equalTo(label1.snp.left).offset(-10)
            make.width.equalTo(label1)
            
        }
        label1.snp.makeConstraints { (make) in
            
            make.left.equalTo(label.snp.right).offset(10)
            make.top.equalTo(label.snp.top)
            make.right.equalTo(-10)
            
        }
        
        
        label2.numberOfLines = 0
        label2.lineBreakMode = .byClipping
        label2.textColor = .white
        label2.backgroundColor = UIColor.red
        label2.text = labelStr
        containerView.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(label.snp.bottom).offset(20)
            make.right.equalTo(-10)
            make.bottom.equalTo(containerView).offset(0)
            
        }
        
        //////////////
        
                
//        rootTableView.initTableView(delegate: self, superView: containerView)
//        rootTableView.snp.makeConstraints { (make) in
//            make.top.equalTo(label2.snp.bottom).offset(20)
//            make.left.equalTo(0)
//            make.right.equalTo(0)
//            make.height.equalTo(kSCREENHEIGHT)
//            make.bottom.equalTo(containerView).offset(-20)
//        }
//        
//        rootTableView.register(EassyCell.self, forCellReuseIdentifier: "cell")
//        obtainDataWithWMNet()
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? EassyCell
        let modal:EassyModal = finalArr[indexPath.row] as! EassyModal
        cell?.showValueWithModal(modal: modal)
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kSCREENWIDTH/4 + 20
    }

   
    func obtainDataWithWMNet(){
        
        let urlString2 :String = "http://www.iyingdi.com/article/list"
        let paraDic2:[String:Any] = ["module":11,"size":20,"system":"ios","timestamp":0,"version":410]
        WMNetManager.sharedInstance.SucceedGET(urlString2, parameters: paraDic2) { (jsonValue) in
            
            let articlesArr = jsonValue["articles"].array
            for arr in articlesArr!   {
                let modal = EassyModal.init(articleID:arr[0].int!,
                                            moduleID: 11,
                                            replyNum: arr[4].int!,
                                            subClass: arr[17].string!,
                                            thumbnail: arr[7].string!,
                                            timestamp: arr[2].int!,
                                            title: arr[1].string!,
                                            topFlag: arr[9].int!,
                                            author: arr[14].string!,
                                            visitNum: arr[5].int!,
                                            canRead: arr[10].int!,
                                            type: arr[11].int!)
                self.finalArr.add(modal)
            }
            
            DispatchQueue.main.async {
                
                self.rootTableView.reloadData()
            }
            
            
        }

    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
