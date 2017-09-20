//
//  myCollectionViewFlowLayout.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/2/21.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

public let horizonallyPadding:CGFloat = 10
public let verticallyPadding:CGFloat = 5

//public let kSCREENWIDTH = UIScreen.main.bounds.size.width
//public let kSCREENHEIGHT = UIScreen.main.bounds.size.height

public let cellWidth = (kSCREENWIDTH - 2 * horizonallyPadding - 10)/3
private let cellHeight:CGFloat = 65

private let SpringFactor:CGFloat = 10.0
class myCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        itemSize = CGSize(width: cellWidth, height: cellHeight)
        headerReferenceSize = CGSize(width: kSCREENWIDTH, height: verticallyPadding)
        sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        minimumInteritemSpacing = 5
        minimumLineSpacing = 5
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        itemSize = CGSize(width: cellWidth, height: cellHeight)
        headerReferenceSize = CGSize(width: kSCREENWIDTH, height: verticallyPadding)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attrsArray = super.layoutAttributesForElements(in: rect)
        
        let offsetY = self.collectionView!.contentOffset.y
        
        let collectionViewFrameHeight = self.collectionView!.frame.size.height;
        let collectionViewContentHeight = self.collectionView!.contentSize.height;
        let ScrollViewContentInsetBottom = self.collectionView!.contentInset.bottom;
        
        let bottomOffset = offsetY + collectionViewFrameHeight - collectionViewContentHeight - ScrollViewContentInsetBottom
        
        let numOfItems = self.collectionView!.numberOfSections
        
        for attr:UICollectionViewLayoutAttributes in attrsArray! {
            if (attr.representedElementCategory == UICollectionElementCategory.cell) {
                var cellRect = attr.frame;
                if offsetY <= 0 {
                    let distance = fabs(offsetY) / SpringFactor;
                    cellRect.origin.y += offsetY + distance * CGFloat(attr.indexPath.section + 1);
                }else if bottomOffset > 0 {
                    let distance = bottomOffset / SpringFactor;
                    cellRect.origin.y += bottomOffset - distance *
                        CGFloat(numOfItems - attr.indexPath.section)
                }
                attr.frame = cellRect;
            }
        }
        return attrsArray;
    }
    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let array = super.layoutAttributesForElements(in: rect)
//        
//        //可视rect
//        var visibleRect:CGRect?
//        visibleRect?.origin = self.collectionView!.contentOffset;
//        visibleRect?.size = self.collectionView!.bounds.size;
//        
//        //设置item的缩放
//        for attributes:UICollectionViewLayoutAttributes in array! {
//            if (attributes.frame.intersects(rect)) {
//                var distance:CGFloat = visibleRect!.midX - attributes.center.x;//item到中心点的距离
//                var normalizedDistance:CGFloat = distance / 100;//距离除以有效距离得到标准化距离
//                //距离小于有效距离才生效
////                NSLog(@"%f",distance);
//                if (abs(distance) < 100) {
//                    var zoom : CGFloat = 1 + 0.5 * (1 - abs(normalizedDistance));//缩放率范围1~1.3,与标准距离负相关
//                    attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);//x,y轴方向变换
//                    //attributes.zIndex = 0;
//                }
//            }
//        }
//        
//        return array;
//    }

}
