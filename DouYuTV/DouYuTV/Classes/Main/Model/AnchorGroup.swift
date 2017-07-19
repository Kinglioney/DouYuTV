//
//  AnchorGroup.swift
//  DouYuTV
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //该组中对应的房间信息
    var room_list : [[String : NSObject]]?{
        didSet{
            guard let room_list = room_list else{return}
            for dic in room_list {
                anchors.append(AnchoModel(dic:dic))
            }
        }
    }
    //组显示的标题
    var tag_name : String = ""
    //组显示的图标
    var icon_name : String = "home_header_normal"
    //定义主播模型对象数组
    lazy var anchors : [AnchoModel] = [AnchoModel]()

    //MARK - 定义词典转模型的构造函数
   convenience init(dic : [String : Any]) {
        self.init()
        //super.init()
        setValuesForKeys(dic)
    }
    //还有很多属性没有转换所有需要重写forUndefinedKey这个方法不然会报错
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }


}
