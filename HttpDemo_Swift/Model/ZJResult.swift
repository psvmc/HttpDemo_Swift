//
//  ZJResult.swift
//  HttpDemo_Swift
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

import Foundation
import ObjectMapper
class ZJResult<T: Mappable>: Mappable {
    var success: String!
    var msg: String!
    var obj: T?
    
    
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        success     <- map["success"]
        msg         <- map["msg"]
        obj         <- map["obj"]
    }
}