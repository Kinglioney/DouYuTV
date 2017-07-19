//
//  NSDate-Extension.swift
//  DouYuTV
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation
extension NSDate {
    class func getCurrentTime() -> String{
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
