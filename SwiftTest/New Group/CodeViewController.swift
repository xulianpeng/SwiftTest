//
//  CodeViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/12/7.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
typealias MCNetworkUtilsBlock = (_ resArr:[String],_ success:Bool) -> Void
class CodeViewController: XLPBaseViewController,CodeViewDelegate {
    func passwordView(textFinished: String) {
        //输入完成 改变背景色
        view.backgroundColor = kRandomColor()
    }
    

    var codeView :CodeView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeView = CodeView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        codeView.center = view.center
        codeView.backgroundColor = UIColor.white

        codeView.delegate = self as CodeViewDelegate
        codeView.maxLength = 10
//        codeView.borderColor = UIColor.cyan
        view.addSubview(codeView)
        
        var strArr:[String] = ["123","345","456","46","679"]
        
//        print(strArr.filter{$0.0,0})
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if codeView.isFirstResponder {
            codeView.resignFirstResponder()
        }
    }

    //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
