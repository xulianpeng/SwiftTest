//
//  CoreDataViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/6.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class CoreDataViewController: XLPBaseViewController,UITextFieldDelegate {

    var insertBT = UIButton()
    var deleteBT = UIButton()
    var updateBT = UIButton()
    var findBT = UIButton()
    
    var nameTf = UITextField()
    var idTf = UITextField()
    var sexTf = UITextField()
    var ageTf = UITextField()
    
    var studentDic = [String:String]()
    
    let entityName = "StudentEntity"
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
    }
    func initView()  {
        
        
        
        nameTf.xlpInitTextfieldDefault(XLPRandomColor(), fontSize: 14, placeholder: "姓名", delegate: self, tag:100,superView: self.view) { (make) in
            make.left.equalTo(50)
            make.top.equalTo(100)
            make.right.equalTo(-50)
            make.height.equalTo(50)
        }
       
        idTf.xlpInitTextfieldDefault(XLPRandomColor(), fontSize: 14, placeholder: "id", delegate: self,tag:101, superView: self.view) { (make) in
            make.left.equalTo(nameTf)
            make.top.equalTo(nameTf.snp.bottom).offset(10)
            make.size.equalTo(nameTf)
        }
        
        sexTf.xlpInitTextfieldDefault(XLPRandomColor(), fontSize: 14, placeholder: "性别", delegate: self,tag:102, superView: self.view) { (make) in
            make.left.equalTo(nameTf)
            make.top.equalTo(idTf.snp.bottom).offset(10)
            make.size.equalTo(nameTf)
        }
        
        ageTf.xlpInitTextfieldDefault(XLPRandomColor(), fontSize: 14, placeholder: "年龄", delegate: self,tag:103, superView: self.view) { (make) in
            make.left.equalTo(nameTf)
            make.top.equalTo(sexTf.snp.bottom).offset(10)
            make.size.equalTo(nameTf)
        }
        
        
        xlpCoredataManager1.obtainContext()
        
        insertBT.xlpInitEassyButton("增", titleColor: .yellow, fontSize: 13, backgroundColor: .blue, cornerRedius: 3,superView: self.view
            , snpMaker: { (make) in
                make.left.equalTo(nameTf)
                make.top.equalTo(ageTf.snp.bottom).offset(10)
                make.size.equalTo(nameTf)
        }) { (bt) in
            
            xlpCoredataManager1.insertData(self.entityName, dic: self.studentDic as NSDictionary)
        }
        deleteBT.xlpInitEassyButton("删", titleColor: .yellow, fontSize: 13, backgroundColor: .blue, cornerRedius: 3,superView: self.view
            , snpMaker: { (make) in
                make.left.equalTo(insertBT)
                make.top.equalTo(insertBT.snp.bottom).offset(10)
                make.size.equalTo(insertBT)
        }) { (bt) in
            
            xlpCoredataManager1.deleteData(self.entityName, predicatStr: "name = '你是我的眼'")
        }
        updateBT.xlpInitEassyButton("改", titleColor: .yellow, fontSize: 13, backgroundColor: .blue, cornerRedius: 3,superView: self.view
            , snpMaker: { (make) in
                make.left.equalTo(deleteBT)
                make.top.equalTo(deleteBT.snp.bottom).offset(10)
                make.size.equalTo(insertBT)
        }) { (bt) in
            
            xlpCoredataManager1.updateData(self.entityName, predicatStr: "id=120", newValueDic: ["name":"重中之重123","age":"100"])
        }
        findBT.xlpInitEassyButton("查", titleColor: .yellow, fontSize: 13, backgroundColor: .blue, cornerRedius: 3,superView: self.view
            , snpMaker: { (make) in
                make.left.equalTo(updateBT)
                make.top.equalTo(updateBT.snp.bottom).offset(10)
                make.size.equalTo(updateBT)
        }) { (bt) in
            
//            print("查询结果为====\(xlpCoredataManager1.fetchData(self.entityName))")
            
            let arr:[StudentEntity] = xlpCoredataManager1.fetchData(self.entityName) as! [StudentEntity]
            for mm in arr{
                
                print("查询结果为==\(mm.name,mm.id,mm.sex,mm.age)")
                
            }
        }

        
        
        

        
        
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 100:
             studentDic.updateValue(nameTf.text ?? " ", forKey: "name")
        case 101:
            studentDic.updateValue(idTf.text ?? " ", forKey: "id")
        case 102:
            studentDic.updateValue(sexTf.text ?? " ", forKey: "sex")
        case 103:
            studentDic.updateValue(ageTf.text ?? " ", forKey: "age")
        default: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
