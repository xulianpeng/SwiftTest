//
//  webTestVController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2018/7/27.
//  Copyright © 2018年 xulianpeng. All rights reserved.
//

import UIKit

class webTestVController: XLPBaseViewController {

    var rootWebView = UIWebView.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(rootWebView)
        rootWebView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let htmlStr:String  = "<DIV class=operatorfont style=\"MARGIN-LEFT: 5px\"><SPAN style='FONT-SIZE: 9pt; FONT-FAMILY: 宋体; mso-font-kerning: 1.0000pt; mso-spacerun: \"yes\"\'><?xml:namespace prefix = \"o\" ns = \"urn:schemas-microsoft-com:office:office\" /><o:p><FONT face=微软雅黑 size=3><!--StartFragment --><DIV>我们11年以来的地址是在：解放碑纽约纽约大厦3.4.5楼（太平洋百货对面金夫人影楼的楼上）。第一次来咨询的顾客，可以先到3楼接待大厅，我们有专业的导诊为您安排咨询服务。</DIV></FONT></o:p></SPAN><!--EndFragment--></DIV>"
        rootWebView.loadHTMLString(htmlStr, baseURL: nil)
        
        let htmlStr1:String  = "<DIV class=operatorfont style=\"MARGIN-LEFT: 5px\"><SPAN style=\'FONT-SIZE: 9pt; FONT-FAMILY: 宋体; mso-font-kerning: 1.0000pt; mso-spacerun: \"yes\"\'><?xml:namespace prefix = \"o\" ns = \"urn:schemas-microsoft-com:office:office\" /><o:p><FONT face=微软雅黑 size=3><!--StartFragment -->\n<DIV>我们11年以来的地址是在：解放碑纽约纽约大厦3.4.5楼（太平洋百货对面金夫人影楼的楼上）。第一次来咨询的顾客，可以先到3楼接待大厅，我们有专业的导诊为您安排咨询服务。</DIV></FONT></o:p></SPAN><!--EndFragment--></DIV>"
        
//         let htmlStr1:String  = "<DIV class=operatorfont style="MARGIN-LEFT: 5px"><SPAN style='FONT-SIZE: 9pt; FONT-FAMILY: 宋体; mso-font-kerning: 1.0000pt; mso-spacerun: "yes"'><?xml:namespace prefix = "o" ns = "urn:schemas-microsoft-com:office:office" /><o:p><FONT face=微软雅黑 size=3><!--StartFragment --><DIV>我们11年以来的地址是在：解放碑纽约纽约大厦3.4.5楼（太平洋百货对面金夫人影楼的楼上）。第一次来咨询的顾客，可以先到3楼接待大厅，我们有专业的导诊为您安排咨询服务。</DIV></FONT></o:p></SPAN><!--EndFragment--></DIV>"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
