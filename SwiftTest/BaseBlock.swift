//
//  BaseBlock.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/8.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON


/// 全局的 闭包 避免重复设置 闭包 
typealias WMVoidBlock = () -> Void
typealias WMSnapMakerBlock = (ConstraintMaker) -> Void

typealias WMButtonClickBlock = (_ sender:UIButton) -> Void
typealias WMButtonIndexClickBlock = (_ sender:UIButton,_ index:NSInteger) -> Void

typealias WMTapBlock = (_ sender:UITapGestureRecognizer) -> Void
typealias WMGestureBlock = (_ sender:UIGestureRecognizer) -> Void

typealias WMStringBlock = (_ result:String) -> Void

typealias WMErrorBlock = (_ error:String) -> Void

typealias WMIntBlock = (_ resultInt:Int) -> Void

typealias WMFloatBlock = (_ resultFloat:Float) -> Void

typealias WMBoolBlock = (_ resultBool:Bool) -> Void
typealias WMArrayBlock = (_ resultArray:Array<Any>) -> Void
typealias WMDictionaryBlock = (_ resultDic:Dictionary<String, Any>) -> Void



//网络相关的回调
typealias successClosure = (_ response : [String:Any])->Void//舍弃
typealias failureClosure = (_ error : Error )->Void //舍去

typealias WMNetFinishBlock = (_ success:JSON?,_ error:Error?) -> Void
typealias WMNetSucceedBlock = (_ success:JSON)->Void
