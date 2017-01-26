//
//  CCDemoViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/18.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit


//账户信息
let DWACCOUNT_USERID = "F35C60C9C3AA322A"

let DWACCOUNT_APIKEY = "1TznZGlCpiwc51gF8CsOzUWkEyS4aEDL"

class CCDemoViewController: XLPBaseViewController {

    let DWPlayer = DWMoviePlayerController.init(userId: DWACCOUNT_USERID, key: DWACCOUNT_APIKEY)
    var playUrls = NSDictionary()
    
    var videoId = String()
    
    var currentPlayUrl = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initPlayer()
        
    }

    func initPlayer() {
        
        view.addSubview((DWPlayer?.view)!)
        DWPlayer?.view.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(64)
            make.height.equalTo(SCREENWIDTH * 9 / 16)
        })
        
        self.DWPlayer?.videoId = "54005B679D6383B19C33DC5901307461";
        self.DWPlayer?.timeoutSeconds = 10;
        
        self.DWPlayer?.getPlayUrlsBlock = {
            playDic in
            //解析字典 并创建新的字典
            print("=====啦啦啦啦年会来了===\(playDic?["qualityDescription"])")
            
            var dic = Dictionary<String,Any>()
            
            dic["defaultquality"] = playDic?["defaultquality"]
            dic["qualities"] = playDic?["qualities"]
            dic["qualityDescription"] = playDic?["qualityDescription"]
            dic["status"] = playDic?["status"]
            dic["statusinfo"] = playDic?["statusinfo"]
            
            self.resetViewContent(dic: dic)
            
        }
        self.DWPlayer?.startRequestPlayInfo()
        
        
    }
    
    func resetViewContent( dic:[String:Any])
    {
    // 获取默认清晰度播放url
    let defaultquality:Int = dic["defaultquality"] as! Int
    
    let arr = dic["qualities"]!
        
    let dicArr1 = arr as! [Any]
        
        
    //connot convert value of type Array<_> to specifled type Array
        //cannot convert value of type Any? to type Array<_> in coercion
        for playurlDic in dicArr1 {
            
            let playurlDic1 = playurlDic as! Dictionary<String,Any>
            
            
            
            if (defaultquality == playurlDic1["quality"] as! Int ) {
                self.currentPlayUrl = playurlDic1["playurl"] as! String
                break;
            }
        }
    
//    if (!self.currentPlayUrl) {
//    self.currentPlayUrl = [[self.playUrls objectForKey:@"qualities"] objectAtIndex:0];
//    }
    print("currentPlayUrl: %@", self.currentPlayUrl)
    
//    if (self.videoId) {
//    [self resetQualityView];
//    }
    
    self.DWPlayer?.prepareToPlay()
    
    self.DWPlayer?.play()
    
    
    print("play url: %@", self.DWPlayer?.originalContentURL);
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
