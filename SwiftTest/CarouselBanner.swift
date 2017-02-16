//
//  CarouselBanner.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/2/15.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import Kingfisher
import SDWebImage

/// 第一阶段 实现轮播图
/// 第二阶段 加入定时器 自动轮播 从头到尾
/// 第三阶段 无限循环自动轮播
//could not build objective-c module SDWebImage
class CarouselBanner: UIView,UIScrollViewDelegate {

    //可选类型的 才能将其置为 nil
    var timer:Timer?
    /// 间隔时间
    var time:TimeInterval = 2
    
//    var imageArr = [String]()
    
    /// 是否改变方向
    private var changeDirection:Bool = false
    private var scrollview = UIScrollView.init()
    private var pageControl = UIPageControl.init()
    private var currentIndex = 0
    private var theimageArr:[String] = Array()
    
    
    
    
    //自定义初始化方法
    init(frame: CGRect,imageArr:[String]) {
        super.init(frame: frame)
        
        //本来想写 self.imageArr1 = imageArr ,则提示self.imageArr1 未被初始化
        self.theimageArr = imageArr
        
        //布局UI
        scrollview.frame = CGRect(x:0,y:0,width:frame.size.width,height:frame.size.height)
        scrollview.contentSize = CGSize(width:CGFloat(self.theimageArr.count) * (frame.size.width),height:frame.size.height)
        scrollview.bounces = true
        scrollview.isPagingEnabled = true
        self.addSubview(scrollview)
        
        var i = 0
        for _ in self.theimageArr {
            
            let imageView = UIImageView()
            imageView.frame = CGRect(x:Int(SCREENWIDTH) * i,y:0,width:Int(SCREENWIDTH),height:kTopCellHeight)
            imageView.isUserInteractionEnabled = true
            loadImage(imageView, index: i)
            scrollview.addSubview(imageView)
            i += 1
        }
        
        self.pageControl = UIPageControl(frame: CGRect(x: 0,y: self.bounds.size.height - 30,width: self.bounds.size.width, height: 30))
        self.addSubview(self.pageControl)
        
        scrollview.delegate = self
        
        // 设置页数
        self.pageControl.numberOfPages = self.theimageArr.count
        self.pageControl.currentPage = 0
        self.pageControl.hidesForSinglePage = true
        //初始化定时器
        initTimer()
        
    }
    /// 初始化定时器
    func initTimer() -> (){
        //如果只有一张图片，则直接返回，不开启定时器
        if self.theimageArr.count <= 1 {
            return
        }
        //如果定时器已开启，先停止再重新开启
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: self.time, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: RunLoopMode.commonModes)
        
    }

    func timerFunction() -> Void {
        //动画改变scrollview的偏移量就可以实现自动滚动
        
        if currentIndex < self.theimageArr.count - 1 && !changeDirection {
            
            currentIndex += 1
            scrollview.setContentOffset(CGPoint(x: SCREENWIDTH * CGFloat(currentIndex), y: 0), animated: true)
            if currentIndex == self.theimageArr.count - 1 {
                changeDirection = true
            }
        }else{
            
            currentIndex -= 1
            scrollview.setContentOffset(CGPoint(x: SCREENWIDTH * CGFloat(currentIndex), y: 0), animated: true)
            if currentIndex == 0 {
                changeDirection = false
            }
            
        }
    }
    //MARK:UIScrollView 的 Delegate 方法
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        initTimer()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollview.frame.size.width)
        currentIndex = self.pageControl.currentPage
    }
    
    
    /// 加载图片
    ///
    /// - Parameters:
    ///   - imgView: 将要加载图片的试图
    ///   - index: 坐标
    func loadImage(_ imgView:UIImageView,index:Int) -> Void {
        let imageData = self.theimageArr[index]
        //AF的用法
//            imgView.setImageWith(URL.init(string: imageData)!, placeholderImage: nil)
        //kingfisher的用法
//        let identifier = "CarouselBanner\(index)"
//        let url = URL(string: imageData)!
//        let resource = ImageResource(downloadURL: url, cacheKey: identifier)
//        
//     imgView.kf.setImage(with: resource, placeholder: nil, options:[.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: nil)
     //SDWebImage的用法
        imgView.sd_setImage(with: URL(string: imageData)!, placeholderImage: nil, options: [.retryFailed,.progressiveDownload,.continueInBackground])
        
        
    }
    
    ///貌似没有用这个
    deinit {
        
        print("=====我被销毁了")
        print("asdasdasda======****")
        timer?.invalidate()
        timer = nil
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
