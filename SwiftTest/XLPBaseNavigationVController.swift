//
//  XLPBaseNavigationVController.swi ft
//  SwiftTest
//
//  Created by lianpeng on 2016/12/22.
//  Copyright © 2016年 xulianpeng. All rights reserved.
//

import UIKit

class XLPBaseNavigationVController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        
//        super.pushViewController(viewController, animated: animated)
////        viewController.hidesBottomBarWhenPushed = true
//        //FIXME:有问题
////        self.tabBarController?.tabBar.isHidden = true//有问题
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if self.viewControllers.count == 1 {
//            self.tabBarController?.tabBar.isHidden = false
//        }
//    }
    

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
