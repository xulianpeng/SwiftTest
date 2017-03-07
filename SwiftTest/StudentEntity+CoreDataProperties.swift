//
//  StudentEntity+CoreDataProperties.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/7.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import Foundation
import CoreData


extension StudentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentEntity> {
        return NSFetchRequest<StudentEntity>(entityName: "StudentEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var sex: String?
    @NSManaged public var age: String?

}
