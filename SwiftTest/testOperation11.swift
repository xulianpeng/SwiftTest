//
//  testOperation11.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/3.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SwiftyJSON


protocol TestOperationDelegate {
    
     func obtainDataDelegateSuccess(_ json:JSON?)

    
}
class testOperation11: Operation {

    var delegate :TestOperationDelegate?
    
    var url : String
    
    
    init(_ url:String) {
        
        self.url = url
        
    }
    
    override func main(){
    
        if self.isCancelled {
            return
        }
    
        obtainData(self.url)
    
    }
    
    func obtainData(_ url:String) {
        
       print("asdasasd我们的大中国啊 好大的一个家")
        
        MyManager.sharedInstance.SucceedGETFull2(url, parameters: [:]) { (json, error) in
            
            if json != nil{
                
//                let  homeModel = zhiHuControllerModal(json!)
                
//                self.zhiHuTopCellModelArr = homeModel.top_stroies
//                self.zhiHuCellModelArr = homeModel.stroies
//                self.rootTableView.reloadData()
                
                
            self.delegate?.obtainDataDelegateSuccess(json)
                
            }else{
                
                print("===\(error)" )
            }
            
        }

    }
}

class DownADOperation: Operation {
    
    override func main() {
        if self.isCancelled {
            return
        }
        
//        if kUserDefaultsValue("adTime") != nil {
//            
//            kUserDefaults(kTimeGetNow(), key: "adTime")
//            downLoadAD()
//        }else if kTimeGetNow() - kUserDefaultsValueInt("adTime") > 60 {
//            
//            downLoadAD()
//            kUserDefaults(kTimeGetNow(), key: "adTime")
//        }
        
        if kUserDefaultsValue("adTime") != nil {
            
            if kTimeGetNow() - kUserDefaultsValueInt("adTime") > 60 {
                
                downLoadAD()
                kUserDefaults(kTimeGetNow(), key: "adTime")
            }
        }else {
            
            downLoadAD()
            kUserDefaults(kTimeGetNow(), key: "adTime")
        }
    }
    
    func downLoadAD() {
        
        let adUrl = "\(SERVER_ADDRESS_onLine)" + "/ad/bytags"
        let para = ["version":bundleNumber,"system":"ios","position":"startup","client":"ios"]
        MyManager.sharedInstance.SucceedGET(adUrl, parameters: para) { (json) in
            
            if json["success"].bool!{
                
                let dic = json["ad"].dictionary!
                let adImagerUrl = dic["w640H1136"]?.string
                let adDetailUrl = dic["url"]?.string
                
                let updateADTag = (adImagerUrl! as NSString).lastPathComponent
                let oldUpdateADTag = kUserDefaultsValueString("updateADTag")
                
                if   oldUpdateADTag == nil || !oldUpdateADTag!.isEqual(updateADTag) || oldUpdateADTag!.isEmpty {
                    
                    kUserDefaults(0, key: "adTime")
                    kUserDefaults(adDetailUrl!, key: "adDetailUrl")
                    self.saveADToLoacal(adImagerUrl!, detailUrl: adDetailUrl!)
                }else{
                    kUserDefaults(adDetailUrl!, key: "adDetailUrl")

                }
                
            }
            
        }
        
    }
    func saveADToLoacal(_ adUrl:String,detailUrl:String) {
        
        MyManager.sharedInstance.GetData(adUrl, parameters: nil) { (data) in
            
            let path = kCreateDocDirectoryWith("AD");
//            let outPath = kCreateDocDirectoryWith("Card/HearthStone");
            let pathStr = kCreatFileLast("adData", inPath: path)
            
            do {
                try data.write(to: URL.init(fileURLWithPath: pathStr), options: .atomic)
                
            } catch {
                print(error)
            }
            
        }
    }
}
