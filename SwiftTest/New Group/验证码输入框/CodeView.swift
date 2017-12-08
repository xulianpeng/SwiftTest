//
//  CodeView.swift
//  SwiftTest
//
//  Created by xulianpeng on 2017/12/7.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

/**思路: 分为连续的 和 不连续的, 连续时 先画长方形,再画里面的分割线. 不连续的 则获取各个小长方形的rect ,然后逐个画**/
/**根据传进来的 frame, 间隔大小, 验证码的个数 来最终确定 其宽度 以及连续与否 **/
//优化方向: 可以输入明文 ,支持数字 字符 特殊符号 之类的
//优化方向: 光标动画 实现

//文本内容发生改变时调用
@objc protocol CodeViewDelegate {
    //文本发生改变(插入或删除)时调用
    @objc optional func passwordView(textChanged: String, length: Int)
    
    //输入完成(输入的长度与指定的密码最大长度相同)时调用
    func passwordView(textFinished: String)
}
class CodeView: UIView,UIKeyInput {

    
    var XlpSecureTextEntry:Bool = false
    
    
    
    var characterArray = [String]()
    
    
    //输入的文本
    private var text: NSMutableString = ""{
        
        willSet{
            self.text = newValue
            
//            characterArray.removeAll()
//            text.enumerateSubstrings(in: NSMakeRange(0,text.length), options: NSString.EnumerationOptions.byComposedCharacterSequences) { (substring, substringRange, enclosingRange, stopBool) in
//
//                if self.characterArray.count < self.maxLength{
//
//                    self.characterArray.append(substring!)
//
//                }
//
//            }
            
            
            setNeedsDisplay()
        }
    }
    
    //文本发生改变时的代理
    var delegate: CodeViewDelegate?
    
    
    var borderColor:UIColor = UIColor.black{
        willSet{
            self.borderColor = newValue
            setNeedsDisplay()
        }
        
    }
    
    var borderRadius:CGFloat = 5
    var borderWidth:CGFloat = 1
    var pointColor = UIColor.black{
        willSet{
            self.pointColor = newValue
            setNeedsDisplay()
        }
    }
    
    /**>=2 是不连续的, <2 是连续的**/
    var unitSpace:CGFloat = 0 {
    
        willSet{
            
            self.unitSpace = newValue
            setNeedsDisplay()
            
        }
        didSet{
            
        }
        
    }
    
    
    
    //密码最大长度
    var maxLength: Int = 5
    
    var hasText: Bool {
        return text.length > 0
    }
    
    func insertText(_ text: String) {
        if self.text.length < maxLength {
            self.text.append(text)
            delegate?.passwordView?(textChanged: self.text as String, length: self.text.length)
            
            self.characterArray.removeAll()
            self.text.enumerateSubstrings(in: NSMakeRange(0,self.text.length), options: NSString.EnumerationOptions.byComposedCharacterSequences) { (substring, substringRange, enclosingRange, stopBool) in
                
                if self.characterArray.count < self.maxLength{
                    
                    self.characterArray.append(substring!)
                }
            }
            
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
            
            self.characterArray.removeAll()
            self.text.enumerateSubstrings(in: NSMakeRange(0,self.text.length), options: NSString.EnumerationOptions.byComposedCharacterSequences) { (substring, substringRange, enclosingRange, stopBool) in
                
                if self.characterArray.count < self.maxLength{
                    
                    self.characterArray.append(substring!)
                }
            }
            
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let unitSize:CGSize = CGSize(width:(rect.size.width + unitSpace) / CGFloat(maxLength) - unitSpace,height:rect.size.height)

        //获取小矩形的 size 上面的计算方法 感觉不准确啊 ,->实际测试后 上面准确 下面的计算不准确  什么情况,暂时不做处理
        
//        //分2种情况 // 连续 不连续
//        var unitSize:CGSize = CGSize.zero
//        //连续
//        if unitSpace < 2 {
//
//            let lastWidth:CGFloat = rect.size.width - CGFloat(maxLength - 1) * borderWidth - borderWidth * 4.0
//            unitSize = CGSize(width:lastWidth / CGFloat(maxLength),height:rect.size.height)
//
//        }else{
//
//            let lastWidth:CGFloat = rect.size.width - CGFloat(maxLength * 2) * borderWidth - unitSpace *  CGFloat(maxLength - 1)
//            unitSize = CGSize(width:lastWidth / CGFloat(maxLength),height:rect.size.height)
//
//        }
        
        
        
        
    
        fillRect(context: context, rect: rect, clip: true)
        drawBorder(context: context, rect: rect, unitSize: unitSize)
        drawTrackBorder(context: context, rect: rect, unitSize: unitSize)
        
    }
 
    //绘制画布
    
    func fillRect(context:CGContext,rect:CGRect,clip:Bool) {
        
        
        /************本区域代码 画长方形 *************/
        let bezierPath: UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius:borderRadius)
        bezierPath.lineWidth = borderWidth * 2
        context.addPath(bezierPath.cgPath)
        
        //区域内的颜色设置
        (self.backgroundColor != nil ? self.backgroundColor! : UIColor.white).setFill()
        context.fillPath()
        
        if clip {
              //当 是连续的时候 需要画出周长
            if unitSpace < 2{
                //画笔颜色设置
                borderColor.setStroke()
                bezierPath.stroke()
            }
        }
        /*************************/
        
        //但是通过实际测试发现 上面的代码 如果 bezierPath.lineWidth = borderWidth  则周长 明显比 中间的分割线 细  ,期初的解决办法是 添加下面的代码, 效果是在原有的长方形内部 又画了一个长方形 但是边重合 显示的就粗了 ,所以就想 画第一个长方形的时候 边 设置的粗点 为原来的2倍 ,bezierPath.lineWidth = borderWidth * 2
//        let bezierPath0: UIBezierPath = UIBezierPath(roundedRect: rect.insetBy(dx:borderWidth * 0.5 , dy:borderWidth * 0.5 ), cornerRadius:borderRadius)
//        context.addPath(bezierPath0.cgPath)
        
        
        
    }
    
    //MAKR:根据间隔的大小, >=2 画 不连续的 输入框   ,<2 画连续的输入框
    
    func drawBorder(context:CGContext,rect:CGRect,unitSize:CGSize) {
        
        if (unitSpace < 2) {
           
            let width = unitSize.width

            context.setLineWidth(borderWidth)//CGContextSetLineWidth(_ctx, _borderWidth);
            context.setLineCap(.round) //CGContextSetLineCap(_ctx, kCGLineCapRound);
            
            let bezierPath = UIBezierPath()

            (1..<maxLength).forEach { (index) in
                
                bezierPath.move(to: CGPoint(x: rect.origin.x + CGFloat(index) * width, y: rect.origin.y))
                bezierPath.addLine(to: CGPoint(x: rect.origin.x + CGFloat(index) * width, y: rect.origin.y + rect.height))
            }
            context.addPath(bezierPath.cgPath)
            
            context.setStrokeColor(self.borderColor.cgColor)
            context.strokePath()   //CGContextDrawPath(_ctx, kCGPathStroke);
            
            
            drawText(context: context, rect: rect, unitSize: unitSize)
        }
        
    }
    
    
    //画text
    func drawText(context:CGContext,rect:CGRect,unitSize:CGSize) {
        
        let width = unitSize.width
        
        //xlp 此处不能使用 maxLength
        (0..<self.text.length).forEach { (index) in
            
            if XlpSecureTextEntry{
                //画圓点
                let pointSize = CGSize(width: width * 0.2, height: width * 0.2)
                let origin = CGPoint(x: rect.origin.x + CGFloat(index) * width + (width - pointSize.width) / 2, y: rect.origin.y + (rect.height - pointSize.height) / 2)
                let pointRect = CGRect(origin: origin, size: pointSize)
                
                self.pointColor.setFill()
                context.addEllipse(in: pointRect)
                context.fillPath()
            }else{
                
                if index > characterArray.count - 1{
                    return
                }
                
                let attrDic = [NSAttributedStringKey.foregroundColor:UIColor.black,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)]
                let subString:NSString = characterArray[index] as NSString
                let oneTextSize:CGSize = subString.size(withAttributes: attrDic)
                
                let origin = CGPoint(x: rect.origin.x + CGFloat(index) * width + (width - oneTextSize.width) / 2, y: rect.origin.y + (rect.height - oneTextSize.height) / 2)
                
                let oneTextRect = CGRect(origin: origin, size: oneTextSize)
                
//                let oneTextRect:CGRect = indexRect.insetBy(dx:(indexRect.size.width - oneTextSize.width)/2, dy: (indexRect.size.height - oneTextSize.height)/2)
                
                subString.draw(in: oneTextRect, withAttributes: attrDic)
                
            }
            
        }
    }
    
    //MAKR:根据间隔的大小, >=2 画 不连续的 输入框   ,<2 画连续的输入框
    
    func drawTrackBorder(context:CGContext,rect:CGRect,unitSize:CGSize) {
        
        if (unitSpace < 2) {return}
        
        
        //unitRect数组
        
        var unitRectArr = [CGRect]()
        
        
          context.setLineWidth(borderWidth)//CGContextSetLineWidth(_ctx, _borderWidth);
          context.setLineCap(.round) //CGContextSetLineCap(_ctx, kCGLineCapRound);

        (0..<maxLength).forEach { (index) in
            
            let unitRectOrigin : CGPoint = CGPoint(x:CGFloat(index) * (unitSize.width + unitSpace),y:0)
            let unitRectSize:CGSize = CGSize(width:unitSize.width,height:unitSize.height)
            var unitRect:CGRect = CGRect(origin: unitRectOrigin, size: unitRectSize)
            unitRect = unitRect.insetBy(dx:borderWidth * 0.5 , dy:borderWidth * 0.5 )
            
            let bezierPath: UIBezierPath = UIBezierPath(roundedRect: unitRect, cornerRadius:borderRadius)
            context.addPath(bezierPath.cgPath)
            
            unitRectArr.append(unitRect)
        }
        //画笔颜色
        context.setStrokeColor(self.borderColor.cgColor) //不设置该行代码 则 默认为 黑色
        context.strokePath()
        
        drawText(context: context, rect: rect, unitSize: unitSize, unitSizeArr: unitRectArr)
    }
  

    //画text
    func drawText(context:CGContext,rect:CGRect,unitSize:CGSize,unitSizeArr:[CGRect]) {
        
        
        
        let width = unitSize.width
       
        //xlp 此处不能使用 maxLength
        (0..<self.text.length).forEach { (index) in
            
            if index >= unitSizeArr.count{
                return
            }
            
            let indexRect = unitSizeArr[index]
            
            //画圓点
            if XlpSecureTextEntry{
                let pointSize = CGSize(width: width * 0.2, height: width * 0.2)
                let origin = CGPoint(x: indexRect.origin.x + width/2 - pointSize.width / 2, y: indexRect.origin.y + (indexRect.height - pointSize.height) / 2)
                let pointRect = CGRect(origin: origin, size: pointSize)
                self.pointColor.setFill()
                context.addEllipse(in: pointRect)
                context.fillPath()
            }else{
                
                if index > characterArray.count - 1{
                    return
                }
                
                let attrDic = [NSAttributedStringKey.foregroundColor:UIColor.black,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)]
                let subString:NSString = characterArray[index] as NSString
                let oneTextSize:CGSize = subString.size(withAttributes: attrDic)
                let oneTextRect:CGRect = indexRect.insetBy(dx:(indexRect.size.width - oneTextSize.width)/2, dy: (indexRect.size.height - oneTextSize.height)/2)
                subString.draw(in: oneTextRect, withAttributes: attrDic)
  
            }
           

            
            
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
