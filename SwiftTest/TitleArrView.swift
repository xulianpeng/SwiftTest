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
    let theSelectedColor = kRGB(r: 20, g: 53, b: 104, alpha: 1.0) //选中时的颜色
    let theNormalColor = kRGB(r: 20, g: 53, b: 104, alpha: 1.0) //未选中时的颜色
    let theScale:CGFloat = 1.3 //放大的比例
    
    var delegate : TitleArrViewDelegate?
    
    
    private var titleWidthArr = [CGFloat]()
    private var titleBtArr = [UIButton]()
    private var backScrollView = UIScrollView()
    private var theHeight:CGFloat = 0
    private var theWidth:CGFloat = 0
    
    
    init(frame: CGRect,titleArr:[String]) {
        super.init(frame: frame)
        theHeight = frame.size.height
        self.theWidth = frame.size.width
        
        backScrollView.frame = CGRect(x:0,y:0,width:self.self.theWidth,height:theHeight)
        backScrollView.isScrollEnabled = true
        backScrollView.isPagingEnabled = false
        backScrollView.showsHorizontalScrollIndicator = false
        backScrollView.showsVerticalScrollIndicator = false
        self.addSubview(backScrollView)
        
        var buttonX:CGFloat = 0
        
        if titleArr.count > 0 {
            
            
            for titleStr in titleArr {
                
                let titleWidth = kStringGetSize(titleStr, font: kFontWithSize(theFontSize), maxSize: CGSize(width:kSCREENWIDTH,height:kSCREENHEIGHT)).width
                
                titleWidthArr.append(titleWidth + kPading)
                buttonX += (titleWidth + kPading)
            }
            
            backScrollView.contentSize = CGSize(width:buttonX,height:theHeight)
            
            initButtonWithArr(titleArr)
        }
    
    }

    //MARK: 根据标题数组初始化button
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

                if( widthFloat > self.theWidth ){
                    
                    if widthFloat1 > self.theWidth/2,widthFloat2 > self.theWidth/2{
                        
                        
                        let indexWidth = self.titleWidthArr[index]
                        let newArr3:NSArray = arr.subarray(with: NSMakeRange(0, index)) as NSArray
                        let widthFloat3 :CGFloat = newArr3.value(forKeyPath: "@sum.floatValue") as! CGFloat
                        let offset0 = indexWidth/2 + widthFloat3 - self.theWidth/2
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            self.backScrollView.contentOffset = CGPoint(x:offset0,y:0)

                        })
//                        self.backScrollView.setContentOffset(CGPoint(x:offset0,y:0), animated: true)
                        
                    }else{
                        
                        if widthFloat1 < self.theWidth/2{
                            
                            UIView.animate(withDuration: 0.3, animations: {
                                self.backScrollView.contentOffset = CGPoint(x:0,y:0)
                                
                            })
                        }
                        if widthFloat2 < self.theWidth/2{
                            
                            ///所以同一使用此种方法
                            UIView.animate(withDuration: 0.3, animations: {
                                self.backScrollView.contentOffset = CGPoint(x:widthFloat - self.theWidth,y:0)
                                
                            })
                            ///此方法会出现点击两端会出现一定的偏移
//                            self.backScrollView.setContentOffset(CGPoint(x:widthFloat - self.theWidth,y:0), animated: true)
                        }
                    }
                    
                    
                }
                
                //MARK: 选中时 外观变化的处理 字体的大小  颜色 发生变化
                for anyBt in self.titleBtArr{
                    
                    if bt.tag == anyBt.tag{
                        
                        bt.setTitleColor(self.theSelectedColor, for: UIControl.State.normal)
                        
                        UIView.animate(withDuration: 0.2, animations: {
                            bt.transform = CGAffineTransform(scaleX: self.theScale, y: self.theScale)
                        })
                        
                    }else{
                        
                        anyBt.setTitleColor(self.theNormalColor, for: UIControl.State.normal)
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
                
                button.setTitleColor(theSelectedColor, for: UIControl.State.normal)
                UIView.animate(withDuration: 0.2, animations: {
                    button.transform = CGAffineTransform(scaleX: self.theScale, y: self.theScale)
                })
            }
        }
        
    }
    
    //MARK: 关联scrollview 滚动时 改变 其位置
    func setCurrentIndex(_ index:Int)  {
        
        //MARK: 偏移量相关的处理
        let arr = self.titleWidthArr as NSArray
        
        let newArr1:NSArray = arr.subarray(with: NSMakeRange(0, index + 1)) as NSArray
        let newArr2:NSArray = arr.subarray(with: NSMakeRange(index + 1, arr.count - index - 1)) as NSArray
        
        let widthFloat :CGFloat = arr.value(forKeyPath: "@sum.floatValue") as! CGFloat
        let widthFloat1 :CGFloat = newArr1.value(forKeyPath: "@sum.floatValue") as! CGFloat
        let widthFloat2 :CGFloat = newArr2.value(forKeyPath: "@sum.floatValue") as! CGFloat
        
        if( widthFloat > self.theWidth ){
            
            if widthFloat1 > self.theWidth/2,widthFloat2 > self.theWidth/2{
                
                
                let indexWidth = self.titleWidthArr[index]
                let newArr3:NSArray = arr.subarray(with: NSMakeRange(0, index)) as NSArray
                let widthFloat3 :CGFloat = newArr3.value(forKeyPath: "@sum.floatValue") as! CGFloat
                let offset0 = indexWidth/2 + widthFloat3 - self.theWidth/2
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.backScrollView.contentOffset = CGPoint(x:offset0,y:0)
                    
                })
                
            }else{
                
                if widthFloat1 < self.theWidth/2{
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backScrollView.contentOffset = CGPoint(x:0,y:0)
                        
                    })
                }
                if widthFloat2 < self.theWidth/2{
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backScrollView.contentOffset = CGPoint(x:widthFloat - self.theWidth,y:0)
                        
                    })
                }
            }
            
            
        }
        
        //MARK: 选中时 外观变化的处理 字体的大小  颜色 发生变化
        
        let bt = self.titleBtArr[index]
        
        for anyBt in self.titleBtArr{
            
            if bt.tag == anyBt.tag{
                
                bt.setTitleColor(self.theSelectedColor, for: UIControl.State.normal)
                
                UIView.animate(withDuration: 0.2, animations: {
                    bt.transform = CGAffineTransform(scaleX: self.theScale, y: self.theScale)
                })
                
            }else{
                
                anyBt.setTitleColor(self.theNormalColor, for: UIControl.State.normal)
                
                
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
