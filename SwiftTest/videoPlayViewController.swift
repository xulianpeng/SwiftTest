//
//  videoPlayViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/10.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import MediaPlayer
//import DWMoviePlayerController

class videoPlayViewController: XLPBaseViewController,UIGestureRecognizerDelegate {

    let url = NSURL.init(string: "http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4")
    
    let backScrollView = UIScrollView()
    let containView = UIView()
    
    
    var playerVC1 = MPMoviePlayerController()
    let notificationCenter = NotificationCenter.default
    
    var topView = UIView()
    
    var swipBrightnessLeft = UISwipeGestureRecognizer()
    var swipBrightnessRight = UISwipeGestureRecognizer()
    
    var swipVolumeUp = UISwipeGestureRecognizer()
    var swipVolumeDown = UISwipeGestureRecognizer()
    
    var volumeView = MPVolumeView()
    var volumeSlider = UISlider()
    
    
    //MARk: 坑点,若是使用系统手势平移返回  但是没返回 还是在这个页面的话 播放界面会消失  只走viewWillAppear
    // 暂时的解决思路时  判断是否平移手势未成功  未成功时  则直接在 viewWillAppear里调用 初始化播放器的方法
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
 
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        //MARK: 坑点 导航栏的透明度设置为0 时,返回功能失效
        self.navigationController?.navigationBar.alpha = 0.0
//        self.navigationController?.hidesBarsOnSwipe = true
        //MARK: 模仿腾讯视频播放界面
        initBackScrollView()
        
        initMPMoviePlayer()
        //给palyer添加通知 监控其各种状态的变化
        addNoticeForPlayer()
        
        //截图
        obtainThunailImage()
        
        //调节系统音量
        
        //初始化音量条
        
        topView.addSubview(volumeView)
        volumeView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(3)
            make.centerX.equalTo(topView.snp.centerX)
        }
        volumeView.showsVolumeSlider = true
        
        for var aView in volumeView.subviews {
            
            if aView.description.contains("MPVolumeSlider") {
                
                self.volumeSlider = aView as! UISlider
                break
            }

        }
        
        
        let MySlider = UISlider()
        topView.addSubview(MySlider)
        MySlider.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(10)
            make.centerY.equalTo(topView.snp.centerY)
        }
        
        (volumeView.subviews[0] as! UISlider).setValue(1.0, animated: false)
//        self.volumeSlider.setValue(0.0, animated: true)
//        MySlider.value = self.volumeSlider.value
        
        MySlider.minimumValue = 0.0
        MySlider.maximumValue = 1.0
        MySlider.backgroundColor = .blue
//        MySlider.transform.rotated(by:CGFloat(-M_PI/2))
        
//        MySlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI/2))
        
        
        
        
        
        
//        volumeView.userActivity
        
        swipVolumeUp = UISwipeGestureRecognizer.init(target: self, action: #selector(adjustVolumeUp(gesture:)))
        swipVolumeUp.direction = UISwipeGestureRecognizerDirection.left
        swipVolumeUp.numberOfTouchesRequired = 1
        swipVolumeUp.delegate = self
        topView.addGestureRecognizer(swipVolumeUp)
        
        swipVolumeDown = UISwipeGestureRecognizer.init(target: self, action: #selector(adjustVolumeDown(gesture:)))
        swipVolumeDown.direction = UISwipeGestureRecognizerDirection.right
        swipVolumeDown.numberOfTouchesRequired = 1
        swipVolumeDown.delegate = self
        topView.addGestureRecognizer(swipVolumeDown)
        
        
        MySlider.addGestureRecognizer(swipVolumeUp)
        MySlider.addGestureRecognizer(swipVolumeDown)
        //调节系统亮度
        
        swipBrightnessLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(adjustBrightnessLeft(gesture:)))
        swipBrightnessLeft.direction = UISwipeGestureRecognizerDirection.left
        swipBrightnessLeft.numberOfTouchesRequired = 1
        swipBrightnessLeft.delegate = self
        topView.addGestureRecognizer(swipBrightnessLeft)
        
        swipBrightnessRight = UISwipeGestureRecognizer.init(target: self, action: #selector(adjustBrightnessRight(gesture:)))
        swipBrightnessRight.direction = UISwipeGestureRecognizerDirection.right
        swipBrightnessRight.numberOfTouchesRequired = 1
        swipBrightnessRight.delegate = self
        topView.addGestureRecognizer(swipBrightnessRight)
        
        
    }
    
    func initBackScrollView() {
        
        
    }
    func initMPMoviePlayer() {
        
        
        
        
        
        
        // 坑点之一 playerVC1 必须是全局的 变量  否则 不会播放
        self.playerVC1 = MPMoviePlayerController.init(contentURL: self.url! as URL!)
        self.view.addSubview((self.playerVC1.view)!)
//        self.playerVC1.view.frame = CGRect(x:0,y:64,width:SCREENWIDTH,height:SCREENWIDTH * 9 / 16)
        let theHeight = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        print(theHeight)
        self.playerVC1.view.snp.makeConstraints { (make) in
            
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(SCREENWIDTH * 9 / 16)
        }
        
        self.playerVC1.controlStyle = .embedded//embedded,fullscreen,none,default
        //显示播放 按钮  快进 快退 全屏等
        //fullscreen  分上下两部分 上面是 完成按钮  进度条  下面是 快退 播放 快进 三个按钮 ,其中 点完成时 播放暂停 , 点快进或快退时,若无视频队列 则会黑屏
        //none时 相关的控制按钮 进度条 全部没有
        //default 同 embedded
        //embedded 播放按钮  进度条 还有个类似全屏的按钮 但是 一点击 先放大但画面消失 声音还在 ->这个当palyer放在 push的另一个视图时,没有问题,点击放大 效果为MPMoviePlayerViewController.
        
        self.playerVC1.scalingMode = .none
        
        //aspectFit  成比例缩放 上下部分 会有部分黑屏
        //aspectFill / fill/none  全屏填充
        self.playerVC1.shouldAutoplay = true
        self.playerVC1.repeatMode = .one
        self.playerVC1.prepareToPlay()
        
        //MARK: 改变播放速率  float  0 暂停  1 正常播放  2 是2倍速率
        self.playerVC1.currentPlaybackRate = 2.0
        
        self.playerVC1.play()
        
        //MARK: 在player上面 放一个view 然后对视频的各种控制 添加到 topView上面
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.playerVC1.view)
            make.bottom.equalTo(self.playerVC1.view.snp.bottom).offset(-100)
        }
        topView.backgroundColor = .red
        topView.alpha = 0.5
        
    }
    
    func addNoticeForPlayer() {
       
        
        notificationCenter.addObserver(self, selector: #selector(mediaPlayerPlaybackStateChange), name: NSNotification.Name.MPMoviePlayerPlaybackStateDidChange, object: self.playerVC1)
        notificationCenter.addObserver(self, selector: #selector(mediaPlayerPlaybackFinished), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: self.playerVC1)
        notificationCenter.addObserver(self, selector: #selector(mediaPlayerThumbnailRequestFinished), name: NSNotification.Name.MPMoviePlayerThumbnailImageRequestDidFinish, object: self.playerVC1)
        
        notificationCenter.addObserver(self, selector: #selector(mediaPlayerThumbnailRequestFinished), name: NSNotification.Name.MPMoviePlayerDidEnterFullscreen, object: self.playerVC1)
        
        
//         notificationCenter.addObserver(self, selector: #selector(mediaPlayerThumbnailRequestFinished), name: NSNotification.Name.MPMoviePlaybackStateSeekingBackward, object: self.playerVC1)
        /**
         MPVolumeViewWirelessRouteActiveDidChange
         MPVolumeViewWirelessRoutesAvailableDidChange
         
         MPMoviePlayerTimedMetadataUpdated
         MPMoviePlayerNowPlayingMovieDidChange
         MPMoviePlayerWillExitFullscreen
         MPMoviePlayerWillEnterFullscreen
         MPMoviePlayerDidExitFullscreen
         MPMoviePlayerDidEnterFullscreen
         **/
    }
    
    func mediaPlayerPlaybackStateChange(notification:Notification){
        
        print("视频播放状态改变了")
        switch (self.playerVC1.playbackState) {
        case .playing:
            print("正在播放...");
            
        case .paused:
            print("暂停播放.");
         
        case .stopped:
            print("停止播放.");
            
        case .seekingForward:
            print("快进")
            
        case.seekingBackward:
            print("快退")
            
        default:
            print("播放状态:%li",self.playerVC1.playbackState);
            
        }
    }
    func mediaPlayerPlaybackFinished(notification:Notification){
        
        print("视频播放完成")
    }

    
    func mediaPlayerThumbnailRequestFinished(notification:Notification){
        
        let userinfoAny = notification.userInfo
        
        print("视频截图完成.======\(notification.userInfo?[MPMoviePlayerThumbnailErrorKey])====userinfo\(userinfoAny?[1])====\(notification)")
        let image = notification.userInfo?[MPMoviePlayerThumbnailImageKey];
        //保存图片到相册(首次调用会请求用户获得访问相册权限)
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(image as! UIImage, nil, nil, nil);
        }
        
    }

    
    func obtainThunailImage()  {
      
        
        self.playerVC1.requestThumbnailImages(atTimes: [10,20], timeOption: MPMovieTimeOption.nearestKeyFrame)
        
    }
    //MARK: 调节亮度  模拟机无效 在真机上才有效
    func adjustBrightnessLeft(gesture:UIGestureRecognizer) {
        
        UIScreen.main.brightness -= 0.1
        print("=====亮度的减少===\(UIScreen.main.brightness)")
    }
    func adjustBrightnessRight(gesture:UIGestureRecognizer) {
        UIScreen.main.brightness += 0.1
//        UIScreen.main.setValue(1.0, forKey: "brightness")
        
        print("=====亮度的增加===\(UIScreen.main.brightness)")
    }
    //MARK: 调节音量
    func adjustVolumeUp(gesture:UIGestureRecognizer)  {
        
//        topView.alpha += 0.1
        
        self.volumeSlider.value += 0.05
        print("======调节音量+++\(self.volumeSlider.value)")
    }
    func adjustVolumeDown(gesture:UIGestureRecognizer)  {
//        topView.alpha -= 0.1
        
        self.volumeSlider.value -= 0.05
        print("======调节音----\(self.volumeSlider.value)")
    }
    
    //MARK:手势代理方法
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    //MARK: 快进快退方法
    
    func beginSeekingForward() {
        
    }
    func beginSeekingBackward() {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        
        self.playerVC1.pause()
        self.playerVC1.view.removeFromSuperview()
        notificationCenter.removeObserver(self)
        self.navigationController?.navigationBar.alpha = 1.0
    }
    
}
