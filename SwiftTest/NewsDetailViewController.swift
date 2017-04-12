//
//  NewsDetailViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/4/11.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import WebKit
class NewsDetailViewController: XLPBaseViewController {

    var articleID:String?
    var urlStr :String? = nil
    var rootWebView:WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        rootWebView = WKWebView.init(frame: CGRect(x:0,y:64,width:kSCREENWIDTH,height:kSCREENHEIGHT - 64 - 44))
        self.view.addSubview(rootWebView)
        rootWebView.backgroundColor = UIColor.brown
        rootWebView.load(URLRequest.init(url: URL.init(string: urlStr!)!))
        
        let toolItem = UIBarButtonItem.init(title: "评论", style: .done, target: self, action: #selector(jumpToCommentVC))
        self.navigationController?.toolbar.setItems([toolItem], animated: true)
        self.navigationController?.toolbar.isHidden = false

        
        self.navigationItem.setRightBarButton(toolItem, animated: true)
        
    }

    func jumpToCommentVC() {
        
        let vc = NewsCommentVController()
        vc.articleID = self.articleID;
        self.navigationController?.pushViewController(vc, animated: true);
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
