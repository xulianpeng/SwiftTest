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
        }) { (tap) in
            
        }
        rootWebView.backgroundColor = UIColor.red
        
        adUrl = kUserDefaultsValueString("adDetailUrl")
        if  adUrl != nil || !adUrl!.isEmpty {
            let request = URLRequest.init(url: URL.init(string: adUrl!)!, cachePolicy: NSURLRequest.CachePolicy.reloadRevalidatingCacheData, timeoutInterval: 10)
            rootWebView.load(request)
        }
    }

    func backHandle()  {
        self.dismiss(animated: true, completion: nil)
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
