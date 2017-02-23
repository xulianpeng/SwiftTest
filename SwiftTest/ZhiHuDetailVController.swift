//
//  ZhiHuDetailVController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/17.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import WebKit

class ZhiHuDetailVController: XLPBaseViewController,UIScrollViewDelegate {

    var detailUrlString = String()
    
    private let webView:WKWebView =  WKWebView()
    //http://daily.zhihu.com/story/9155883
    //http://news-at.zhihu.com/api/4/news/9154684"
//    let webView = UIWebView()
    
    private var beginY :Float = 0.0
    private var endY : Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.scrollView.delegate = self
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        let request = URLRequest.init(url: URL.init(string: detailUrlString)!)
//        let twoRequest = URLRequest.init(url: URL.init(string: detailUrlString)!, cachePolicy:URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        
        webView.load(request)
        
//        webView.loadRequest(twoRequest)
        
        var textStr = ""
        let alertView = UIAlertController.init(title: "", message: "我是大帅哥", preferredStyle: .alert)
        self.present(alertView, animated: true, completion: nil)
        alertView.addTextField { (textfield) in
            textfield.placeholder = "崴泥中国"
            textStr =  textfield.text!
        }
        
        alertView.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alertaction) in
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        alertView.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (alertAction) in
            self.dismiss(animated: true, completion: nil)
            
            let text:String = (alertView.textFields?.last?.text)!
            print("lallalalla===\(text)")
        }))
        
        
        
        
        
    }

    //mARK: 隐藏导航栏的代理方法
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if velocity.y > 0.0 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(withDuration: 0.5, animations: {
                self.navigationController?.navigationBar.barTintColor = UIColor.white
                
            })
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: true)

            UIView.animate(withDuration: 1.0, animations: {
                
                self.navigationController?.navigationBar.barTintColor = UIColor.red
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
