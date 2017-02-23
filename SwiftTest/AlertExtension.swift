//
//  AlertExtension.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/2/22.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit


extension UIAlertController{
    
    
    func initthe() -> Void {
        
//        self = UIAlertController.init(title: "", message: "", preferredStyle: .alert)
//        self.addAction(<#T##action: UIAlertAction##UIAlertAction#>)
    }
}

func initAlert(){
    
    let alertView = UIAlertController.init(title: "", message: "", preferredStyle: .alert)
    alertView.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alertaction) in
        
        alertView.dismiss(animated: true, completion: nil)
    }))
    
    alertView.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (alertAction) in
        alertView.dismiss(animated: true, completion: nil)
        
//        let text:String = (alertView.textFields?.last?.text)!
//        print("lallalalla===\(text)")
    }))

}
