//
//  WheelBanner.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/2/15.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SDWebImage
//图片轮播组件代理协议
protocol WheelBannerViewDelegate{
    //获取数据源
    func handleTapAction(index:Int)->Void
}

//图片轮播组件控制器
class WheelBannerView: UIView,UIScrollViewDelegate{
    //代理对象
    var delegate : WheelBannerViewDelegate!
    
    //屏幕宽度
    let kkSCREENWIDTH = kSCREENWIDTH
    
    //当前展示的图片索引
    var currentIndex : Int = 0
    
    //数据源
    var dataSource : [String]?
    
    //用于轮播的左中右三个image（不管几张图片都是这三个imageView交替使用）
//    var leftImageView , middleImageView , rightImageView : UIImageView?
    
    var leftImageView = UIImageView()
    var middleImageView = UIImageView()
    var rightImageView = UIImageView()
    //放置imageView的滚动视图
    var scrollerView : UIScrollView?
    
    //scrollView的宽和高
    var scrollerViewWidth : CGFloat?
    var scrollerViewHeight : CGFloat?
    
    //页控制器（小圆点）
    var pageControl : UIPageControl?
    
    //自动滚动计时器
    var autoScrollTimer:Timer?
    

    
    /// 子定义轮播图
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - ImagesArr: 图片网址数组
    init(frame: CGRect, ImagesArr:[String]) {
        super.init(frame: frame)
        
        //获取并设置scrollerView尺寸
        self.scrollerViewWidth = frame.width
        self.scrollerViewHeight = frame.height
        
        //获取数据
        self.dataSource =  ImagesArr
        //设置scrollerView
        self.configureScrollerView()
        //设置imageView
        self.configureImageView()
        //设置页控制器
        self.configurePageController()
        if ImagesArr.count > 1 {
            //设置自动滚动计时器
            self.configureAutoScrollTimer()
        }else{
            self.scrollerView?.isScrollEnabled = false
        }
        self.backgroundColor = UIColor.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置scrollerView
    func configureScrollerView(){
        self.scrollerView = UIScrollView(frame: CGRect(x: 0,y: 0,
                                                       width: self.scrollerViewWidth!, height: self.scrollerViewHeight!))
        self.scrollerView?.delegate = self
        self.scrollerView?.contentSize = CGSize(width: self.scrollerViewWidth! * 3,
                                                height: self.scrollerViewHeight!)
        
        
        self.scrollerView?.isPagingEnabled = true
        self.scrollerView?.bounces = false
        self.addSubview(self.scrollerView!)
        
        //滚动视图内容区域向左偏移一个view的宽度
        self.scrollerView?.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
    }
    //设置imageView
    func configureImageView(){
        self.leftImageView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                       width: self.scrollerViewWidth!, height: self.scrollerViewHeight!))
        self.middleImageView = UIImageView(frame: CGRect(x: self.scrollerViewWidth!, y: 0,
                                                         width: self.scrollerViewWidth!, height: self.scrollerViewHeight! ));
        self.rightImageView = UIImageView(frame: CGRect(x: 2*self.scrollerViewWidth!, y: 0,
                                                        width: self.scrollerViewWidth!, height: self.scrollerViewHeight!));
        self.scrollerView?.showsHorizontalScrollIndicator = false
        
        //设置初始时左中右三个imageView的图片（分别时数据源中最后一张，第一张，第二张图片）
        if(self.dataSource?.count != 0){
            self.touchViewAction()
            resetImageViewSource()
        }else{
            // 如果没有图片，站位图
            self.middleImageView.image = UIImage(named: "img_05")
        }
        
        self.scrollerView?.addSubview(self.leftImageView)
        self.scrollerView?.addSubview(self.middleImageView)
        self.scrollerView?.addSubview(self.rightImageView)
    }
    
    //设置页控制器
    func configurePageController() {
        self.pageControl = UIPageControl(frame: CGRect(x: kkSCREENWIDTH/2-60,
                                                       y: self.scrollerViewHeight! - 20, width: 120, height: 20))
        self.pageControl?.numberOfPages = (self.dataSource?.count)!
        self.pageControl?.isUserInteractionEnabled = false
        self.addSubview(self.pageControl!)
    }
    
    //设置自动滚动计时器
    func configureAutoScrollTimer() {
        
        //设置一个定时器，每三秒钟滚动一次
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3, target: self,
                                               selector: #selector(letItScroll),
                                               userInfo: nil, repeats: true)
        
        RunLoop.main.add(autoScrollTimer!, forMode: RunLoop.Mode.common)
    }
    
    //计时器时间一到，滚动一张图片
    @objc func letItScroll(){
        let offset = CGPoint(x: 2*scrollerViewWidth!, y: 0)
        self.scrollerView?.setContentOffset(offset, animated: true)
    }
    
    //每当滚动后重新设置各个imageView的图片
    func resetImageViewSource() {
        //当前显示的是第一张图片
        if self.currentIndex == 0 {
//            self.leftImageView?.image = UIImage(named: self.dataSource!.last!)
//            self.middleImageView?.image = UIImage(named: self.dataSource!.first!)
//            let rightImageIndex = (self.dataSource?.count)!>1 ? 1 : 0 //保护
//            self.rightImageView?.image = UIImage(named: self.dataSource![rightImageIndex])
            
            loadImage(self.leftImageView, index: (dataSource?.count)! - 1)
            loadImage(middleImageView, index: 0)
            let rightImageIndex = (self.dataSource?.count)!>1 ? 1 : 0
            loadImage(rightImageView, index: rightImageIndex)
            
        }
            //当前显示的是最好一张图片
        else if self.currentIndex == (self.dataSource?.count)! - 1 {
            
//            self.leftImageView?.image = UIImage(named: self.dataSource![self.currentIndex-1])
//            self.middleImageView?.image = UIImage(named: self.dataSource!.last!)
//            self.rightImageView?.image = UIImage(named: self.dataSource!.first!)
            
            loadImage(leftImageView, index: self.currentIndex-1)
            loadImage(middleImageView, index: (dataSource?.count)! - 1)
            loadImage(rightImageView, index: 0)
        }
            //其他情况
        else{
//            self.leftImageView?.image = UIImage(named: self.dataSource![self.currentIndex-1])
//            self.middleImageView?.image = UIImage(named: self.dataSource![self.currentIndex])
//            self.rightImageView?.image = UIImage(named: self.dataSource![self.currentIndex+1])
            loadImage(leftImageView, index: self.currentIndex-1)
            loadImage(middleImageView, index: self.currentIndex)
            loadImage(rightImageView, index: self.currentIndex+1)
        }
    }
    
    func loadImage(_ imgView:UIImageView,index:Int) {
        
        let url:URL = URL(string:self.dataSource![index])!
        imgView.sd_setImage(with:url, placeholderImage: nil, options: [.retryFailed,.avoidAutoSetImage,.progressiveDownload])
       
    }
    
    func touchViewAction(){
        //添加组件的点击事件
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(handleTapAction(_:)))
        self.addGestureRecognizer(tap)
    }
    //点击事件响应
    @objc func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        
        self.delegate.handleTapAction(index: self.currentIndex)
    }
    
    
    //scrollView滚动完毕后触发
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取当前偏移量
        let offset = scrollView.contentOffset.x
        
        if(self.dataSource?.count != 0){
            
            //如果向左滑动（显示下一张）
            if(offset >= self.scrollerViewWidth!*2){
                //还原偏移量
                scrollView.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
                //视图索引+1
                self.currentIndex = self.currentIndex + 1
                
                if self.currentIndex == self.dataSource?.count {
                    self.currentIndex = 0
                }
            }
            
            //如果向右滑动（显示上一张）
            if(offset <= 0){
                //还原偏移量
                scrollView.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
                //视图索引-1
                self.currentIndex = self.currentIndex - 1
                
                if self.currentIndex == -1 {
                    self.currentIndex = (self.dataSource?.count)! - 1
                }
            }
            
            //重新设置各个imageView的图片
            resetImageViewSource()
            //设置页控制器当前页码
            self.pageControl?.currentPage = self.currentIndex
        }
    }
    
    //手动拖拽滚动开始
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //使自动滚动计时器失效（防止用户手动移动图片的时候这边也在自动滚动）
        autoScrollTimer?.invalidate()
    }
    
    //手动拖拽滚动结束
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        //重新启动自动滚动计时器
        configureAutoScrollTimer()
        
    }
    
}
