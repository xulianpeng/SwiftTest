//
//  ZhiHuEntity+CoreDataProperties.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/7.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import Foundation
import CoreData


extension ZhiHuEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ZhiHuEntity> {
        return NSFetchRequest<ZhiHuEntity>(entityName: "ZhiHuEntity");
    }

    @NSManaged public var ga_prefix: String?
    @NSManaged public var id: Int64
    @NSManaged public var images: String?
    @NSManaged public var title: String?
    @NSManaged public var topFlag: Int64
    @NSManaged public var type: Int64

}
