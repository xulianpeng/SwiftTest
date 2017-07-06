//
//  videoRootViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/10.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

class videoRootViewController: XLPBaseViewController {

    let url = NSURL.init(string: "http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4")
    let videoBt1 = UIButton.init(type: UIButtonType.custom)
    let videoBt2 = UIButton.init(type: UIButtonType.custom)
    let videoBt3 = UIButton.init(type: UIButtonType.custom)
    let videoBt4 = UIButton.init(type: UIButtonType.custom)
    
    let videoBt5 = UIButton.init(type: UIButtonType.custom)
    
    
    
    var playerVC1 = MPMoviePlayerController()
    
    var avPlayer = AVPlayer()
    var avPlayerLayer = AVPlayerLayer()
    
    var noDataBt = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        layoutViews()
//        
//        initIndicator(self.view).startAnimating()
//    }
    //悠军毅

    
        
        
        videoBt1.xlpInitEassyButton("MPMoviePlayerViewController", titleColor: .blue, fontSize: 14, backgroundColor: kRandomColor(), cornerRedius: 4, superView: view, snpMaker: { (make) in
            
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(80)
            make.height.equalTo(30)
        }) { (bt) in
        
            
            let playerVC = MPMoviePlayerViewController.init(contentURL: self.url as URL!)
            self.present(playerVC!, animated: true, completion: nil)
        }
        
        videoBt2.xlpInitEassyButton("MPMoviePlayerController", titleColor: .blue, fontSize: 14, backgroundColor: kRandomColor(), cornerRedius: 4, superView: view, snpMaker: { (make) in
            
            make.left.equalTo(videoBt1.snp.left)
            make.right.equalTo(videoBt1.snp.right)
            make.top.equalTo(videoBt1.snp.bottom).offset(20)
            make.height.equalTo(videoBt1.snp.height)
        }) { (bt) in
            
            
            self.navigationController?.pushViewController(videoPlayViewController(), animated: true)
            /*
            // 坑点之一 playerVC1 必须是全局的 变量  否则 不会播放
            self.playerVC1 = MPMoviePlayerController.init(contentURL: self.url! as URL!)
            self.playerVC1.view.frame = CGRect(x:0,y:300,width:kSCREENWIDTH,height:kSCREENWIDTH * 9 / 16)
            
            self.view.addSubview((self.playerVC1.view)!)
            
            self.playerVC1.controlStyle = .default//embedded,fullscreen,none,default
            //显示播放 按钮  快进 快退 全屏等 
            //fullscreen  分上下两部分 上面是 完成按钮  进度条  下面是 快退 播放 快进 三个按钮 ,其中 点完成时 播放暂停 , 点快进或快退时,若无视频队列 则会黑屏 
            //none时 相关的控制按钮 进度条 全部没有
            //default 同 embedded
            //embedded 播放按钮  进度条 还有个类似全屏的按钮 但是 一点击 先放大但画面消失 声音还在
            
            self.playerVC1.scalingMode = .none
            
            //aspectFit  成比例缩放 上下部分 会有部分黑屏
            //aspectFill / fill/none  全屏填充
            self.playerVC1.shouldAutoplay = true
            self.playerVC1.repeatMode = .one
            self.playerVC1.prepareToPlay()
           
            print("===============\(self.playerVC1.readyForDisplay)")
            self.playerVC1.play()
            
            */
        }
        
        videoBt3.xlpInitEassyButton("AVPlayerViewController", titleColor: .blue, fontSize: 14, backgroundColor: kRandomColor(), cornerRedius: 4, superView: view, snpMaker: { (make) in
            
            make.left.equalTo(videoBt1.snp.left)
            make.right.equalTo(videoBt1.snp.right)
            make.top.equalTo(videoBt2.snp.bottom).offset(20)
            make.height.equalTo(videoBt1.snp.height)
        }) { (bt) in
            
            
            let playerVC = AVPlayerViewController.init()
            let avPlayer = AVPlayer.init(url: self.url! as URL)
            playerVC.player = avPlayer
            self.present(playerVC, animated: true, completion: nil)
            playerVC.player?.play()  //加了则自动播放 否则 需在播放页面 手动点击播放
            
            
        }
        
        videoBt4.xlpInitEassyButton("AVPlayer", titleColor: .blue, fontSize: 14, backgroundColor: kRandomColor(), cornerRedius: 4, superView: view, snpMaker: { (make) in
            
            make.left.equalTo(videoBt1.snp.left)
            make.right.equalTo(videoBt1.snp.right)
            make.top.equalTo(videoBt3.snp.bottom).offset(20)
            make.height.equalTo(videoBt1.snp.height)
        }) { (bt) in
            
            let avPlayerItem = AVPlayerItem.init(url: self.url! as URL)
            self.avPlayer = AVPlayer.init(playerItem: avPlayerItem)
            self.avPlayer.play()
            self.avPlayerLayer = AVPlayerLayer.init(player: self.avPlayer)
            self.avPlayerLayer.frame = CGRect(x:0,y:300,width:kSCREENWIDTH,height:kSCREENWIDTH * 9 / 16)
            self.avPlayerLayer.borderColor = UIColor.red.cgColor
            self.avPlayerLayer.borderWidth = 3
            self.view.layer.addSublayer(self.avPlayerLayer)
            self.avPlayer.volume  = 0.3
            
        }
        
        videoBt5.xlpInitEassyButton("DWCC", titleColor: kRandomColor(), fontSize: 14, backgroundColor: kRandomColor(), cornerRedius: 4, superView: view, snpMaker: { (make) in
            
            make.left.equalTo(videoBt1.snp.left)
            make.right.equalTo(videoBt1.snp.right)
            make.top.equalTo(videoBt4.snp.bottom).offset(20)
            make.height.equalTo(videoBt1.snp.height)
            
        }) { (bt) in
            
            let ccDemoVC = CCDemoViewController()
            self.navigationController?.pushViewController(ccDemoVC, animated: true)
        }
        
        noDataBt.xlpInitEassyButton("无数据显示", titleColor: .red, fontSize: 14, backgroundColor: .green, cornerRedius: 3, superView: self.view, snpMaker: { (make) in
            
            make.top.equalTo(videoBt5.snp.bottom).offset(10)
            make.left.equalTo(videoBt5)
            make.right.equalTo(videoBt5)
            make.height.equalTo(videoBt5)
        }) { (bt) in
            
            
            let noDataView = NoDataView.init(superView: self.view, imageName: "defaultCell", str: "擦擦擦擦啊貌似没有数据哦 请检查网络连接是否正确", snapBlock: { (make) in
                
                make.edges.equalTo(self.view)
            })
            
            print(noDataView)
        }
        
        
       let mySwitch =  XlpSwitch.init(frame:CGRect(x:100,y:400,width:45,height:20))
        
        
        self.view.addSubview(mySwitch)


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
//        self.view = nil //针对AVPlayer 若在退出播放器页面时,若未将放置该AVPlayer的view置为nil,则其内存不会被释放,会出现多个声音来源
//        //下面这两个方法 貌似释放 AVPlayer无效
//        avPlayer.currentItem?.cancelPendingSeeks()
//        avPlayer.currentItem?.asset.cancelLoading()
        
        //以上两种 方法 貌似均无效
        
        /*********************/
        //这个方法 针对 第二种方法 内存有所减少,但还是有所增加,多次打开视频可能会有视频暴增的危险 但 不如第一种和第三种(这俩是退出后内存完全不增加)
        self.playerVC1.stop()
        self.playerVC1.view.removeFromSuperview()
        //*****************//
        
        
        //这个根本就没释放
        self.avPlayer.pause()
        self.avPlayerLayer.removeFromSuperlayer()
        self.view = nil
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
