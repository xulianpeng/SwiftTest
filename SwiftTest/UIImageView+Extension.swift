//
//  UIImageView+Extension.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/8.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    
    
    /// 创建UIImageView
    ///
    /// - Parameters:
    ///   - superView: 父试图
    ///   - corner: 角度
    ///   - contentmode:
    ///   - snapMaker: 约束
    func xlpInitImageView(_ superView:UIView,corner:CGFloat,contentmode:UIViewContentMode,snapMaker:WMSnapMakerBlock) -> Void {
        
        superView.addSubview(self)
        self.snp.makeConstraints(snapMaker)
        self.layer.cornerRadius = corner
        self.layer.masksToBounds = true
        //ScaleToFill为将图片按照整个区域进行拉伸(会破坏图片的比例) 默认
        //ScaleAspectFit将图片等比例拉伸，可能不会填充满整个区域
        //ScaleAspectFill将图片等比例拉伸，会填充整个区域，但是会有一部分过大而超出整个区域。
        //至于Top,Left,Right等等就是将图片在view中的位置进行调整。
        self.contentMode = contentMode
    }
    
    /// 创建UIImageView contentmode为scaleAspectFit
    ///
    /// - Parameters:
    ///   - superView: <#superView description#>
    ///   - corner: <#corner description#>
    ///   - snapMaker: <#snapMaker description#>
    func xlpInitImageView(_ superView:UIView,corner:CGFloat,snapMaker:WMSnapMakerBlock) -> Void {
        
        xlpInitImageView(superView, corner: corner, contentmode: .scaleAspectFit, snapMaker: snapMaker)
    }
    
    /// 创建UIImageView 并添加一个本地图片
    ///
    /// - Parameters:
    ///   - name: 图片名称
    ///   - superView: <#superView description#>
    ///   - corner: <#corner description#>
    ///   - snapMaker: <#snapMaker description#>
    func xlpInitImageView(_ name:String,superView:UIView,corner:CGFloat,snapMaker:WMSnapMakerBlock) -> Void {

        xlpInitImageView(superView, corner: corner, contentmode: .scaleToFill, snapMaker: snapMaker)
        self.image = kImageWithName(name)
        
    }
    
    /// imageView 加载网络图片
    ///
    /// - Parameters:
    ///   - urlStr: 图片网址字符串
    ///   - placeholder: 占位图名字
    ///   - options: 动画类型选择 圆角 指定目标尺寸可以做原图
    func xlpSetImage(_ urlStr:String,placeholder:String,options:KingfisherOptionsInfo) -> Void {
        
        let url:URL = URL.init(string: urlStr)!
        let resource = ImageResource(downloadURL: url, cacheKey: nil)
        self.kf.setImage(with: resource, placeholder: kImageWithName(placeholder), options: options, progressBlock: nil, completionHandler: nil)
    }
    
    /// 加载网络图片带默认的动画效果
    ///
    /// - Parameters:
    ///   - urlStr: 图片网址字符串
    ///   - placeholder: 占位图名字
    func xlpSetImage(_ urlStr:String,placeholder:String) -> Void {
        
        self.xlpSetImage(urlStr, placeholder: placeholder, options: [.transition(.fade(1))])
    }
    /// 加载网络图片 生成圆角的图片
    ///
    /// - Parameters:
    ///   - urlStr: <#urlStr description#>
    ///   - placeholder: <#placeholder description#>
    ///   - cornerRadius: 角度参数
    func xlpSetImage(_ urlStr:String,placeholder:String,WithCornerRadius:CGFloat) -> Void {
        
        self.xlpSetImage(urlStr, placeholder: placeholder, options: [
            .transition(.fade(1)),
            .processor(RoundCornerImageProcessor(cornerRadius:WithCornerRadius))
            ])
    }
    
    
    /// 加载网络图片 生成圆形图片
    ///
    /// - Parameters:
    ///   - urlStr: <#urlStr description#>
    ///   - placeholder: <#placeholder description#>
    ///   - diameter: 直径 须为整数最好是2的倍数  大小 > imageview的最短边,否则会出现模糊的现象
    func xlpSetImageCircle(_ urlStr:String,placeholder:String,diameter:Int) -> Void {
        
        
        let aWidth = CGFloat(diameter)
        let corner = CGFloat(diameter/2)
        
        self.xlpSetImage(urlStr, placeholder: placeholder, options: [
            .transition(.fade(1)),
            .processor(RoundCornerImageProcessor(cornerRadius:corner,targetSize:CGSize(width:aWidth,height:aWidth)))
            ])
//        self.contentMode = [.scaleAspectFit,.center] //在OC可以这样使用,但在swift不可以使用 只能选择一个
        self.contentMode = .scaleAspectFit
    }
    
    
}
