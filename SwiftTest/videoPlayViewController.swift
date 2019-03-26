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
    
    let backScrollView = UIScrollView() //播放器下面的view
    let containView = UIView() //这个没用到啊
    
    
    var playerVC1 = MPMoviePlayerController() //播放器
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

    var thumailBt = UIButton()//截图按钮
    
    var thumbImage = UIImageView()
    
//    weak var weakself = self

    let playerHeight = kSCREENWIDTH * 9 / 16
    
    var isFullscreen: Bool = false {
        didSet {
            // 为了隐藏状态栏必须在info.plist中View controller-based status bar appearance 设置为NO
            UIApplication.shared.setStatusBarHidden(isFullscreen, with: .slide)
        }
    }
 //是否是横屏的标志位
    
    var fullscreenModel: WLVideoPlayerViewFullscreenModel = .awaysLandscape


    var isXlpFullScreen : Bool = false //点击全屏按钮 切换 横竖屏的标志位
    
    //播放进度条
    
    var sliderView = UIView()
    
    
    var playSlider:UISlider = UISlider()
    var playSliderProgress:UIProgressView = UIProgressView()
    
    var updateTimer = Timer() //更新播放进度条的定时器
    
    //隐藏工具条 的定时器 ->思路 touchend 方法开始倒计时  隐藏后 定时器置为失效并销毁,再次touchend时 循环  ,刚进入播放界面  开始倒计时  ,倒计时间到隐藏 并将其置为失效并销毁,如果未到时间有进行触摸操作  倒计时置为失效并销毁
//    var hiddenTimer = Timer()
    var hiddenTimer:Timer?
    var isHiddenControlView = false
    let hiddenTime:TimeInterval = 5
    
    
    
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
//        initBackScrollView()
        //给palyer添加通知 监控其各种状态的变化
        addNoticeForPlayer()
        
        //截图
//        obtainThunailImage()
        
        
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
        swipVolumeUp.direction = UISwipeGestureRecognizer.Direction.up
        swipVolumeUp.numberOfTouchesRequired = 1
        swipVolumeUp.delegate = self
        volumeLeftView.addGestureRecognizer(swipVolumeUp)
        swipVolumeDown = UISwipeGestureRecognizer.init(target: self, action: #selector(adjustVolumeDown(gesture:)))
        swipVolumeDown.direction = UISwipeGestureRecognizer.Direction.down
        swipVolumeDown.numberOfTouchesRequired = 1
        swipVolumeDown.delegate = self
        volumeLeftView.addGestureRecognizer(swipVolumeDown)
        
        //MARK:调节系统亮度
        /*
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
        */
        
    }
    
    func initBackScrollView() {
        self.view.addSubview(backScrollView)
        backScrollView.snp.makeConstraints { (make) in
            
            make.left.equalTo(0)
//            make.top.equalTo(playerHeight)
            make.right.equalTo(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(0)
            make.height.equalTo(kSCREENHEIGHT - playerHeight)
            
        }
        backScrollView.backgroundColor = UIColor.green
//        backScrollView.frame = CGRect(x:0,y:playerHeight - 64,width:kSCREENWIDTH,height:(kSCREENHEIGHT - playerHeight))
        thumbImage.xlpInitImageView(backScrollView, corner: 4) { (make) in
            
            make.center.equalTo(backScrollView)
            make.size.equalTo(CGSize(width:150,height:150))
        }
        thumbImage.backgroundColor = UIColor.yellow
    }
    //MARK: 初始化播放器
    func initMPMoviePlayer() {
        
        // 坑点之一 playerVC1 必须是全局的 变量  否则 不会播放
        self.playerVC1 = MPMoviePlayerController.init(contentURL: self.url! as URL!)
        self.view.addSubview((self.playerVC1.view)!)
//        self.playerVC1.view.frame = CGRect(x:0,y:64,width:kSCREENWIDTH,height:kSCREENWIDTH * 9 / 16)
//        let theHeight = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
//        print(theHeight)
        self.playerVC1.view.snp.makeConstraints { (make) in
            
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(20)
            make.height.equalTo(self.playerHeight)
        }
//        self.playerVC1.view.autoresizingMask = UIViewAutoresizing.flexibleHeight
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
        
        //MARK: 模仿腾讯视频播放界面
        initBackScrollView()
        
        initRelatedViews()
       
       
 
    }
    
    
    //MARK: 初始化播放器相关的视图和控件
    func initRelatedViews() {
        //MARK: 在player上面 放一个view 然后对视频的各种控制 添加到 backView上面
//        view.addSubview(backView)
        self.playerVC1.view.addSubview(backView)
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
            make.left.right.equalTo(0)
//            make.width.equalTo(kSCREENWIDTH)
            make.bottom.equalTo(self.backView.snp.bottom).offset(-0.05)
            make.height.equalTo(44)
//            make.top.equalTo(0)
        }
        bottomView.backgroundColor = UIColor.gray
        
        //播放按钮初始化
        playBt.xlpInitFianlButton("▶️", titleColor: .white, fontSize: 13, superView: bottomView) { (make) in
            make.left.equalTo(10)
            make.top.equalTo(3)
            make.bottom.equalTo(-3)
            make.width.equalTo(30)
        }
        //MARK:添加播放暂停事件
        playBt.addTarget(self, action: #selector(playOrPause), for: .touchUpInside)
        
        //全屏按钮
        fullScreenBt.xlpInitFianlButton("全屏", titleColor: .white, fontSize: 12, superView: bottomView) { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(3)
            make.bottom.equalTo(-3)
            make.width.equalTo(30)
        }
        
        fullScreenBt.addTarget(self, action: #selector(fullScreenAction), for: .touchUpInside)
        
        
        
        
        
        let  asset: AVURLAsset = AVURLAsset.init(url: self.url! as URL)
        let gen:AVAssetImageGenerator = AVAssetImageGenerator.init(asset: asset)
        gen.appliesPreferredTrackTransform = true
        
        self.thumailBt.xlpInitFianlButton("截图", titleColor: .green, fontSize: 13, superView: bottomView, snpMaker: { (make) in
            make.right.equalTo(self.fullScreenBt.snp.left).offset(-10)
            make.top.equalTo(self.fullScreenBt)
            make.size.equalTo(self.fullScreenBt)

        }) { (bt) in
            
            
            //MARK: 获取截图的第二种方法
            let theImage = self.obtainThumailImageTwo(url: (self.url! as NSURL) as URL, gen: gen)
            print("====截取的图片为====\(theImage)")
            self.thumbImage.image = theImage
        }
        
        //MARK: 进度条的初始化
//        playerVC1.view.isUserInteractionEnabled = true
//        backView.isUserInteractionEnabled = true
//        bottomView.isUserInteractionEnabled = true
        
        
        sliderView.xlpInitView(superView: bottomView) { (make) in
            make.left.equalTo(self.playBt.snp.right).offset(20)
            make.right.equalTo(self.thumailBt.snp.left).offset(-10)
                        make.centerY.equalTo(self.bottomView.snp.centerY)
//            make.top.equalTo(self.thumbImage.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
        //缓冲进度条的初始化
        sliderView.addSubview(playSliderProgress)
        playSliderProgress.snp.makeConstraints { (make) in
            
            make.left.right.equalTo(0)
            make.centerY.equalTo(sliderView.snp.centerY)
            make.height.equalTo(1)
        }
        playSliderProgress.progressViewStyle = .default
        playSliderProgress.progressTintColor = UIColor.yellow
        
        //播放进度条的初始化
        sliderView.addSubview(playSlider)
        playSlider.snp.makeConstraints { (make) in
            
            make.left.right.equalTo(0)
            make.centerY.equalTo(self.playSliderProgress).offset(-0.3)
            make.height.equalTo(30)

        }
        playSlider.minimumValue = 0
        playSlider.isContinuous = true
        playSlider.setThumbImage(kImageWithName("sliderImage"), for: .normal)
//        playSlider.setMinimumTrackImage(kImageWithName("sliderImage"), for: .normal)
//        playSlider.setMaximumTrackImage(kImageWithName("sliderImage"), for: .normal)
        playSlider.minimumTrackTintColor = UIColor.red
        playSlider.maximumTrackTintColor = UIColor.clear
        playSlider.addTarget(self, action: #selector(changePlaySlider), for: UIControl.Event.valueChanged)
        
    }
    
    //MARK:播放按钮的点击事件
    @objc func playOrPause(bt:UIButton)  {
        
        if self.playerVC1.playbackState == .playing {
            self.playerVC1.pause()
        }else{
            self.playerVC1.play()
        }
    }
    @objc func fullScreenAction(bt:UIButton) {
        
        if isXlpFullScreen {
            self.changePlayerScreenState(self.view, needRotation: nil, fullscreen: false)

        }else{
            
            self.changePlayerScreenState(self.view, needRotation: CGFloat(Double.pi / 2), fullscreen: true)
        }

    }
    
    func addNoticeForPlayer() {
       
        
        notificationCenter.addObserver(self, selector: #selector(mediaPlayerPlaybackStateChange), name: NSNotification.Name.MPMoviePlayerPlaybackStateDidChange, object: self.playerVC1)
        notificationCenter.addObserver(self, selector: #selector(mediaPlayerPlaybackFinished), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: self.playerVC1)
//        notificationCenter.addObserver(self, selector: #selector(mediaPlayerThumbnailRequestFinished), name: NSNotification.Name.MPMoviePlayerThumbnailImageRequestDidFinish, object: self.playerVC1) //获取截图的方法 舍弃
        
        //播放时长的通知
        notificationCenter.addObserver(self, selector: #selector(mediaPlayerDuration), name: NSNotification.Name.MPMovieDurationAvailable, object: self.playerVC1)
        
        
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
        notificationCenter.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(playerWillEnterFullscreen), name: NSNotification.Name.MPMoviePlayerWillEnterFullscreen, object: self.playerVC1)
        notificationCenter.addObserver(self, selector: #selector(playerWillExitFullscreen), name: NSNotification.Name.MPMoviePlayerWillExitFullscreen, object: self.playerVC1)
        
    }
    
    @objc func mediaPlayerPlaybackStateChange(notification:Notification){
        
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
    @objc func mediaPlayerPlaybackFinished(notification:Notification){
        
        print("视频播放完成")
    }

    //该方法获取最终的图片时 出现问题 故舍弃
 /*
    func mediaPlayerThumbnailRequestFinished(notification:Notification){
        
        let userinfoAny = notification.userInfo
        print(userinfoAny ?? [:])
//        print("\(userinfoAny["MPMoviePlayerThumbnailImageKey"])")
//        print("视频截图完成.======\(notification.userInfo?[MPMoviePlayerThumbnailErrorKey])====userinfo\(userinfoAny?[1])====\(notification)")
//        let image = notification.userInfo?[MPMoviePlayerThumbnailImageKey];
//        //保存图片到相册(首次调用会请求用户获得访问相册权限)
//        if image != nil {
//            UIImageWriteToSavedPhotosAlbum(image as! UIImage, nil, nil, nil);
//        }
        
    }

   
    func obtainThunailImage()  {
        self.playerVC1.requestThumbnailImages(atTimes: [10,20], timeOption: MPMovieTimeOption.nearestKeyFrame)
        
    }
    */
    
    func obtainThumailImageTwo(url:URL,gen:AVAssetImageGenerator) -> UIImage {
        
        let obtainTime:CGFloat = CGFloat(self.playerVC1.currentPlaybackTime)
        
        // 将下面三行提出来 是为了 避免每次截图都要生成一遍 降低截图时间点的误差 可以初始化的时候 初始化一次即可 ,结果还凑合
//        let  asset: AVURLAsset = AVURLAsset.init(url: url, options: nil)
//        let gen:AVAssetImageGenerator = AVAssetImageGenerator.init(asset: asset)
//        gen.appliesPreferredTrackTransform = true
        let time:CMTime = CMTimeMakeWithSeconds(Float64(obtainTime), preferredTimescale: 1) //两个参数  第一个是视频的第几秒  第二个是 每秒的帧数
        var actualTime = CMTime.init() //实际生成缩略图的时间
        let image:CGImage = try! gen.copyCGImage(at: time, actualTime: &actualTime)
        let thumb:UIImage = UIImage.init(cgImage: image)
        
        
        
        //oc代码
//        [[AVURLAsset alloc] initWithURL:soundFileURL options:nil];
//        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//        gen.appliesPreferredTrackTransform = YES;
//        CMTime time = CMTimeMakeWithSeconds(0.0, 1);
//        NSError *error = nil;
//        CMTime actualTime;
//        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
//        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        
        return thumb;
    }
    
    //MARK: 调节亮度  模拟机无效 在真机上才有效
    func adjustBrightnessLeft(gesture:UIGestureRecognizer) {
        
        UIScreen.main.brightness -= 0.1
    }
    func adjustBrightnessRight(gesture:UIGestureRecognizer) {
        UIScreen.main.brightness += 0.1
        
    }
    //MARK: 调节音量
    @objc func adjustVolumeUp(gesture:UIGestureRecognizer)  {
        
//        backView.alpha += 0.1
        self.volumeSlider.value += 0.05
        let nowValue:Float = self.volumeSlider.value
        self.volumeSlider.setValue(nowValue, animated: false)
    }
    @objc func adjustVolumeDown(gesture:UIGestureRecognizer)  {
//        backView.alpha -= 0.1
        self.volumeSlider.value -= 0.05
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
    @objc func deviceOrientationDidChange() {
        
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
    @objc func playerWillEnterFullscreen() {
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
    @objc func playerWillExitFullscreen() {
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
            
            changePlayerScreenState(self.view, needRotation: nil, fullscreen: true)
            
        }else if fullscreenModel == .awaysLandscape {
            exitFullscreen()
        }
    }
    
    func enterFullscreen(_ angle: CGFloat?) {
        changePlayerScreenState(self.view, needRotation: angle, fullscreen: true)

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
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
             self.notificationCenter.post(name: fullscreen! ? NSNotification.Name.MPMoviePlayerWillEnterFullscreen : NSNotification.Name.MPMoviePlayerWillExitFullscreen, object: nil)
            inView.addSubview(self.playerVC1.view)
            
            self.playerVC1.view.transform = CGAffineTransform(rotationAngle: angle ?? 0)
           
            if fullscreen!{
                
                
                
                self.playerVC1.view.snp.remakeConstraints({ (make) in
                    make.center.equalTo(inView.center)
                    make.width.equalTo(kSCREENHEIGHT)
                    make.height.equalTo(kSCREENWIDTH)
                })
                self.isXlpFullScreen  = true
                
                
            }else{
                

                self.playerVC1.view.snp.remakeConstraints({ (make) in
                    make.top.equalTo(20)
                    make.left.right.equalTo(0)
                    make.height.equalTo(self.playerHeight)
                })

                self.isXlpFullScreen = false
            }
        }, completion: { (finish) -> Void in
            if fullscreen != nil {
                self.isFullscreen = fullscreen!
                self.navigationController?.navigationBar.alpha = 0.0

            }
            
            
            
        })
    }
    
    //MARK:播放进度条
    
    func obtainPlaySlider() {
        
        //self.playerVC1.duration //时长 如果未知返回0  那推测 这是通知的存在的理由 -> //关于这个还有一个通知
        //self.playerVC1.playableDuration //已经缓冲的
        //self.playerVC1.currentPlaybackTime //当前的播放时间
//        self.playerVC1.initialPlaybackTime //起始播放时间
        //self.playerVC1.endPlaybackTime //终止播放时间
        
        print("\(self.playerVC1.duration)===\(self.playerVC1.playableDuration)====\(self.playerVC1.initialPlaybackTime)===\(self.playerVC1.endPlaybackTime)===\(self.playerVC1.currentPlaybackTime)")

//        bottomView.addSubview(playSlider)
//        playSlider.snp.makeConstraints { (make) in
//            make.left.equalTo(playBt.snp.right).offset(20)
//            make.right.equalTo(thumailBt.snp.left).offset(-10)
//            make.centerY.equalTo(bottomView.snp.centerY)
//            make.height.equalTo(10)
//        }
        playSlider.maximumValue = Float(self.playerVC1.duration)
//        playSlider.value = Float(self.playerVC1.currentPlaybackTime)
        playSlider.setValue(Float(self.playerVC1.currentPlaybackTime), animated: true)
        
        
//        playSliderProgress.snp.makeConstraints { (make) in
//            
//        }
        
        
        
    }
    
    //MARK: slider拖拽时的 事件
    @objc func changePlaySlider(slider:UISlider) {
        
        print(slider.value)
        
        playerVC1.currentPlaybackTime = TimeInterval(slider.value)
    }
    
    @objc func mediaPlayerDuration(notification:Notification) {
        
        print("====播放时长的通知对应的方法 看看获取到什么了\(notification.userInfo ?? [:])")
        
        print("\(self.playerVC1.duration)===\(self.playerVC1.playableDuration)====\(self.playerVC1.initialPlaybackTime)===\(self.playerVC1.endPlaybackTime)===\(self.playerVC1.currentPlaybackTime)")
        
        playSlider.maximumValue = Float(self.playerVC1.duration)
        //        playSlider.value = Float(self.playerVC1.currentPlaybackTime)
        playSlider.setValue(Float(self.playerVC1.currentPlaybackTime), animated: true)
        
        //更新进度条的定时器初始化 由于需要视频时长这个参数 故定时器的初始化放在这里
        
//        if #available(iOS 10.0, *) {
//            updateTimer = Timer.init(timeInterval: self.playerVC1.duration, repeats: false, block: { (timer) in
//                
//            })
//        } else {
//            // Fallback on earlier versions
//        }
        
        updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayerSlider), userInfo: nil, repeats: true)
        
        //获取到视频时长的时候 开始倒计时 
        
        beginTimer()
    }
    
    //MARK:更新播放进度条的事件
    @objc func updatePlayerSlider() {
        
        let progress:Float = Float(self.playerVC1.playableDuration / self.playerVC1.duration)
      
        playSliderProgress.setProgress(progress, animated: true)
        playSlider.setValue(Float(self.playerVC1.currentPlaybackTime), animated: true)

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.alpha = 1.0

        self.playerVC1.pause()
        self.playerVC1.stop()
        self.playerVC1.view.removeFromSuperview()
        notificationCenter.removeObserver(self)
        
        volumeLeftView.removeFromSuperview()

        //页面消失后  将定时器失效
        updateTimer.invalidate()
        deleteTimer()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        print("没有操作 5秒钟了  要隐藏工具条了 啦啦啦 touchend")
        beginTimer()
        print("没有操作 开始倒计时  要隐藏工具条了 啦啦啦")

    }
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        _ = Timer.init(timeInterval: 5, target: self, selector: #selector(hiddenControlView), userInfo: nil, repeats: false)
//        print("没有操作 开始倒计时  要隐藏工具条了 啦啦啦")
//
//    }
    
    @objc func hiddenControlView()  {
        
        print(" 隐藏工具条操作 啦啦啦  ")
        //操作
        UIView.animate(withDuration: 0.3) {
            
            self.topView.alpha = 0.0
            self.bottomView.alpha = 0.0
            
            self.isHiddenControlView = true
        }
        //最后销毁定时器
        deleteTimer()
        
    }
    
    func showHiddenControlView()  {
        
        deleteTimer()
        //操作
        UIView.animate(withDuration: 0.3) {
            
            self.topView.alpha = 1.0
            self.bottomView.alpha = 1.0
            
            self.isHiddenControlView = true
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("开始有人操作了begin")
        
        
        
        
        
        showHiddenControlView()
    }
    
    func beginTimer()  {
        
        hiddenTimer = Timer.init(timeInterval: hiddenTime, target: self, selector: #selector(hiddenControlView), userInfo: nil, repeats: true)
        
        RunLoop.main.add(hiddenTimer!, forMode: RunLoop.Mode.common)

    }
    
    //MARK: 销毁定时器
    func deleteTimer() {
        
        if (hiddenTimer != nil) {
            
            hiddenTimer?.invalidate()
            hiddenTimer = nil
        }
    }
    
    
    
}
