//
//  CodeViewController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/12/7.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
typealias MCNetworkUtilsBlock = (_ resArr:[String],_ success:Bool) -> Void
class CodeViewController: XLPBaseViewController,CodeViewDelegate {
    func passwordView(textFinished: String) {
        //输入完成 改变背景色
        view.backgroundColor = kRandomColor()
    }
    

    var codeView :CodeView!
    
    var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeView = CodeView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        codeView.center = view.center
        codeView.backgroundColor = UIColor.white

        codeView.delegate = self as CodeViewDelegate
        codeView.maxLength = 10
//        codeView.borderColor = UIColor.cyan
        view.addSubview(codeView)
        
        var strArr:[String] = ["123","345","456","46","679"]
        
//        print(strArr.filter{$0.0,0})
        
        
        imageView = UIImageView.init(frame: CGRect(x:20,y:100,width:40,height:40))
        imageView.image = UIImage.init(named: "right_menu_multichat@2x")
//        imageView.backgroundColor = UIColor.red
        self.view.addSubview(imageView)
        
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(beginAnimation))
        imageView.addGestureRecognizer(tap)
        
        
        let searchView = XlpSerachBarView.init(frame: CGRect(x:10,y:250,width:300,height:30))
        self.view.addSubview(searchView)
        
    }
    @objc func beginAnimation(){
        
        print("点我了啊")
        
        UIView.animate(withDuration: 0.3) {
            
            let image:UIImage = UIImage.init(named: "right_menu_multichat@2x")!
            
            let newImage = image.resizableImage(withCapInsets: UIEdgeInsets.init(top: 5, left: image.size.width/5 * 4, bottom: 10, right: image.size.width/5*4), resizingMode: UIImage.ResizingMode.stretch)
//            let newImage = image.resizableImage(withCapInsets: UIEdgeInsetsMake(5, self.imageView.frame.size.width/5 * 4, 10, self.imageView.frame.size.width/5*4), resizingMode: UIImageResizingMode.tile)
            self.imageView.frame = CGRect(x:20,y:100,width:300,height:40)
            self.imageView.image = nil
            self.imageView.image = newImage

            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if codeView.isFirstResponder {
            codeView.resignFirstResponder()
        }
    }

    //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class XlpSerachBarView:UIView,UITextFieldDelegate{
    
    lazy var searchBt:UIButton = {
        let bt = UIButton.init(type:UIButton.ButtonType.custom)
        bt.setImage(UIImage.init(named: "searchIcon"), for: .normal)
        return bt
    }()
    
    lazy var searchImage:UIImageView = {
       
        var imageView = UIImageView.init(frame: CGRect(x:10,y:5,width:30,height:30))
        imageView.image = UIImage.init(named: "searchIcon")
        return imageView
    }()
    lazy var searchTf:UITextField = {
        var tf = UITextField.init(frame: CGRect(x:self.searchImage.frame.origin.x+self.searchImage.frame.size.width + 5,y:5,width:100,height:30))
        tf.delegate = self
        tf.placeholder = "请输入"
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backView = UIView.init(frame: frame)
        backView.layer.cornerRadius = 8
        backView.layer.masksToBounds = true
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(backView)
        
        backView.addSubview(searchImage)
        backView.addSubview(searchTf)
        searchImage.isHidden = true
        searchTf.isHidden = true
        self.searchBt.frame = CGRect(x:frame.size.width - 40,y:5,width:30,height:30)
        backView.addSubview(self.searchBt)
        
        self.searchBt.addTarget(self, action: #selector(showSeachView), for: UIControl.Event.touchUpInside)

        
    }
    @objc func showSeachView()  {
        searchBt.isHidden = true
        searchImage.isHidden = false
        searchTf.isHidden = false
        searchTf.becomeFirstResponder()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
