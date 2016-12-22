//
//  XLPClosuresViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/16.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
import AFNetworking
/// swift与oc混编->使用AF实现数据的请求与下载 最终展现出来
class XLPClosuresViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var finalArr = NSMutableArray()
    var rootTableView = UITableView()
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        obtainDataWithAF()
        setupUI()
        
        
        
        
    }
    //MARK:布局tableview
    func setupUI() {
        
        rootTableView = UITableView.init(frame: CGRect(x:0,y:0,width:SCREENWIDTH,height:SCREENHEIGHT), style: .plain)
        view.addSubview(rootTableView)
        
        rootTableView.delegate = self
        rootTableView.dataSource = self
        rootTableView .register(EassyCell.self, forCellReuseIdentifier: "cell")
        
        
        
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
        return SCREENWIDTH/4 + 20
    }
    
    //MARK:AF获取数据
    func obtainDataWithAF() -> Void {
        
        // 旅法师营地 "http://www.iyingdi.com/article/list?module=11&size=20&system=ios&timestamp=0&version=410"
        
        let urlString :String = "http://www.iyingdi.com/article/list"
        let AFManager = AFHTTPSessionManager()
        let paraDic:[String:Any] = ["module":11,"size":20,"system":"ios","timestamp":0,"version":410]
        let myTask :URLSessionDataTask = AFManager.get(urlString, parameters:paraDic, progress: {
            progress in
            //
            
        }, success: { task, response in
            
            let dic :Dictionary = response as! Dictionary<String, Any>
            
            
            /*
             还是这个管用
             guard let dict = result as? [String : Any] else { return }
             guard let arr = dict["data"] as? [[String : Any]] else { return }
             
             */
            if  dic["success"] as! Bool {
                
                guard let bigArr:[[Any]] = dic["articles"] as? Array else {return}
                
                
                /*
                 let parsed = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                 let list = parsed["list"] as! [String:Any]?
                 let resources = list?["resources"] as! [AnyObject]?
                 let fields = resources?[0] as! [String:Any]?
                 let resource = fields?["resource"] as! [String:Any]?
                 let fields2 = resource?["fields"] as! [String:Any]?
                 let price = fields2?["price"] as! String?
                 */
                
                for arr in bigArr   {
                    
                    let modal = EassyModal.init(articleID:arr[0] as! Int,
                                                moduleID: 11,
                                                replyNum: arr[4] as! Int,
                                                subClass: arr.last as! String,
                                                thumbnail: arr[7] as! String,
                                                timestamp: arr[2] as! Int,
                                                title: arr[1] as! String,
                                                topFlag: arr[9] as! Int,
                                                author: arr[14] as! String,
                                                visitNum: arr[5] as! Int,
                                                canRead: arr[10] as! Int,
                                                type: arr[11] as! Int)
                    

                    self.finalArr.add(modal)
                }
                
                self.rootTableView.reloadData()
                print(bigArr)
            }
            
            print(dic)
            
            
        }) { (task, error) in
            print(error)
            }!
        
        myTask.resume()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
