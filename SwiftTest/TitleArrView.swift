//
//  TitleArrView.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/9.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit


class TitleArrView: UIView {

    var currentItemIndex :Int = 0
    var titleWidthArr = [Float]()
    var titleBtArr = [String]()
    var SelectedTagChang = 1
    
    var backScrollView = UIScrollView()
    var theFont = UIFont.systemFont(ofSize: 13)
    var kPading:CGFloat = 20.0
    
    
    init(frame: CGRect,titleArr:[String]) {
        super.init(frame: frame)
        
        backScrollView.frame = CGRect(x:0,y:0,width:frame.size.width,height:frame.size.height)
        backScrollView.isScrollEnabled = true
        backScrollView.isPagingEnabled = false
        backScrollView.showsHorizontalScrollIndicator = false
        backScrollView.showsVerticalScrollIndicator = false
        self.addSubview(backScrollView)
        
        var buttonX:CGFloat = 0
        
        if titleArr.count > 0 {
            
            
            for titleStr in titleArr {
                
                let titleWidth = kGetSizeOfString(titleStr, font: theFont, maxSize: CGSize(width:kSCREENWIDTH,height:kSCREENHEIGHT)).width
                
                titleWidthArr.append(Float(titleWidth + kPading ))
                buttonX += (titleWidth + kPading)
            }
            
            backScrollView.contentSize = CGSize(width:buttonX,height:frame.size.height)
            
            initButtonWithArr(titleArr)
        }
    
    }

    func initButtonWithArr(_ titleArr:[String]){
    
        var buttonPadding = 0;
        var theOffSet = 0;
//        for (int i = 0; i < titleArr.count; i ++)
//        {
//            NSString *titleStr = titleArr[i];
//            
//            bt = [UIButton buttonWithType:UIButtonTypeCustom];
//            bt.frame = CGRectMake(theOffSet, 0, [titleWidthArr[i] floatValue] + buttonPadding, 44);
//            [bt setTitle:titleStr forState:UIControlStateNormal];
//            [bt setTitleColor:[UIColor colorWithRed:227/255.0f green:226/255.0f blue:227/255.0f alpha:1.0f] forState:UIControlStateNormal];
//            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//            theOffSet +=[titleWidthArr[i] floatValue] + buttonPadding;
//            bt.tag = i + 100;
//            [bt addTarget:self action:@selector(SelectButton:) forControlEvents:UIControlEventTouchUpInside];
//            [self.backScrollView addSubview:bt];
//            [titleBtArr addObject:bt];
//            
//            if (i == 0) {
//                bt.selected = NO;
//            }
//        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
