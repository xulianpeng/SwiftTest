//
//  CodeView0.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/12/7.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

//文本内容发生改变时调用
@objc protocol CodeView0Delegate {
    //文本发生改变(插入或删除)时调用
    @objc optional func passwordView(textChanged: String, length: Int)
    
    //输入完成(输入的长度与指定的密码最大长度相同)时调用
    func passwordView(textFinished: String)
}

class CodeView0: UIView,UIKeyInput {

    //输入的文本
    private var text: NSMutableString = ""
    
    //文本发生改变时的代理
    var delegate: CodeView0Delegate?
    
    //密码最大长度
    var maxLength: Int = 6
    
    var hasText: Bool {
        return text.length > 0
    }
    
    func insertText(_ text: String) {
        if self.text.length < maxLength {
            self.text.append(text)
            delegate?.passwordView?(textChanged: self.text as String, length: self.text.length)
            setNeedsDisplay()
            if self.text.length == maxLength {
                self.resignFirstResponder()
                delegate?.passwordView(textFinished: self.text as String)
            }
        }
    }
    
    func deleteBackward() {
        if self.text.length > 0 {
            self.text.deleteCharacters(in: NSRange(location: text.length - 1, length: 1))
            delegate?.passwordView?(textChanged: self.text as String, length: self.text.length)
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let width = rect.width / CGFloat(maxLength) //每一个小格子的宽度
        context.setStrokeColor(UIColor.green.cgColor)
        context.setLineWidth(1)
        //外边框
        context.stroke(rect)
        let path = UIBezierPath()
        //画中间分隔的竖线
        (1..<maxLength).forEach { (index) in
            path.move(to: CGPoint(x: rect.origin.x + CGFloat(index) * width, y: rect.origin.y))
            path.addLine(to: CGPoint(x: rect.origin.x + CGFloat(index) * width, y: rect.origin.y + rect.height))
        }
        context.addPath(path.cgPath)
        context.strokePath()
        //画圓点
        let pointSize = CGSize(width: width * 0.3, height: width * 0.3)
        (0..<self.text.length).forEach { (index) in
            let origin = CGPoint(x: rect.origin.x + CGFloat(index) * width + (width - pointSize.width) / 2, y: rect.origin.y + (rect.height - pointSize.height) / 2)
            let pointRect = CGRect(origin: origin, size: pointSize)
            context.fillEllipse(in: pointRect)
        }
    }
    
    //键盘的样式 (UITextInputTraits中的属性)
    var keyboardType: UIKeyboardType {
        get{
            return .numberPad
        } set{
            
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isFirstResponder {
            becomeFirstResponder()
        }
    }
    

}
