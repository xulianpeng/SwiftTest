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
    
    
    var avPlayer = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
        
    }
    
    func layoutViews()  {
        
        
        
        videoBt1.xlpInitEassyButton("MPMoviePlayerViewController", titleColor: .blue, fontSize: 14, backgroundColor: XLPRandomColor(), cornerRedius: 4, superView: view, snpMaker: { (make) in
            
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(80)
            make.height.equalTo(30)
        }) { (bt) in
        
            
            let playerVC = MPMoviePlayerViewController.init(contentURL: self.url as URL!)
            self.present(playerVC!, animated: true, completion: nil)
        }
        
        videoBt2.xlpInitEassyButton("MPMoviePlayerController", titleColor: .blue, fontSize: 14, backgroundColor: XLPRandomColor(), cornerRedius: 4, superView: view, snpMaker: { (make) in
            
            make.left.equalTo(videoBt1.snp.left)
            make.right.equalTo(videoBt1.snp.right)
            make.top.equalTo(videoBt1.snp.bottom).offset(20)
            make.height.equalTo(videoBt1.snp.height)
        }) { (bt) in
            
            
            let playerVC = MPMoviePlayerController.init(contentURL: self.url! as URL!)
            playerVC?.view.frame = CGRect(x:0,y:300,width:SCREENWIDTH,height:SCREENWIDTH * 9 / 16)
            self.view.addSubview((playerVC?.view)!)
            
            playerVC?.controlStyle = .default
            playerVC?.scalingMode = .aspectFit
            playerVC?.shouldAutoplay = true
            playerVC?.prepareToPlay()
           
            print("===============\(playerVC?.readyForDisplay)")
            playerVC?.play()
        }
        
        videoBt3.xlpInitEassyButton("AVPlayerViewController", titleColor: .blue, fontSize: 14, backgroundColor: XLPRandomColor(), cornerRedius: 4, superView: view, snpMaker: { (make) in
            
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
        
        videoBt4.xlpInitEassyButton("AVPlayer", titleColor: .blue, fontSize: 14, backgroundColor: XLPRandomColor(), cornerRedius: 4, superView: view, snpMaker: { (make) in
            
            make.left.equalTo(videoBt1.snp.left)
            make.right.equalTo(videoBt1.snp.right)
            make.top.equalTo(videoBt3.snp.bottom).offset(20)
            make.height.equalTo(videoBt1.snp.height)
        }) { (bt) in
            
            let avPlayerItem = AVPlayerItem.init(url: self.url! as URL)
            self.avPlayer = AVPlayer.init(playerItem: avPlayerItem)
            self.avPlayer.play()
            let avPlayerLayer = AVPlayerLayer.init(player: self.avPlayer)
            avPlayerLayer.frame = CGRect(x:0,y:300,width:SCREENWIDTH,height:SCREENWIDTH * 9 / 16)
            avPlayerLayer.borderColor = UIColor.red.cgColor
            avPlayerLayer.borderWidth = 3
            self.view.layer.addSublayer(avPlayerLayer)
            self.avPlayer.volume  = 0.3
            
        }


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.view = nil //针对AVPlayer 若在退出播放器页面时,若未将放置该AVPlayer的view置为nil,则其内存不会被释放,会出现多个声音来源
        //下面这两个方法 貌似释放 AVPlayer无效
        avPlayer.currentItem?.cancelPendingSeeks()
        avPlayer.currentItem?.asset.cancelLoading()
        
        //以上两种 方法 貌似均无效
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
