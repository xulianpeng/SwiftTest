//
//  CoreDataViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/6.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class CoreDataViewController: XLPBaseViewController,UITextFieldDelegate,TitleArrViewDelegate,UIScrollViewDelegate {

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
    
    
    var titleView:TitleArrView?
    let backScrollView = UIScrollView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initNavView()
        
    }
    func initView()  {
        
        nameTf.xlpInitTextfieldDefault(KRandomColor(), fontSize: 14, placeholder: "姓名", delegate: self, tag:100,superView: self.view) { (make) in
            make.left.equalTo(50)
            make.top.equalTo(200)
            make.right.equalTo(-50)
            make.height.equalTo(50)
        }
       
        idTf.xlpInitTextfieldDefault(KRandomColor(), fontSize: 14, placeholder: "id", delegate: self,tag:101, superView: self.view) { (make) in
            make.left.equalTo(nameTf)
            make.top.equalTo(nameTf.snp.bottom).offset(10)
            make.size.equalTo(nameTf)
        }
        
        sexTf.xlpInitTextfieldDefault(KRandomColor(), fontSize: 14, placeholder: "性别", delegate: self,tag:102, superView: self.view) { (make) in
            make.left.equalTo(nameTf)
            make.top.equalTo(idTf.snp.bottom).offset(10)
            make.size.equalTo(nameTf)
        }
        
        ageTf.xlpInitTextfieldDefault(KRandomColor(), fontSize: 14, placeholder: "年龄", delegate: self,tag:103, superView: self.view) { (make) in
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
    
    func initNavView() -> Void {
        
        /*
        let bottomView = UIView.init()
        self.view.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.gray
        bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(64)
            make.height.equalTo(50)
        }
        
        let itemView = UIView.init()
        itemView.frame = CGRect(x:0,y:0,width:50,height:50)
        itemView.backgroundColor = UIColor.darkGray
        
        bottomView.addSubview(itemView)
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.initLabel("你好", textColor: .black, fontSize: 13, backgroundColor: .clear, superView: itemView) { (make) in
            make.left.top.equalTo(0)
            make.height.equalTo(45)
            make.width.equalTo(50)
        }
        
        
        let lineLabel = UILabel()
        lineLabel.initLabel("", textColor: nil, fontSize: 12, backgroundColor: .black, superView: itemView) { (make) in
            make.left.equalTo(0)
            make.height.equalTo(3)
            make.width.equalTo(50)
            make.bottom.equalTo(itemView.snp.bottom).offset(-1)
        }
        */
        
        titleView = TitleArrView.init(frame: CGRect(x:0,y:64,width:kSCREENWIDTH,height:60), titleArr: ["资讯","守望","炉石","昆特","游戏王","万智","阵面","电游","手游","皇战","电台","HEX","杂谈"])
        titleView!.backgroundColor = UIColor.brown
        titleView!.delegate = self
        self.view.addSubview(titleView!)
        
        
        
        backScrollView.frame = CGRect(x:0,y:130,width:kSCREENWIDTH,height:100)
        backScrollView.isScrollEnabled = true
        backScrollView.isPagingEnabled = true
        backScrollView.showsHorizontalScrollIndicator = true
        backScrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(backScrollView)
        backScrollView.delegate = self
        backScrollView.contentSize = CGSize(width:kSCREENWIDTH * 13,height:100)
        backScrollView.backgroundColor = UIColor.cyan
        
        for i in 0...12 {
            
            let theRect = CGRect(x:kSCREENWIDTH * CGFloat(i),y:0,width:kSCREENWIDTH,height:100)
            let subView = UIView()
            subView.xlpInitView(frame: theRect, superView: backScrollView, tapBlock: { (tap) in
                
                print("你竟然惦记我啦啦啦啦\(i)")
            })
            subView.backgroundColor = KRandomColor()
            backScrollView.addSubview(subView)
        }
        
        
        
        
    }

    
    /// scrollview的偏移量的 y值必须为0  
    ///
    /// - Parameter index: <#index description#>
    func clickTitleViewAtIndex(_ index: Int) {
        
        let mm = kSCREENWIDTH * CGFloat(index)
        UIView.animate(withDuration: 0.3) { 
            self.backScrollView.contentOffset = CGPoint(x:mm,y:0)

        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        ///如果不+kSCREENWIDTH/2,会出现 变化的太快
        let index:Int = Int(scrollView.contentOffset.x + kSCREENWIDTH/2 ) / Int(kSCREENWIDTH)
        
        titleView?.setCurrentIndex(index)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
