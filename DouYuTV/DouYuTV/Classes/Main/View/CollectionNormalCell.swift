//
//  CollectionNormalCell.swift
//  DouYuTV
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    //MARK:- 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    //MARK:- 定义模型属性
  override  var anchor : AnchoModel?{
        didSet{//监听属性发生变化

            //1、将属性传递给父类
            super.anchor = anchor
            //2、房间名称显示
            roomNameLabel.text = anchor?.room_name

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
