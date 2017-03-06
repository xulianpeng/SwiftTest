//
//  CoreDataViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/6.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class CoreDataViewController: XLPBaseViewController {

    var insertBT = UIButton()
    var deleteBT = UIButton()
    var updateBT = UIButton()
    var findBT = UIButton()
    
    var nameTf = UITextField()
    var idTf = UITextField()
    var sexTf = UITextField()
    var ageTf = UITextField()
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
    }
    func initView()  {
        insertBT.xlpInitEassyButton("增", titleColor: .yellow, fontSize: 13, backgroundColor: .blue, cornerRedius: 3,superView: self.view
            , snpMaker: { (make) in
                make.left.equalTo(100)
                make.top.equalTo(100)
                make.width.equalTo(100)
                make.height.equalTo(50)
        }) { (bt) in
            
        }
        deleteBT.xlpInitEassyButton("删", titleColor: .yellow, fontSize: 13, backgroundColor: .blue, cornerRedius: 3,superView: self.view
            , snpMaker: { (make) in
                make.left.equalTo(insertBT)
                make.top.equalTo(insertBT.snp.bottom).offset(10)
                make.size.equalTo(insertBT)
        }) { (bt) in
            
        }
        updateBT.xlpInitEassyButton("改", titleColor: .yellow, fontSize: 13, backgroundColor: .blue, cornerRedius: 3,superView: self.view
            , snpMaker: { (make) in
                make.left.equalTo(deleteBT)
                make.top.equalTo(deleteBT.snp.bottom).offset(10)
                make.size.equalTo(insertBT)
        }) { (bt) in
            
        }
        findBT.xlpInitEassyButton("改", titleColor: .yellow, fontSize: 13, backgroundColor: .blue, cornerRedius: 3,superView: self.view
            , snpMaker: { (make) in
                make.left.equalTo(updateBT)
                make.top.equalTo(updateBT.snp.bottom).offset(10)
                make.size.equalTo(updateBT)
        }) { (bt) in
            
        }

        
        nameTf.initTextfield(XLPRandomColor(), fontSize: 14, placeholder: "姓名", delegate: self, superView: self.view) { (make) in
            make.left.equalTo(findBT)
            make.top.equalTo(findBT.snp.bottom).offset(10)
            make.size.equalTo(findBT)
        }
        nameTf.borderStyle = .roundedRect
        idTf.initTextfield(XLPRandomColor(), fontSize: 14, placeholder: "id", delegate: self, superView: self.view) { (make) in
            make.left.equalTo(findBT)
            make.top.equalTo(nameTf.snp.bottom).offset(10)
            make.size.equalTo(findBT)
        }
        idTf.borderStyle = .roundedRect
        sexTf.initTextfield(XLPRandomColor(), fontSize: 14, placeholder: "性别", delegate: self, superView: self.view) { (make) in
            make.left.equalTo(findBT)
            make.top.equalTo(idTf.snp.bottom).offset(10)
            make.size.equalTo(findBT)
        }
        sexTf.borderStyle = .roundedRect
        ageTf.initTextfield(XLPRandomColor(), fontSize: 14, placeholder: "年龄", delegate: self, superView: self.view) { (make) in
            make.left.equalTo(findBT)
            make.top.equalTo(sexTf.snp.bottom).offset(10)
            make.size.equalTo(findBT)
        }
        ageTf.borderStyle = .roundedRect
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
