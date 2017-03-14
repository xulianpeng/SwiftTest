//
//  TitleArrView.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/9.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit


protocol TitleArrViewDelegate {
    
    func clickTitleViewAtIndex(_ index:Int) -> Void
}

class TitleArrView: UIView {

    var theFontSize:CGFloat = 13 //字体大小
    var kPading:CGFloat = 20.0   //间隔
    let theSelectedColor = UIColor.red //选中时的颜色
    let theNormalColor = kRGB(r: 144, g: 211, b: 247, alpha: 1.0) //未选中时的颜色
    let theScale:CGFloat = 1.3 //放大的比例
    
    var delegate : TitleArrViewDelegate?
    
    
    private var titleWidthArr = [CGFloat]()
    private var titleBtArr = [UIButton]()
    private var backScrollView = UIScrollView()
    private var theHeight:CGFloat = 0
    
    
    
    init(frame: CGRect,titleArr:[String]) {
        super.init(frame: frame)
        theHeight = frame.size.height
        backScrollView.frame = CGRect(x:0,y:0,width:frame.size.width,height:theHeight)
        backScrollView.isScrollEnabled = true
        backScrollView.isPagingEnabled = false
        backScrollView.showsHorizontalScrollIndicator = false
        backScrollView.showsVerticalScrollIndicator = false
        self.addSubview(backScrollView)
        
        var buttonX:CGFloat = 0
        
        if titleArr.count > 0 {
            
            
            for titleStr in titleArr {
                
                let titleWidth = kGetSizeOfString(titleStr, font: kFontWithSize(theFontSize), maxSize: CGSize(width:kSCREENWIDTH,height:kSCREENHEIGHT)).width
                
                titleWidthArr.append(titleWidth + kPading)
                buttonX += (titleWidth + kPading)
            }
            
            backScrollView.contentSize = CGSize(width:buttonX,height:theHeight)
            
            initButtonWithArr(titleArr)
        }
    
    }

    func initButtonWithArr(_ titleArr:[String]){
    
        let buttonPadding:CGFloat = 0;
        var theOffSet :CGFloat = 0;
        
        for (index,title) in titleArr.enumerated() {
            
            let button = UIButton()
            button.xlpInitFinalButtonFrame(CGRect(x:theOffSet,y:0,width:titleWidthArr[index] + buttonPadding,height:theHeight), title: title, titleColor: theNormalColor, fontSize: theFontSize, superView: backScrollView, buttonClick: { (bt) in
                
                //MARK: 偏移量相关的处理
                let arr = self.titleWidthArr as NSArray
                
                let newArr1:NSArray = arr.subarray(with: NSMakeRange(0, index + 1)) as NSArray
                let newArr2:NSArray = arr.subarray(with: NSMakeRange(index + 1, arr.count - index - 1)) as NSArray

                let widthFloat :CGFloat = arr.value(forKeyPath: "@sum.floatValue") as! CGFloat
                let widthFloat1 :CGFloat = newArr1.value(forKeyPath: "@sum.floatValue") as! CGFloat
                let widthFloat2 :CGFloat = newArr2.value(forKeyPath: "@sum.floatValue") as! CGFloat

                if( widthFloat > kSCREENWIDTH ){
                    
                    if widthFloat1 > kSCREENWIDTH/2,widthFloat2 > kSCREENWIDTH/2{
                        
                        
                        let indexWidth = self.titleWidthArr[index]
                        let newArr3:NSArray = arr.subarray(with: NSMakeRange(0, index)) as NSArray
                        let widthFloat3 :CGFloat = newArr3.value(forKeyPath: "@sum.floatValue") as! CGFloat
                        let offset0 = indexWidth/2 + widthFloat3 - kSCREENWIDTH/2
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            self.backScrollView.contentOffset = CGPoint(x:offset0,y:0)

                        })
                        
                    }else{
                        
                        if widthFloat1 < kSCREENWIDTH/2{
                            
                            UIView.animate(withDuration: 0.3, animations: {
                                self.backScrollView.contentOffset = CGPoint(x:0,y:0)
                                
                            })
                        }
                        if widthFloat2 < kSCREENWIDTH/2{
                            
                            UIView.animate(withDuration: 0.3, animations: {
                                self.backScrollView.contentOffset = CGPoint(x:widthFloat - kSCREENWIDTH,y:0)
                                
                            })
                        }
                    }
                    
                    
                }
                
                //MARK: 选中时 外观变化的处理 字体的大小  颜色 发生变化
                for anyBt in self.titleBtArr{
                    
                    if bt.tag == anyBt.tag{
                        
                        bt.setTitleColor(self.theSelectedColor, for: UIControlState.normal)
                        
                        UIView.animate(withDuration: 0.2, animations: {
                            bt.transform = CGAffineTransform(scaleX: self.theScale, y: self.theScale)
                        })
                        
                    }else{
                        
                        anyBt.setTitleColor(self.theNormalColor, for: UIControlState.normal)
                        UIView.animate(withDuration: 0.2, animations: {
                            anyBt.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        })
                        
                    }
                }

                //同时 关联的 scrollview也要偏移到对应的 页面
                 self.delegate?.clickTitleViewAtIndex(index)
                
                
                
            })
            
            theOffSet += titleWidthArr[index] + buttonPadding
            button.tag = index + 100
            titleBtArr.append(button)
            
            if (index == 0) {
                
                button.setTitleColor(theSelectedColor, for: UIControlState.normal)
                UIView.animate(withDuration: 0.2, animations: {
                    button.transform = CGAffineTransform(scaleX: self.theScale, y: self.theScale)
                })
            }
        }
        
    }
    
    func setCurrentIndex(_ index:Int)  {
        
        //MARK: 偏移量相关的处理
        let arr = self.titleWidthArr as NSArray
        
        let newArr1:NSArray = arr.subarray(with: NSMakeRange(0, index + 1)) as NSArray
        let newArr2:NSArray = arr.subarray(with: NSMakeRange(index + 1, arr.count - index - 1)) as NSArray
        
        let widthFloat :CGFloat = arr.value(forKeyPath: "@sum.floatValue") as! CGFloat
        let widthFloat1 :CGFloat = newArr1.value(forKeyPath: "@sum.floatValue") as! CGFloat
        let widthFloat2 :CGFloat = newArr2.value(forKeyPath: "@sum.floatValue") as! CGFloat
        
        if( widthFloat > kSCREENWIDTH ){
            
            if widthFloat1 > kSCREENWIDTH/2,widthFloat2 > kSCREENWIDTH/2{
                
                
                let indexWidth = self.titleWidthArr[index]
                let newArr3:NSArray = arr.subarray(with: NSMakeRange(0, index)) as NSArray
                let widthFloat3 :CGFloat = newArr3.value(forKeyPath: "@sum.floatValue") as! CGFloat
                let offset0 = indexWidth/2 + widthFloat3 - kSCREENWIDTH/2
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.backScrollView.contentOffset = CGPoint(x:offset0,y:0)
                    
                })
                
            }else{
                
                if widthFloat1 < kSCREENWIDTH/2{
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backScrollView.contentOffset = CGPoint(x:0,y:0)
                        
                    })
                }
                if widthFloat2 < kSCREENWIDTH/2{
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backScrollView.contentOffset = CGPoint(x:widthFloat - kSCREENWIDTH,y:0)
                        
                    })
                }
            }
            
            
        }
        
        //MARK: 选中时 外观变化的处理 字体的大小  颜色 发生变化
        
        let bt = self.titleBtArr[index]
        
        for anyBt in self.titleBtArr{
            
            if bt.tag == anyBt.tag{
                
                bt.setTitleColor(self.theSelectedColor, for: UIControlState.normal)
                
                UIView.animate(withDuration: 0.2, animations: {
                    bt.transform = CGAffineTransform(scaleX: self.theScale, y: self.theScale)
                })
                
            }else{
                
                anyBt.setTitleColor(self.theNormalColor, for: UIControlState.normal)
                
                
                UIView.animate(withDuration: 0.2, animations: {
                    anyBt.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }

        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
