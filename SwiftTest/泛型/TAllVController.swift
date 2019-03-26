//
//  TAllVController.swift
//  SwiftTest
//
//  Created by xulianpeng on 2019/3/26.
//  Copyright © 2019 xulianpeng. All rights reserved.
//

import UIKit

class TAllVController: XLPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        var a1 = 3
        var b1 = 4
//        swapTwoInts(&a1, &b1)
//        swapTwoAnys(&a1, &b1)
        swapTwoTs(&a1, &b1)
        print("a1 = ",a1,"b1 = ",b1)
        
        
        var aStack = IntStack.init()
        aStack.push(1)
        aStack.push(2)
        aStack.push(4)
        print("aStack0 =",aStack)
        aStack.pop()
        print("aStack1 =",aStack)
        aStack.pop()
        print("aStack2 =",aStack)
        
        let stringArr = ["cat", "dog", "llama", "parakeet", "terrapin"]
       
        let anyStack = AnyStack.init(items: stringArr)
        let anyItems:[String] = anyStack.items as! [String]
        print("lala==",anyStack,anyItems)

        let tStack = TStack.init(items: stringArr)
        let tItems:[String] = tStack.items
        print("lala==",tStack,tItems)
        //通过以上对比 显然代码提高了类型安全性,且消除了不必要的转换,当然转换过程中的隐藏的失败也就避免了.
        
//        Dictionary
        
        //类型约束实践
        let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]

        if let aindex = findIndex(ofString: "parakeet", in: strings){
            print("最终输出结果为=",aindex)
        }
        
        //扩展为 其他类型的数组
        
        var aStringStack1 = StringStack1.init(items: strings)
        
        let mm = aStringStack1.count
        aStringStack1.append("xulianpeng")
        let mm1 = aStringStack1.count
        
        
        let mm2 = aStringStack1.mysuffix(2)
        print("最终的结果为",mm2) //mm2的类型 是aStringStack1, 其里面的items数组中元素为  后2个元素.
        
        
    }
    
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    func swapTwoStrings(_ a: inout String, _ b: inout String) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func swapTwoTs<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

    func swapTwoAnys(_ a: inout Any, _ b: inout Any) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
//泛型函数
    
    
    
    
    
}
//类型: 指 Class Struct Enum 等类型.
//泛型类型

//自定义一个 Int栈类型 , 属性为 整型数组  方法为 push 入栈 pop出栈
struct IntStack {
    var items:[Int] = [Int]()
    
    mutating func push(_ item:Int) {
        if items.count > 0{
            items.insert(item, at: 0)
        }else{
            items.append(item)
        }
    }
    mutating func pop()  {
        if items.count > 0{
            items.removeLast()
        }
    }
}

struct StringStack {
    var items:[String] = [String]()
    
    mutating func push(_ item:String) {
        if items.count > 0{
            items.insert(item, at: 0)
        }else{
            items.append(item)
        }
    }
    mutating func pop()  {
        if items.count > 0{
            items.removeLast()
        }
    }
}
//使用Any 处理
struct AnyStack {
    var items:[Any] = [Any]()
    
    mutating func push(_ item:Any) {
        if items.count > 0{
            items.insert(item, at: 0)
        }else{
            items.append(item)
        }
    }
    mutating func pop()  {
        if items.count > 0{
            items.removeLast()
        }
    }
}


struct TStack<T> {
    var items:[T] = [T]()
    
    mutating func push(_ item:T) {
        if items.count > 0{
            items.insert(item, at: 0)
        }else{
            items.append(item)
        }
    }
    mutating func pop(_ item:T)  {
        if items.count > 0{
            items.removeLast()
        }
    }
}

struct ElementStack<Element> {
    var items:[Element] = [Element]()
    
    mutating func push(_ item:Element) {
        if items.count > 0{
            items.insert(item, at: 0)
        }else{
            items.append(item)
        }
    }
    mutating func pop(_ item:Element)  {
        if items.count > 0{
            items.removeLast()
        }
    }
}
extension ElementStack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    } //该属性 topItem为计算属性
}

//MARK: 类型约束实践
//在一个 String 数组中查找给定 String 值的索引。若查找到匹配的字符串,则返回index 否则返回nil
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
/*
 由上面尝试写一个泛型函数 发现报错 ,不是所有的 Swift 类型都可以用等式符（==）进行比较
func findIndex<T>(ofString valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind { //Binary operator '==' cannot be applied to two 'T' operands
            return index
        }
    }
    return nil
}
*/
//Swift 标准库中定义了一个 Equatable 协议，该协议要求任何遵循该协议的类型必须实现等式符（==）及不等符（!=），从而能对该类型的任意两个值进行比较。
//所有的 Swift 标准类型自动支持 Equatable 协议。
//任何 Equatable 类型都可以安全地使用在 findIndex(of:in:) 函数中，因为其保证支持等式操作符。为了说明这个事实，当你定义一个函数时，你可以定义一个 Equatable 类型约束作为类型参数定义的一部分
func findIndex<T:Equatable>(ofString valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

//MARK:关联类型
/*定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。你可以通过 associatedtype 关键字来指定关联类型。
 */
//MARK:关联类型实践
//下面例子定义了一个 Container 协议，该协议定义了一个关联类型 Item：
protocol ContainerProtocol {
    associatedtype Item
    
    mutating func append(_ item:Item)
    var count:Int{get}
    subscript(i:Int)->Item{get}
}
/*
 该协议要求 遵守该协议的类型 必须实现的3个函数
 必须通过 append方法添加一个新元素到类型里
 可以通过count属性获取类型中的元素的数量,并返回 一个Int值
 可以通过索引值类型e为Int的下标检索到类型中的每一个元素
 */
/*这个协议没有指定容器中元素该如何存储，以及元素必须是何种类型。这个协议只指定了三个任何遵从 Container 协议的类型必须提供的功能。遵从协议的类型在满足这三个条件的情况下也可以提供其他额外的功能。
 
 任何遵从 Container 协议的类型必须能够指定其存储的元素的类型，必须保证只有正确类型的元素可以加进容器中，必须明确通过其下标返回的元素的类型。*/

struct StringStack1 {
    
    
    var items:[String] = [String]()
    
    mutating func push(_ item:String) {
        if items.count > 0{
            items.insert(item, at: 0)
        }else{
            items.append(item)
        }
    }
    mutating func pop()  {
        if items.count > 0{
            items.removeLast()
        }
    }
}
extension StringStack1:ContainerProtocol{

    typealias Item = String
    mutating func append(_ item: String) {
        self.items.append(item)
    }
    
    var count: Int{
        return self.items.count
    }
    
    subscript(i: Int) -> String {
        return self.items[i]
    }
}

extension ElementStack:ContainerProtocol{
    
    typealias Item = Element
    
    mutating func append(_ item: Element) {
        self.items.append(item)
    }
    
    var count: Int{
        return self.items.count
    }
    subscript(i: Int) -> Element {
        return self.items[i]
    }
    
}

//协议也可以遵从协议

protocol SuffixableContainer:ContainerProtocol {
    
    associatedtype Suffix:SuffixableContainer where Suffix.Item == Item
    func mysuffix(_ size:Int) -> Suffix
    
}
extension StringStack1:SuffixableContainer{
    
    func mysuffix(_ size: Int) -> StringStack1 {
        
        var result = StringStack1()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
}

