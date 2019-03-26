//
//  RootTabBarViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/1/12.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class RootTabBarViewController: XLPBaseTabBarController {

    //MARK:坑点: 1 tabbarController  其 标题 与 图片 默认显示 系统原生蓝 ,但项目中一般会要求自定义显示颜色,图片可以设置显示图片本身的 ,但是字体无法实现,所以 常见做法 题目 不设置 ,图片自带题目 ,然后调节图片的位置即可
    //MARK:坑点: 2 一般不给tabbarController设置导航试图控制器,而是给其子视图分别设置导航试图控制器,但这里有一个坑点,若 在子视图直接通过 self.title = "标题",在tabbarcontroller上标题上 就会显示出来
    //FIXME:  针对坑点2  暂时还未找到解决办法 粗暴的解决办法 toolbar自定义
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fourVC  = RootViewController.init(title: "根视图", backColor: UIColor.cyan)
        let naFourVC = XLPBaseNavigationVController.init(rootViewController:fourVC)
        let firstVC  = YingdiToolViewController()
        let naFirstVC = XLPBaseNavigationVController.init(rootViewController:firstVC)
        let threeVC = ShopCityViewController()
        let naThreeVC = XLPBaseNavigationVController.init(rootViewController: threeVC)
        let twoVC = YingDiViewController.init(title: "营地", backColor: UIColor.red)
        let naTwoVC = XLPBaseNavigationVController.init(rootViewController: twoVC)
        
        initTabBarItem(naFirstVC, title: "", imageName: "tool_normal", selectImageName: "tool_select", tag: 1)
        initTabBarItem(naTwoVC, title: "", imageName: "news_normal", selectImageName: "news_select", tag: 2)
        initTabBarItem(naThreeVC, title: "", imageName: "shop_normal",selectImageName:"shop_select",tag:3)
        initTabBarItem(naFourVC, title: "", imageName: "forum_normal",selectImageName:"forum_select",tag:4)

        self.viewControllers = [naFourVC,naFirstVC,naThreeVC,naTwoVC]
        
        
    }

    func initTabBarItem(_ controller:XLPBaseNavigationVController,title:String,imageName:String,selectImageName:String,tag:Int)  {
        
        let noamalImage = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let selectImage = UIImage.init(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem = UITabBarItem.init(title: title, image: noamalImage, tag: tag)
        controller.tabBarItem.selectedImage = selectImage
        controller.tabBarItem.imageInsets = UIEdgeInsets.init(top: 6, left: 0, bottom: -6, right: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
