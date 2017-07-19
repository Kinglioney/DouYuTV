//
//  AnchoModel.swift
//  DouYuTV
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class AnchoModel: NSObject {
    //房间ID
    var room_id : Int = 0
    //房间图片对应的URL
    var vertical_src : String = ""
    //判断是手机直播还是电脑直播 0是电脑 1是手机
    var isVertical : Int = 0
    //房间名称
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //在线人数
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    //MARK: - 自定义构造函数
    init(dic : [String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
