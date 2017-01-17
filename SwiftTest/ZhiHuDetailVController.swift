//
//  ZhiHuDetailVController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/17.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import WebKit

class ZhiHuDetailVController: XLPBaseViewController {

    var detailUrlString = String()
    
    let webView:WKWebView =  WKWebView()
    //http://daily.zhihu.com/story/9155883
    //http://news-at.zhihu.com/api/4/news/9154684"
//    let webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        let request = URLRequest.init(url: URL.init(string: detailUrlString)!)
//        let twoRequest = URLRequest.init(url: URL.init(string: detailUrlString)!, cachePolicy:URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        
        webView.load(request)
        
//        webView.loadRequest(twoRequest)
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
