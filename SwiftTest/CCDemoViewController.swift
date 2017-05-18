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

class CCDemoViewController: XLPBaseViewController,UIScrollViewDelegate {

    let ccPlayerHeight = kSCREENWIDTH * 9 / 16
    
    let DWPlayer = DWMoviePlayerController.init(userId: DWACCOUNT_USERID, key: DWACCOUNT_APIKEY)
    var playUrls = NSDictionary()
    
    var videoId = String()
    
    var currentPlayUrl = String()
    
    
    //MARK: 下半部 章节 笔记 问答 三个view
    
    var bannerView = UIView()// 设置 章节 笔记 问答 标签区
    
    var chapterBt = UIButton()
    var noteBt = UIButton()
    var questionBt = UIButton()
    
    var triangleView = UIImageView() //切换的小图标 三角符号
    
    var bottomView = UIScrollView() //底部容器视图
    var chapterView = UITableView()
    var noteView = UITableView()
    var questionView = UITableView()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initPlayer()
        
        
        initBottomView()
        
    }

    func initPlayer() {
        
        view.addSubview((DWPlayer?.view)!)
        DWPlayer?.view.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(64)
            make.height.equalTo(ccPlayerHeight)
        })
        
        self.DWPlayer?.videoId = "34981E63A3ECA2F69C33DC5901307461";
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
    print("=====currentPlayUrl: %@", self.currentPlayUrl)
    
//    if (self.videoId) {
//    [self resetQualityView];
//    }
    
    self.DWPlayer?.prepareToPlay()
    
    self.DWPlayer?.play()
    
    
    print("play url: %@", self.DWPlayer?.originalContentURL ?? "什么鬼");
        
    }
    
    //MARK:初始化 下半部UI
    func initBottomView() {
        
        bannerView.xlpInitView(superView: self.view) { (make) in
            make.top.equalTo(64 + self.ccPlayerHeight)
            make.left.right.equalTo(0)
            make.height.equalTo(40)
        }
        bannerView.backgroundColor = UIColor.yellow
//        bannerView.contentSize = 
        
        chapterBt.xlpInitFianlButton("章节", titleColor: UIColor.black, fontSize: 13, superView: bannerView, snpMaker: { (make) in
            make.left.equalTo(20)
            make.top.equalTo(3)
            make.bottom.equalTo(-3)
        }) { (bt) in
            
            //点击事件  下半部分切换  其余2个按钮  字体颜色改变   三角符号 移动
            
            //单独的remakeConstraints 动画  和 添加 uivew动画 没有区别的 所以可以舍弃
            
            self.triangleView.snp.remakeConstraints({ (make) in
                make.centerX.equalTo(self.chapterBt.snp.centerX)
                make.top.equalTo(self.chapterBt.snp.bottom).offset(3)
                make.size.equalTo(CGSize(width:30,height:30))
                
            })
//            UIView.animate(withDuration: 0.3, animations: {
//                
//                
//            })
           
            self.chapterBt.setTitleColor(UIColor.cyan, for: .normal)
            self.noteBt.setTitleColor(UIColor.black, for: .normal)
            self.questionBt.setTitleColor(UIColor.black, for: .normal)
            
            self.changeScrollview(0)
            
        }
        noteBt.xlpInitFianlButton("笔记", titleColor: UIColor.black, fontSize: 13, superView: bannerView, snpMaker: { (make) in
            make.center.equalTo(bannerView.snp.center)
//            make.top.equalTo(3)
//            make.centerX.equalTo(bannerView.snp.centerX)
//            make.bottom.equalTo(-3)
        }) { (bt) in
            
            //点击事件  下半部分切换  其余2个按钮  字体颜色改变   三角符号 移动
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.triangleView.snp.remakeConstraints({ (make) in
                    make.centerX.equalTo(self.noteBt.snp.centerX)
                    make.size.equalTo(CGSize(width:30,height:30))
                    make.top.equalTo(self.chapterBt.snp.bottom).offset(3)
                    
                })
                
            })
            
            self.chapterBt.setTitleColor(UIColor.black, for: .normal)
            self.noteBt.setTitleColor(UIColor.cyan, for: .normal)
            self.questionBt.setTitleColor(UIColor.black, for: .normal)

            self.changeScrollview(1)
            
        }
//        noteBt.backgroundColor = UIColor.red
        questionBt.xlpInitFianlButton("问答", titleColor: UIColor.black, fontSize: 13, superView: bannerView, snpMaker: { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(3)
            make.bottom.equalTo(-3)
        }) { (bt) in
            
            //点击事件  下半部分切换  其余2个按钮  字体颜色改变   三角符号 移动
            UIView.animate(withDuration: 0.3, animations: {
                
                
                self.triangleView.snp.remakeConstraints({ (make) in
                    make.centerX.equalTo(self.questionBt.snp.centerX)
                    make.size.equalTo(CGSize(width:30,height:30))
                    make.top.equalTo(self.chapterBt.snp.bottom).offset(3)
                    
                })
            })
            
            self.chapterBt.setTitleColor(UIColor.black, for: .normal)
            self.noteBt.setTitleColor(UIColor.black, for: .normal)
            self.questionBt.setTitleColor(UIColor.cyan, for: .normal)

            self.changeScrollview(2)
        
        }
//        questionBt.backgroundColor = UIColor.red
        
        
        triangleView.xlpInitImageView("triangle", superView: self.bannerView, corner: 2) { (make) in
            
            make.top.equalTo(chapterBt.snp.bottom).offset(3)
            make.centerX.equalTo(chapterBt.snp.centerX)
            make.size.equalTo(CGSize(width:30,height:30))
            
        }
        self.chapterBt.setTitleColor(UIColor.cyan, for: .normal)

//MARK: 下面3个view的初始化
        bottomView.xlpInitView(superView: self.view) { (make) in
            make.top.equalTo(self.bannerView.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(kSCREENHEIGHT - 64 - self.ccPlayerHeight - 40)
        }
        
        bottomView.contentSize = CGSize(width:kSCREENWIDTH * 3,height:kSCREENHEIGHT - 64 - self.ccPlayerHeight - 40)
        
        bottomView.isPagingEnabled = true
        bottomView.bounces = false
        bottomView.delegate = self
        
        
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("===此时此刻的偏移量为多少呢==\(scrollView.contentOffset.x / kSCREENWIDTH)===\(scrollView.contentOffset.y)")
        
        let page = Int(scrollView.contentOffset.x / kSCREENWIDTH)
        
        
        switch page {
        case 0:
            changeLabelColor(0)
        case 1:
            changeLabelColor(1)
        case 2:
            changeLabelColor(2)
        default:
            break
        }
        
    }
    
    func changeLabelColor(_ index:Int)  {
        
        let btArr = [chapterBt,noteBt,questionBt]
        
        let bt = btArr[index]
        
        bt.setTitleColor(UIColor.cyan, for: .normal)
        
        for mbt in btArr {
            
            if mbt != bt {
                mbt.setTitleColor(UIColor.black, for: .normal)
            }
        }
        
        
        self.triangleView.snp.remakeConstraints({ (make) in
            make.centerX.equalTo(bt.snp.centerX)
            make.size.equalTo(CGSize(width:30,height:30))
            make.top.equalTo(self.chapterBt.snp.bottom).offset(3)
            
        })
        
        
    }
    
    func changeScrollview(_ index:CGFloat)  {
        
//        self.bottomView.contentOffset = CGPoint(x:index * kSCREENWIDTH,y:0)
        self.bottomView.setContentOffset(CGPoint(x:(index * kSCREENWIDTH),y:0), animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
