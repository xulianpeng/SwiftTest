//
//  XLPClosuresViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2016/12/16.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD
import Alamofire
import SwiftyJSON
/// swift与oc混编->使用AF实现数据的请求与下载 最终展现出来
class XLPClosuresViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let wmHUD :SVProgressHUD = SVProgressHUD.init()
    var finalArr = NSMutableArray()
    var rootTableView = UITableView()
    
    //MARK:Kingfisher的高级使用 - UITableView的使用
    let contentView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(wmHUD)
        wmHUD.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        wmHUD.isHidden = true
//        obtainDataWithAF()
        obtainDataWithAFire()
        setupUI()
        
        
        
        
    }
    //MARK:布局tableview
    func setupUI() {
        
        /*
        rootTableView = UITableView.init(frame:CGRect(), style: .plain)
        view.addSubview(rootTableView)
        rootTableView.snp.makeConstraints { (make) in
            
//            make.top.equalTo(self.view).offset(64) //无效
            make.edges.equalTo(self.view)

        }
     
        */
        
        rootTableView = UITableView.init(frame: CGRect(x:0,y:64,width:SCREENWIDTH,height:SCREENHEIGHT-64), style: .plain)
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
        
        wmHUD.isHidden = false
        let urlString :String = "http://www.iyingdi.com/article/list"
        let AFManager = AFHTTPSessionManager()
        let paraDic:[String:Any] = ["module":11,"size":20,"system":"ios","timestamp":0,"version":410]
        let myTask :URLSessionDataTask = AFManager.get(urlString, parameters:paraDic, progress: {
            progress in
            //
            
        }, success: { task, response in
            
            self.wmHUD.isHidden = true
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
                
                DispatchQueue.main.async {
                    
                    self.rootTableView.reloadData()
                }
                print(bigArr)
            }
            
            print(dic)
            
            
        }) { (task, error) in
            
            self.wmHUD.isHidden = true
            print(error)
            }!
        
        myTask.resume()
    }
    

    func obtainDataWithAFire() {
        
        let urlString :String = "http://www.iyingdi.com/article/list"
        let paraDic:[String:Any] = ["module":11,"size":20,"system":"ios","timestamp":0,"version":410]
       
        //理解一下链式编程的特点:
        
        ///*
        //方法一:
        
        Alamofire.request(URL.init(string: urlString)!, method: .get,parameters:paraDic).responseJSON(completionHandler: {
            response in
            
            /*
             let parsed = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
             let list = parsed["list"] as! [String:Any]?
             let resources = list?["resources"] as! [AnyObject]?
             let fields = resources?[0] as! [String:Any]?
             let resource = fields?["resource"] as! [String:Any]?
             let fields2 = resource?["fields"] as! [String:Any]?
             let price = fields2?["price"] as! String?
             */
            
//   方法1         let dic :Dictionary = response.result.value as! Dictionary<String, Any>
            //方法2
            
            
            guard let dic:Dictionary = response.result.value as? Dictionary<String, Any> else { return }
            
            
            
            if  dic["success"] as! Bool {
                
                guard let bigArr:[[Any]] = dic["articles"] as? Array else {return}
                
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
                
                DispatchQueue.main.async {
                    
                    self.rootTableView.reloadData()
                }
                
            }else{
                
                
            }
            

            switch response.result {
            case .success(let value):
                print("Value:\(value)")
                print("------")
                let swiftyJsonVar = JSON(value)
                print(swiftyJsonVar)
            case .failure(let error):
                print(error)
            }

            
        })
        
 
        /*
        //方法二:
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: paraDic).response(completionHandler: { (dataResponse) in
                        print(dataResponse)
            //该对象是一个字典: 一共6个键值对{request:URLRequest,response:HTTPURLResponse,data:Data,error:Error,timeline:Alamofire.Timeline,_metrics:AnyObject}
            //显然data是我们想要获取的数据
//            var data:Data = dataResponse.data
//             let parsed = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
        })
        */
        
        /*
        //方法三
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: paraDic).responseData { (data) in
            
            print(data)
            switch data.result {
            case .success(let value):
                print("Value:\(value)")
                print("------")
                let swiftyJsonVar = JSON(value)
                print(swiftyJsonVar)
                
            case .failure(let error):
                print(error)
            }
            
            
        }
        */
        //小结: 以上关于Alamofire的三种相应方式 ,其返回值 data的内容是一样的,该对象是一个字典: 一共6个键值对{request:URLRequest,response:HTTPURLResponse,data:Data,error:Error,timeline:Alamofire.Timeline,_metrics:AnyObject},其中方法一 包括了一个新的 json, 其keY值为reuslt ,通过解析result.value即可获取要解析的数据
    
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
