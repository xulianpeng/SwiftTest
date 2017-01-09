//
//  RefreshDetailViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/5.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SVProgressHUD
class RefreshDetailViewController: XLPBaseViewController,UIWebViewDelegate {

    var url = String()
    var detailWebView = UIWebView()
    var customHUD = SVProgressHUD.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(detailWebView)
        detailWebView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
            
        }
        let request = URLRequest.init(url: URL.init(string:url)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        detailWebView.loadRequest(request)
        detailWebView.delegate = self
        
        //MARK: 手势
        view.isUserInteractionEnabled = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:#selector(tapGestureHandle))
        tap.numberOfTapsRequired = 1
//        tap.delegate = self
        view.addGestureRecognizer(tap)
    }

    func tapGestureHandle(tap:UITapGestureRecognizer) -> Void {
        print("==============点我点位我单啊啊啊啊啊")
        self.navigationController?.popViewController(animated: true)
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show(withStatus: "正在加载")
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        SVProgressHUD.dismiss()
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
