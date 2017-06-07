//
//  CollectionViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/6/6.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class CollectionViewController: XLPBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var rootCollectionView:UICollectionView?
//        self.view.addSubview(rootCollectionView)
        let aLayout = UICollectionViewFlowLayout.init()
        aLayout.itemSize = CGSize(width:25,height:25)
        aLayout.minimumInteritemSpacing = 30
        aLayout.minimumLineSpacing = 10
        
        var rootCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: aLayout)
        rootCollectionView.collectionViewLayout = aLayout
        
        rootCollectionView.xlpInitView(superView: self.view) { (make) in
            
            make.top.equalTo(64)
            make.left.right.bottom.equalTo(0)
            
        }
        rootCollectionView.delegate = self
        rootCollectionView.dataSource = self
        
//        rootCollectionView.register(CollectionCell.self), forCellWithReuseIdentifier: "CollectionCell")
        rootCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CollectionCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath as IndexPath) as! CollectionCell
//        let sectionArray:NSArray = dataSource.object(at: indexPath.section) as! NSArray
//        let rowDic:NSDictionary = sectionArray.object(at: indexPath.row) as! NSDictionary
        cell.textStr = "\(indexPath.row)"
        return cell;
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
