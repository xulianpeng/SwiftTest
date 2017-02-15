//
//  zhiHuTopCell.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/4.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

let kTopCellHeight = 180

class zhiHuTopCell: UITableViewCell {

//    private var privateModel : [zhiHuTopCellModel] = Array()
//
//    var zhiHuTopCellModel :[zhiHuTopCellModel]{
//        
//        get{
//            return privateModel
//        }
//        set{
//            
//            privateModel = newValue
//        }
//    }
    
//    let wheelView = CarouselBanner.init(frame: <#T##CGRect#>, imageArr: <#T##[String]#>)
    
  
    
    
    
    func showWithModals(modals:[zhiHuTopCellModel])  {
        

        var imageArr :[String] = Array()
        for myModal:zhiHuTopCellModel in modals{
            
            imageArr.append(myModal.imgeURL!)
        }
        
        
        let wheelView = CarouselBanner.init(frame: CGRect(x:0,y:0,width:Int(SCREENWIDTH),height:kTopCellHeight), imageArr: imageArr)
        addSubview(wheelView)

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutTheSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutTheSubviews() {
        
//        var imageArr :[String] = Array()
//        for myModal:zhiHuTopCellModel in self.privateModel{
//            
//            imageArr.append(myModal.imgeURL!)
//        }
//        
//        
//        let wheelView = CarouselBanner.init(frame: CGRect(x:0,y:0,width:Int(SCREENWIDTH),height:kTopCellHeight), imageArr: imageArr)
//        addSubview(wheelView)
        
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
