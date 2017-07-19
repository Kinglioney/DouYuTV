//
//  CollectionPrettyCell.swift
//  DouYuTV
//  颜值模块的自定义cell
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionBaseCell {

    //MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!

    //MARK:- 定义模型属性
    override var anchor: AnchoModel?{
        didSet{//监听属性发生变化

            //1、将属性传递给父类
            super.anchor = anchor
            //2、所在城市显示
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }

    }

}
