//
//  ShopCityViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/12.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class ShopCityViewController: XLPBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {

//    var myCollectionView:UICollectionView?
//    var myCollectionLayout1 = UICollectionViewLayout()//这个是什么??
    let myCollectionLayout2 = UICollectionViewFlowLayout()
    
    
    let colorArray = NSMutableArray()
    let rowNumber = 15
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        
    }
    func initCollectionView() {
//        let cellNum = 3
//        let mm = 5 * (cellNum - 1)
//        let nn = CGFloat(10 * 2 + mm)
//        let cellWidth = Int(SCREENWIDTH - nn) / cellNum
//        myCollectionLayout2.itemSize = CGSize(width:cellWidth,height:65)  //这个height 就是cell的高度
//        myCollectionLayout2.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10) //上左下右
//        myCollectionLayout2.minimumLineSpacing = 10 //上下item的距离
//        myCollectionLayout2.minimumInteritemSpacing = 5 //item左右的距离
        
        let BGColor = RGB(r: 56, g: 51, b: 76, alpha: 1.0)
        
        let myCollectionView = UICollectionView.init(frame: CGRect(x:0,y:64,width:SCREENWIDTH,height:SCREENHEIGHT - 64), collectionViewLayout: myCollectionViewFlowLayout())
        myCollectionView.register(myCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        myCollectionView.backgroundColor = BGColor
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.alwaysBounceVertical = false
        myCollectionView.contentInset = UIEdgeInsetsMake(0, 0, verticallyPadding, 0);
        self.view.addSubview(myCollectionView)
        
//        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
//        myCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
        let random = arc4random() % 360 // 160 arc4random() % 360
        for index in 0 ..< rowNumber {
            let color = UIColor(hue: CGFloat((Int(random) + index * 6)).truncatingRemainder(dividingBy: 360.0) / 360.0, saturation: 0.8, brightness: 1.0, alpha: 1.0)
            colorArray.add(color)
        }

        
    }
    //
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width:SCREENWIDTH,height:15)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        <#code#>
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        <#code#>
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        <#code#>
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        
//        return CGSize(width:SCREENWIDTH,height:15)
//    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:myCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCollectionViewCell
        
        
//         let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = "大标题\(indexPath.section)"
//        cell.littleTitleLabel.text = "小标题\(indexPath.row)小标题啊"
        cell.backgroundColor = colorArray.object(at: colorArray.count - 1 - (indexPath as NSIndexPath).section) as? UIColor
//        cell.titleLabel.alpha = 0.0
//        cell.littleTitleLabel.alpha = 0.0
//        cell.backButton.alpha = 0.0
        cell.tag = (indexPath as NSIndexPath).section
        cell.layer.cornerRadius = 5
        return cell
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

}
