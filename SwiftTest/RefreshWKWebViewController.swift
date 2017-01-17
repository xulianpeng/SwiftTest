//
//  RefreshWKWebViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/17.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import WebKit
class RefreshWKWebViewController: XLPBaseViewController,WKNavigationDelegate {

    var url = String()
    var detailWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(detailWebView)
        detailWebView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
            
        }
        let request = URLRequest.init(url: URL.init(string:url)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        detailWebView.load(request)
        detailWebView.navigationDelegate = self
        
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = self.detailWebView.title
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
