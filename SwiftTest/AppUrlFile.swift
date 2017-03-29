
//
//  AppUrlFile.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/24.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import Foundation

///数据库中表名的声明

let kTableModuleList = "moduleTable"
let kTableToolSeriesHearthStone = "SeriesHearthstone"
let kTableToolPackageHearthStone = "PackageHearthStone"




let bundleNumber = "500"
let kServerAddressOnLine = "http://www.iyingdi.com" //新的线上服
let urlGetModuleList = kServerAddressOnLine + "/article/module/list?visible=1&version=500&timeout=0&system=ios"

let urlGetArticleList = kServerAddressOnLine + "/article/list"
		
let urlGetToolHearthStone = kServerAddressOnLine + "/series/package/hearthstone/check"
//+ "timestamp=1490608149&version=510&tags=标准模式,狂野模式,衍生物数据包&token=\(kToken)"
