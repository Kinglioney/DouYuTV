//
//  CycleModel.swift
//  DouYuTV
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    //MARK:- 定义属性
    //标题
     var title : String = ""
    //展示图片
     var pic_url : String = ""
    //主播信息
    var anchor : AnchoModel?

    //MARK:- 自定义构造函数
     init(dic : [String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
