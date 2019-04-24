//
//  CameraViewController.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/13.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class CameraViewController: XLPBaseViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    let bottomImageView = UIImageView()
    
    override func viewDidLoad() {
        
        bottomImageView.xlpInitImageView(self.view, corner: 150,contentmode:UIView.ContentMode.scaleAspectFill) { (make) in
            make.center.equalTo(self.view)
            make.size.equalTo(300)
        }
        
        kInitActionSheetFinal(self, message: "设置头像", first: "现在拍摄", second: "相册选取", firstBlock: { (action) in
            
            self.choicePhotoWithType(type: .camera)
        }) { (action) in
            self.choicePhotoWithType(type: .photoLibrary)
        }
    }
    
    func choicePhotoWithType(type: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(type) {
            let picker = UIImagePickerController.init()
            picker.delegate = self//代理
            picker.sourceType = type//来源
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }else {
            let str: String?
            if type == UIImagePickerController.SourceType.camera {
                str = "摄像头不可用"
            }else
            {
                str = "相册不可用"
            }
            
            kInitAlertEassy(self, title: "温馨提示", message: str!, second: "确定", secondBlock: { (alert) in
                
                
            })
        }
    }
    
    // 选择完毕后获得照片
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        let image:UIImage = info["UIImagePickerControllerEditedImage"] as! UIImage
        // 拍照
        if picker.sourceType == UIImagePickerController.SourceType.camera {
            savePhotoToLibrary(image: info["UIImagePickerControllerOriginalImage"] as! UIImage)
        }
        bottomImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    //保存图片到本地
    func savePhotoToLibrary(image: UIImage) {
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
//
    @objc func image(image: UIImage, didFinishSavingWithError: NSError?,contextInfo: AnyObject) {
        if didFinishSavingWithError != nil {
            print("\(didFinishSavingWithError)")
        }else
        {
            print("保存图片成功")
        }
    }
    
   
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
