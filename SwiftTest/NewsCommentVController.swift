//
//  NewsCommentVController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/4/12.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class NewsCommentVController: XLPBaseViewController {

    public var articleID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtainData()
        

    }

    func obtainData() {
        let url = SERVER_ADDRESS_onLine + "/article/\(articleID!)/comments/common"
        MyManager.sharedInstance.SucceedGET(url, parameters: nil) { (json) in
            
            print(json)
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
