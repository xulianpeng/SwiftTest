//
//  videoPlayViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/10.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import MediaPlayer
import Darwin


//坑点:横竖屏切换时  首先只勾选 portrait ,否则旋转角度的地方会出现问题 , 然后旋转的方法使用独立旋转那个方法 ,旋转后的布局一定要更新, snp约束的话要使用  center  width height  ,而不是left top  right bottom 
// 状态栏自动隐藏 显现的话  要在plist文件里面 添加 View controller-based status bar appearance  为NO
// 同时 添加观察者方法 var isFullscreen: Bool = false {
//didSet {
    // 为了隐藏状态栏必须在info.plist中View controller-based status bar appearance 设置为NO
    //UIApplication.shared.setStatusBarHidden(isFullscreen, with: .slide)
//}
//}

enum WLVideoPlayerViewFullscreenModel {
    /// 当设备旋转、全屏按钮点击就进入全屏且横屏的状态
    case awaysLandscape
    /// 全屏按钮点击进入全屏状态，在全屏状态下旋转才进入横屏
    case landscapeWhenInFullscreen
}

class videoPlayViewController: XLPBaseViewController,UIGestureRecognizerDelegate {

    let url = NSURL.init(string: "http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4")
    
//    let url = NSURL.init(string: "http://flv2.bn.netease.com/videolib3/1705/15/EQkHT1410/SD/EQkHT1410-mobile.mp4")
    
    let backScrollView = UIScrollView()
    let containView = UIView()
    
    
    var playerVC1 = MPMoviePlayerController()
    let notificationCenter = NotificationCenter.default
    
    
    var backView = UIView() //player.view上的第一个view 尺寸和其一样大 ,所有的控制均为其 子视图
    
    var topView = UIView() //顶部视图:返回按钮  投放TV  横屏时: 返回 播放速率 选集 设置
    
    var bottomView = UIView() //底部视图: 播放 暂停  播放进度条 全屏 横屏时: 清晰度
    
    var swipBrightnessLeft = UISwipeGestureRecognizer()
    var swipBrightnessRight = UISwipeGestureRecognizer()
    
    var swipVolumeUp = UISwipeGestureRecognizer()
    var swipVolumeDown = UISwipeGestureRecognizer()
    
    var volumeView = MPVolumeView()
    var volumeSlider = UISlider()
    
    var volumeLeftView = UIView()
    var brightnessRightView = UIView()
   
    //各种控制按钮
    var playBt = UIButton() //播放暂停按钮

    var fullScreenBt = UIButton() //全屏切换按钮

//    weak var weakself = self

    var isFullscreen: Bool = false {
        didSet {
            // 为了隐藏状态栏必须在info.plist中View controller-based status bar appearance 设置为NO
            UIApplication.shared.setStatusBarHidden(isFullscreen, with: .slide)
        }
    }
 //是否是横屏的标志位
    
    var fullscreenModel: WLVideoPlayerViewFullscreenModel = .awaysLandscape

//    var inView = UIView()
    
    
    //MARk: 坑点,若是使用系统手势平移返回  但是没返回 还是在这个页面的话 播放界面会消失  只走viewWillAppear
    // 暂时的解决思路时  判断是否平移手势未成功  未成功时  则直接在 viewWillAppear里调用 初始化播放器的方法
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("=====切换横竖屏时 此方法是否每次都走")
    }
 
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
//        self.shouldAutorotate = false
        
        //MARK: 坑点 导航栏的透明度设置为0 时,返回功能失效
        self.navigationController?.navigationBar.alpha = 0.0
//        self.navigationController?.hidesBarsOnSwipe = true
        //MARK: 初始化播放器
        initMPMoviePlayer()
        //MARK: 模仿腾讯视频播放界面
        initBackScrollView()
        //给palyer添加通知 监控其各种状态的变化
        addNoticeForPlayer()
        
        //截图
        obtainThunailImage()
        
        
        //获取 系统音量条
        volumeView.showsVolumeSlider = true
        /// 获取到 volumeview里面控制音量的 slider
        for var aView in volumeView.subviews {
            
            if aView.description.contains("MPVolumeSlider") {
                
                self.volumeSlider = aView as! UISlider
                break
            }

        }
        //MARK: 初始化视频的音量
        self.volumeSlider.setValue(0.3, animated: false)
        
        /* 这是把音量条 做可视化处理
        let MySlider = UISlider()
        backView.addSubview(MySlider)
        MySlider.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(10)
            make.centerY.equalTo(backView.snp.centerY)
        }
//        self.volumeSlider.setValue(0.0, animated: true)
//        MySlider.value = self.volumeSlider.value
        
        MySlider.minimumValue = 0.0
        MySlider.maximumValue = 1.0
        MySlider.backgroundColor = .blue
//        MySlider.transform.rotated(by:CGFloat(-M_PI/2))
        
//        MySlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI/2))
        */
        
        
        //MARK:调节系统音量
        backView.addSubview(volumeLeftView)
        volumeLeftView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(kSCREENWIDTH / 2)
            make.height.equalTo(backView)
        }
        volumeLeftView.backgroundColor = UIColor.clear
        swipVolumeUp = UISwipeGestureRecognizer.init(target: self, action: #selector(adjustVolumeUp(gesture:)))
        swipVolumeUp.direction = UISwipeGestureRecognizerDirection.up
        swipVolumeUp.numberOfTouchesRequired = 1
        swipVolumeUp.delegate = self
        volumeLeftView.addGestureRecognizer(swipVolumeUp)
        swipVolumeDown = UISwipeGestureRecognizer.init(target: self, action: #selector(adjustVolumeDown(gesture:)))
        swipVolumeDown.direction = UISwipeGestureRecognizerDirection.down
        swipVolumeDown.numberOfTouchesRequired = 1
        swipVolumeDown.delegate = self
        volumeLeftView.addGestureRecognizer(swipVolumeDown)
        
        //MARK:调节系统亮度
        swipBrightnessLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(adjustBrightnessLeft(gesture:)))
        swipBrightnessLeft.direction = UISwipeGestureRecognizerDirection.left
        swipBrightnessLeft.numberOfTouchesRequired = 1
        swipBrightnessLeft.delegate = self
        backView.addGestureRecognizer(swipBrightnessLeft)
        
        swipBrightnessRight = UISwipeGestureRecognizer.init(target: self, action: #selector(adjustBrightnessRight(gesture:)))
        swipBrightnessRight.direction = UISwipeGestureRecognizerDirection.right
        swipBrightnessRight.numberOfTouchesRequired = 1
        swipBrightnessRight.delegate = self
        backView.addGestureRecognizer(swipBrightnessRight)
        
        
    }
    
    func initBackScrollView() {
        self.view.addSubview(backScrollView)
        backScrollView.snp.makeConstraints { (make) in
            
            make.left.equalTo(0)
            make.top.equalTo(self.playerVC1.view.snp.bottom).offset(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            
        }
        backScrollView.backgroundColor = UIColor.green
    }
    func initMPMoviePlayer() {
        
        // 坑点之一 playerVC1 必须是全局的 变量  否则 不会播放
        self.playerVC1 = MPMoviePlayerController.init(contentURL: self.url! as URL!)
        self.view.addSubview((self.playerVC1.view)!)
//        self.playerVC1.view.frame = CGRect(x:0,y:64,width:kSCREENWIDTH,height:kSCREENWIDTH * 9 / 16)
        let theHeight = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        print(theHeight)
        self.playerVC1.view.snp.makeConstraints { (make) in
            
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(kSCREENWIDTH * 9 / 16)
        }
        
        self.playerVC1.controlStyle = .none//embedded,fullscreen,none,default
        //显示播放 按钮  快进 快退 全屏等
        //fullscreen  分上下两部分 上面是 完成按钮  进度条  下面是 快退 播放 快进 三个按钮 ,其中 点完成时 播放暂停 , 点快进或快退时,若无视频队列 则会黑屏
        //none时 相关的控制按钮 进度条 全部没有
        //default 同 embedded
        //embedded 播放按钮  进度条 还有个类似全屏的按钮 但是 一点击 先放大但画面消失 声音还在 ->这个当palyer放在 push的另一个视图时,没有问题,点击放大 效果为MPMoviePlayerViewController.
        
        self.playerVC1.scalingMode = .aspectFit
        
        //aspectFit  成比例缩放 上下部分 会有部分黑屏
        //aspectFill / fill/none  全屏填充
        self.playerVC1.shouldAutoplay = true
        self.playerVC1.repeatMode = .one
        self.playerVC1.prepareToPlay()
        
        //MARK: 改变播放速率  float  0 暂停  1 正常播放  2 是2倍速率
        self.playerVC1.currentPlaybackRate = 1.0
        
        self.playerVC1.play()
        
        initRelatedViews()
       
       
 
    }
    
    
    //MARK: 初始化播放器相关的视图和控件
    func initRelatedViews() {
        //MARK: 在player上面 放一个view 然后对视频的各种控制 添加到 backView上面
        view.addSubview(backView)
        
        backView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.playerVC1.view)
        }
        backView.backgroundColor = UIColor.clear
        
        backView.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(44)
        }
        topView.backgroundColor = UIColor.red
        
        bottomView.xlpInitView(superView: backView) { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(44)
        }
        bottomView.backgroundColor = UIColor.gray
        
        playBt.xlpInitFianlButton("▶️", titleColor: .white, fontSize: 12, superView: bottomView, snpMaker: { (make) in
            make.left.equalTo(10)
            make.top.equalTo(3)
            make.bottom.equalTo(-3)
            make.width.equalTo(30)
        }) { (bt) in
            
            self.playerVC1.pause()
        }
        
        /*
        fullScreenBt.xlpInitFianlButton("全屏", titleColor: .white, fontSize: 12, superView: bottomView, snpMaker: { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(3)
            make.bottom.equalTo(-3)
            make.width.equalTo(30)
        }) { (bt) in
            
            
            
            if !weakself!.isFullscreen{
                
                UIApplication.shared.setStatusBarOrientation(.landscapeLeft, animated: true)
                UIView.animate(withDuration: 0.5, animations: {
                    
                    
                    weakself!.playerVC1.view.transform = weakself!.playerVC1.view.transform.rotated(by: CGFloat(M_PI/2))
//                    weakself!.topView.transform = weakself!.topView.transform.rotated(by: CGFloat(Double.pi / 2))
//                    weakself!.bottomView.transform = weakself!.bottomView.transform.rotated(by: CGFloat(Double.pi / 2))

                    weakself?.playerVC1.view.snp.remakeConstraints({ (make) in
                        make.left.top.bottom.equalTo(0)
                        make.right.equalTo(0)
                        print("asdajdhjkahsdjka")
                    })
                    weakself!.backView.transform = weakself!.backView.transform.rotated(by: CGFloat(Double.pi / 2))

                    weakself!.backView.snp.remakeConstraints { (make) in
                        make.edges.equalTo(self.playerVC1.view)
                    }
                    weakself?.isFullscreen = true
                })
                
            }else{
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    weakself!.playerVC1.view.transform = weakself!.playerVC1.view.transform.rotated(by: CGFloat(-M_PI/2))
                    weakself!.backView.transform = weakself!.backView.transform.rotated(by: CGFloat(-Double.pi / 2))

//                    weakself!.topView.transform = weakself!.topView.transform.rotated(by: CGFloat(-Double.pi / 2))
//                    weakself!.bottomView.transform = weakself!.bottomView.transform.rotated(by: CGFloat(-Double.pi / 2))
                    weakself?.playerVC1.view.snp.remakeConstraints({ (make) in
                        make.left.right.top.equalTo(0)
                        make.height.equalTo(kSCREENWIDTH * 9 / 16)
                    })
                    weakself?.isFullscreen = false
                })
                
            }
            
        }
        
        */
        
        
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
        notificationCenter.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        notificationCenter.addObserver(self, selector: #selector(playerWillEnterFullscreen), name: NSNotification.Name.MPMoviePlayerWillEnterFullscreen, object: self.playerVC1)
        notificationCenter.addObserver(self, selector: #selector(playerWillExitFullscreen), name: NSNotification.Name.MPMoviePlayerWillExitFullscreen, object: self.playerVC1)
        
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
        
//        backView.alpha += 0.1
        
        self.volumeSlider.value += 0.05
        let nowValue:Float = self.volumeSlider.value
        print("=====音量增大后的值为\(nowValue)")
        self.volumeSlider.setValue(nowValue, animated: false)

        print("======调节音量+++\(self.volumeSlider.value)")
    }
    func adjustVolumeDown(gesture:UIGestureRecognizer)  {
//        backView.alpha -= 0.1
        
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
   
   //MARK: 横竖屏切换
    /**
     当设备发生旋转的时候调用
     */
    func deviceOrientationDidChange() {
        guard isDisplayedInScreen() else {
            return
        }
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .landscapeLeft:
            toLandscape(CGFloat(Double.pi / 2))
            break
        case .landscapeRight:
            toLandscape(CGFloat(-Double.pi / 2))
            break
        case .portrait:
            toPortrait()
            break
        default:
            break
        }
    }
    
    /**
     即将进入全屏模式的时候调用
     */
    func playerWillEnterFullscreen() {
        switch fullscreenModel {
        case .awaysLandscape:
            UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.landscapeLeft.rawValue as Int), forKey: "orientation")
            break
        case .landscapeWhenInFullscreen:
            enterFullscreen(nil)
            break
        }
    }
    /**
     即将退出全屏模式的时候调用
     */
    func playerWillExitFullscreen() {
        switch fullscreenModel {
        case .awaysLandscape:
            UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue as Int), forKey: "orientation")
            break
        case .landscapeWhenInFullscreen:
            UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue as Int), forKey: "orientation")
            exitFullscreen()
            break
        }
    }
    
    /**
     判断当前view是否显示在屏幕上
     */
    func isDisplayedInScreen() -> Bool {
        
//        if self.isHidden {
//            return false
//        }
        
        // self对应window的坐标
//        let rect = self.convert(self.frame, to: nil)
//        let screenRect = UIScreen.main.bounds
//        
//        let intersectionRect = rect.intersection(screenRect)
//        if intersectionRect.isEmpty || intersectionRect.isNull {
//            return false;
//        }
        
        return true
    }

    
    //========================================================
    // MARK: 旋转\全屏控制方法
    //========================================================
    
    /**
     每当设备横屏的时候调用
     让视频播放器进入横屏的全屏播放状态
     - parameter angle: 旋转的角度
     */
    func toLandscape(_ angle: CGFloat) {
        if fullscreenModel == .landscapeWhenInFullscreen && !isFullscreen {
            return
        }else {
            enterFullscreen(angle);
        }
    }
    /**
     每当设备进入竖屏的时候调用
     退出全屏播放状态
     */
    func toPortrait() {
        
        if fullscreenModel == .landscapeWhenInFullscreen && isFullscreen  {
            
            changePlayerScreenState(UIApplication.shared.keyWindow!, needRotation: nil, fullscreen: nil)
            
        }else if fullscreenModel == .awaysLandscape {
            exitFullscreen()
        }
    }
    
    func enterFullscreen(_ angle: CGFloat?) {
        changePlayerScreenState(UIApplication.shared.keyWindow!, needRotation: angle, fullscreen: true)
    }
    
    func exitFullscreen() {
        changePlayerScreenState(self.view, needRotation: nil, fullscreen: false)
    }
    /**
     用来改变播放器的显示状态(是否全屏、是否竖屏等)
     
     - parameter inView:       播放器处于的父视图
     - parameter angle:        是否需要旋转，nil代表不需要
     - parameter isfullscreen: 是否将要全屏显示，nil代表保存原状
     */
    func changePlayerScreenState(_ inView: UIView, needRotation angle: CGFloat?, fullscreen: Bool?) {
        
//        guard let customControlView = self.customControlView else {
//            return
//        }
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            
             self.notificationCenter.post(name: fullscreen! ? NSNotification.Name.MPMoviePlayerWillEnterFullscreen : NSNotification.Name.MPMoviePlayerWillExitFullscreen, object: nil)
            
            inView.addSubview(self.playerVC1.view)
            
            self.playerVC1.view.transform = CGAffineTransform(rotationAngle: angle ?? 0)
            
//            CGAffineTransform(rotationAngle: CGFloat(-M_PI/))

            
            if fullscreen!{
                
                
                
                self.playerVC1.view.snp.remakeConstraints({ (make) in
                    make.center.equalTo(inView.center)
                    make.width.equalTo(kSCREENHEIGHT)
                    make.height.equalTo(kSCREENWIDTH)
                })
                
                
            }else{
                
                self.playerVC1.view.snp.remakeConstraints({ (make) in
                    make.top.left.right.equalTo(0)
                    make.height.equalTo(kSCREENWIDTH * 9 / 16)
                })
                
                
            }
        }, completion: { (finish) -> Void in
            if fullscreen != nil {
                self.isFullscreen = fullscreen!
            }
            
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        self.playerVC1.pause()
        self.playerVC1.stop()
        self.playerVC1.view.removeFromSuperview()
        notificationCenter.removeObserver(self)
        self.navigationController?.navigationBar.alpha = 1.0
        
        volumeLeftView.removeFromSuperview()
        
        
    }
    
}
