//
//  ADDetailVController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/4/18.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import WebKit
class ADDetailVController: XLPBaseViewController {

    var rootWebView = WKWebView.init()
    public var adUrl:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftItem = UIBarButtonItem.init(title: "返回", style: .done, target: self, action: #selector(backHandle))
        self.navigationItem.setLeftBarButton(leftItem, animated: true)

        rootWebView.xlpInitView(superView: self.view, snpMaker: { (make) in
//            make.edges.equalTo(self.view)
            make.top.equalTo(64)
            make.left.right.bottom.equalTo(self.view)
        })
        rootWebView.backgroundColor = UIColor.red
        
        adUrl = kUserDefaultsValueString("adDetailUrl")
        if  adUrl != nil || !adUrl!.isEmpty {
            
            let url:URL =  URL.init(string: adUrl!)!
            var bool = false
            do {
                try? bool =  url.checkResourceIsReachable()
            } catch  {
                print("拉拉阿拉  网址不可用啊")
            }
            //
            //
            //
           
            if checkUrl(adUrl!) {
                
                let request = URLRequest.init(url: URL.init(string: adUrl!)!, cachePolicy: NSURLRequest.CachePolicy.reloadRevalidatingCacheData, timeoutInterval: 10)
                rootWebView.load(request)
            }
        }
    }

    func checkUrl(_ str:String) -> Bool {
        var bool = false
        
        let resultStr = str.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if resultStr != nil {
            
            if (resultStr.range(of: "://") != nil) {
                
                bool = true
            }
        }
        
        return bool
        
    }
    func backHandle()  {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
