//
//  videoPlayViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/10.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import MediaPlayer
class videoPlayViewController: XLPBaseViewController {

    let url = NSURL.init(string: "http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4")
    var playerVC1 = MPMoviePlayerController()
     let notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        initMPMoviePlayer()
        //给palyer添加通知 监控其各种状态的变化
        addNoticeForPlayer()
        
        //
        obtainThunailImage()
    }
    
    func initMPMoviePlayer() {
        
        // 坑点之一 playerVC1 必须是全局的 变量  否则 不会播放
        self.playerVC1 = MPMoviePlayerController.init(contentURL: self.url! as URL!)
        self.playerVC1.view.frame = CGRect(x:0,y:100,width:SCREENWIDTH,height:SCREENWIDTH * 9 / 16)
        
        self.view.addSubview((self.playerVC1.view)!)
        
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
        
        print("===============\(self.playerVC1.readyForDisplay)")
        self.playerVC1.play()
    }
    
    func addNoticeForPlayer() {
       
        
        notificationCenter.addObserver(self, selector: #selector(mediaPlayerPlaybackStateChange), name: NSNotification.Name.MPMoviePlayerPlaybackStateDidChange, object: self.playerVC1)
        notificationCenter.addObserver(self, selector: #selector(mediaPlayerPlaybackFinished), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: self.playerVC1)
        notificationCenter.addObserver(self, selector: #selector(mediaPlayerThumbnailRequestFinished), name: NSNotification.Name.MPMoviePlayerThumbnailImageRequestDidFinish, object: self.playerVC1)
        
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
        //获取13.0s、21.5s的缩略图
//        @objc [self.playerVC1 
//        requestThumbnailImagesAtTimes:@[@13.0,@21.5] timeOption:MPMovieTimeOptionNearestKeyFrame];
//        self.playerVC1.required
        
        //获取13.0s、21.5s的缩略图
//        [self.moviePlayer requestThumbnailImagesAtTimes:@[@13.0,@21.5] timeOption:MPMovieTimeOptionNearestKeyFrame];
        
        self.playerVC1.requestThumbnailImages(atTimes: [10,20], timeOption: MPMovieTimeOption.nearestKeyFrame)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        notificationCenter.removeObserver(self)
    }
    
}
